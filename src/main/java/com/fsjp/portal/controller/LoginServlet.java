package com.fsjp.portal.controller;

import com.fsjp.portal.dao.UserDAO;
import com.fsjp.portal.model.User;
import com.fsjp.portal.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (email == null || password == null || role == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Email, password, and role are required.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        User user = UserDAO.login(email.trim(), role.toUpperCase());
        if (user != null && "ACTIVE".equalsIgnoreCase(user.getStatus()) && PasswordUtil.verifyPassword(password, user.getPassword())) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(1800);

            if ("STUDENT".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/student/dashboard.jsp");
            } else if ("COMPANY".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/company/dashboard.jsp");
            } else if ("ADMIN".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
            }
            return;
        }

        request.setAttribute("errorMessage", "Invalid email, password, or role.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
