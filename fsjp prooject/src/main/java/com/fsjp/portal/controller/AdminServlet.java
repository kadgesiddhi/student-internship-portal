package com.fsjp.portal.controller;

import com.fsjp.portal.dao.CompanyDAO;
import com.fsjp.portal.dao.InternshipDAO;
import com.fsjp.portal.dao.StudentDAO;
import com.fsjp.portal.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
            return;
        }

        if ("toggle-student".equalsIgnoreCase(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String status = "ACTIVE".equalsIgnoreCase(request.getParameter("status")) ? "INACTIVE" : "ACTIVE";
            UserDAO.updateStatus(userId, status);
        } else if ("approve-company".equalsIgnoreCase(action)) {
            int companyId = Integer.parseInt(request.getParameter("companyId"));
            CompanyDAO.updateApprovalStatus(companyId, "APPROVED");
        } else if ("reject-company".equalsIgnoreCase(action)) {
            int companyId = Integer.parseInt(request.getParameter("companyId"));
            CompanyDAO.updateApprovalStatus(companyId, "REJECTED");
        } else if ("toggle-company-user".equalsIgnoreCase(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String status = "ACTIVE".equalsIgnoreCase(request.getParameter("status")) ? "INACTIVE" : "ACTIVE";
            UserDAO.updateStatus(userId, status);
        } else if ("approve-internship".equalsIgnoreCase(action)) {
            int internshipId = Integer.parseInt(request.getParameter("internshipId"));
            InternshipDAO.updateStatus(internshipId, "APPROVED");
        } else if ("reject-internship".equalsIgnoreCase(action)) {
            int internshipId = Integer.parseInt(request.getParameter("internshipId"));
            InternshipDAO.updateStatus(internshipId, "REJECTED");
        } else if ("toggle-student-user".equalsIgnoreCase(action)) {
            int userId = Integer.parseInt(request.getParameter("userId"));
            String status = "ACTIVE".equalsIgnoreCase(request.getParameter("status")) ? "INACTIVE" : "ACTIVE";
            UserDAO.updateStatus(userId, status);
        }

        response.sendRedirect(request.getContextPath() + "/admin/dashboard.jsp");
    }
}
