package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.dao.ComplaintDAO;
import org.example.model.Complaint;
import org.example.model.User;

import java.io.IOException;


@WebServlet("/addComplaint")
public class SaveComplaintServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {
        HttpSession session = req.getSession(false);

        User user = (User) session.getAttribute("user");
        if (user == null || !"Employee".equals(user.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }


        int employeeId = (Integer) session.getAttribute("userId"); // get logged-in employee id
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String status = "Pending"; // default status on new complaint
        String date = req.getParameter("date");

        Complaint complaint = new Complaint();
        complaint.setEmployeeId(employeeId);
        complaint.setTitle(title);
        complaint.setDescription(description);
        complaint.setStatus(status);
        complaint.setDate(date);

        try {
            ComplaintDAO.saveComplaint(getServletContext(), complaint);
            resp.sendRedirect(req.getContextPath() + "/employee_dashboard.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

}
