package org.example.servlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.dao.UserDAO;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost (HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        ServletContext servletContext = getServletContext();

        try {
            User user = UserDAO.findUser(servletContext, email, password);

            if (user != null) {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole());
                session.setAttribute("userId", user.getId());

//                resp.sendRedirect(req.getContextPath() + "/dashboard.jsp");

                if ("Admin".equals(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/admin_dashboard.jsp");
                }else if ("Employee".equals(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/employee_dashboard.jsp");
                }else {
                    req.setAttribute("errorMessage", "Unknown Role");
                    req.getRequestDispatcher("/login.jsp").forward(req, resp);
                }

            }else {
                req.setAttribute("errorMessage", "Invalid email or password");
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

    }

//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        resp.sendRedirect(req.getContextPath() + "/login.jsp");
//    }

}
