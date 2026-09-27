package com.fsjp.portal.controller;

import com.fsjp.portal.dao.CompanyDAO;
import com.fsjp.portal.dao.InternshipDAO;
import com.fsjp.portal.model.Company;
import com.fsjp.portal.model.Internship;
import com.fsjp.portal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/company-internships")
public class CompanyInternshipServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        Company company = CompanyDAO.findByUserId(user.getId());
        if (company == null) {
            response.sendRedirect(request.getContextPath() + "/company/dashboard.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("delete".equalsIgnoreCase(action)) {
            String internshipId = request.getParameter("internshipId");
            if (internshipId != null && !internshipId.trim().isEmpty()) {
                InternshipDAO.deleteInternship(Integer.parseInt(internshipId));
            }
            response.sendRedirect(request.getContextPath() + "/company/internships.jsp");
            return;
        }

        Internship internship = new Internship();
        String internshipId = request.getParameter("internshipId");
        if (internshipId != null && !internshipId.trim().isEmpty()) {
            internship.setId(Integer.parseInt(internshipId));
        }

        internship.setCompanyId(company.getId());
        internship.setTitle(request.getParameter("title"));
        internship.setDescription(request.getParameter("description"));
        internship.setSkills(request.getParameter("skills"));
        internship.setLocation(request.getParameter("location"));
        internship.setInternshipType(request.getParameter("internshipType"));
        internship.setDuration(request.getParameter("duration"));
        internship.setStipend(request.getParameter("stipend"));
        internship.setRequirements(request.getParameter("requirements"));
        internship.setBenefits(request.getParameter("benefits"));
        internship.setDeadline(request.getParameter("deadline"));
        internship.setStatus("PENDING");

        boolean success;
        if (internship.getId() > 0) {
            success = InternshipDAO.updateInternship(internship);
        } else {
            success = InternshipDAO.createInternship(internship);
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/company/internships.jsp");
        } else {
            request.setAttribute("errorMessage", "Unable to save internship.");
            request.getRequestDispatcher("/company/add-internship.jsp").forward(request, response);
        }
    }
}
