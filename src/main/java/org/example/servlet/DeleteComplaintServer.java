package org.example.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.dao.ComplaintDAO;

import java.io.IOException;

@WebServlet("/deleteComplaint")
public class DeleteComplaintServer extends HttpServlet {

    @Override
    protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int complaintId = Integer.parseInt(req.getParameter("complaintId"));

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        Complaint complaint = ComplaintDAO.getComplaintById(getServletContext(), complaintId);

        if (complaint == null) {
            resp.sendRedirect("error.jsp"); // Complaint not found
            return;
        }

        boolean isAdmin = "Admin".equalsIgnoreCase(user.getRole());
        boolean isOwner = complaint.getEmployeeId() == user.getId();
        boolean isNotResolved = !"Resolved".equalsIgnoreCase(complaint.getStatus());

        if (isAdmin || (isOwner && isNotResolved)) {
            ComplaintDAO.deleteComplaint(getServletContext(), complaintId);

            if (isAdmin) {
                resp.sendRedirect("admin_dashboard.jsp");
            } else {
                resp.sendRedirect("employee_dashboard.jsp");
            }
        } else {
            resp.sendRedirect("unauthorized.jsp"); // no permission
        }
    }
}
