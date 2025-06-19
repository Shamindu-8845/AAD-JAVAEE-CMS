package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateStatus")
public class UpdateStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {
        // Get logged-in user role from session
        String role = (String) req.getSession().getAttribute("role");

        // Allow only Admin to update status
        if (role == null || !role.equals("Admin")) {
            // Not authorized
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized Access");
            return;
        }

        // If admin, proceed to update
        int complaintId = Integer.parseInt(req.getParameter("complaintId"));
        String status = req.getParameter("status");
        String remarks = req.getParameter("remarks");

        try {
            ComplaintDAO.updateStatus(getServletContext(), complaintId, status, remarks);
            resp.sendRedirect(req.getContextPath() + "/admin_dashboard.jsp?action=showComplaints");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}

