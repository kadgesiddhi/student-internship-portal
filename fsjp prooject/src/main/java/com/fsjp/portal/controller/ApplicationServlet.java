package com.fsjp.portal.controller;

import com.fsjp.portal.dao.ApplicationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/application")
public class ApplicationServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            String applicationIdParam = request.getParameter("applicationId");
            if (applicationIdParam != null && !applicationIdParam.trim().isEmpty()) {
                int applicationId = Integer.parseInt(applicationIdParam);
                if ("SELECT".equalsIgnoreCase(action)) {
                    ApplicationDAO.updateStatus(applicationId, "SELECTED");
                } else if ("REJECT".equalsIgnoreCase(action)) {
                    ApplicationDAO.updateStatus(applicationId, "REJECTED");
                }
                response.sendRedirect(request.getContextPath() + "/company/applications.jsp");
                return;
            }
        }

        response.sendRedirect(request.getContextPath() + "/student/applications.jsp");
    }
}
