package org.example.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.dao.ComplaintDAO;
import org.example.model.Complaint;
import org.example.model.User;

import java.io.IOException;

@WebServlet("/editComplaint")
public class EditComplaintServlet extends HttpServlet {

    @Override
    protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Get logged-in user
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // 2. If not employee, block
        if (user == null || !"Employee".equalsIgnoreCase(user.getRole())) {
            resp.sendRedirect("error_message.jsp");
            return;
        }

        // 3. Get form values
        int complaintId = Integer.parseInt(req.getParameter("complaintId"));
        String description = req.getParameter("description");
        String date = req.getParameter("date");

        try {
            // 4. Get complaint from DB
            Complaint existing = ComplaintDAO.getComplaintById(getServletContext(), complaintId);

            // 5. Check complaint exists + employee owns it + not resolved
            if (existing == null || existing.getEmployeeId() != user.getId() ||
                    "Resolved".equalsIgnoreCase(existing.getStatus())) {
                resp.sendRedirect("error_message.jsp");
                return;
            }

            // 6. Update complaint object
            Complaint updated = new Complaint();
            updated.setComplaintId(complaintId);
            updated.setDescription(description);
            updated.setDate(date);
            updated.setEmployeeId(user.getId());

            // 7. Call DAO to update
            ComplaintDAO.editComplaint(getServletContext(), updated);

            // 8. Redirect to employee dashboard
            resp.sendRedirect("employee_dashboard.jsp");

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
