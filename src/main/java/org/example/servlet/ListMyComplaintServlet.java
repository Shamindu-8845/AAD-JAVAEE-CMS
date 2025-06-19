package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.dao.ComplaintDAO;
import org.example.model.Complaint;
import org.example.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/myComplaints")
public class ListMyComplaintServlet extends HttpServlet {

    @Override
    protected void doGet (HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = (User) req.getSession().getAttribute("user");

        // If user is not logged in, redirect to login
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // Get complaints of logged-in employee
        List<Complaint> complaints = ComplaintDAO.getComplaintsByEmployeeId(getServletContext(), user.getId());

        // Set complaints to request
        req.setAttribute("complaints", complaints);

        // Forward to dashboard_employee.jsp
        req.getRequestDispatcher("/employee_dashboard.jsp").forward(req, resp);
    }
}
