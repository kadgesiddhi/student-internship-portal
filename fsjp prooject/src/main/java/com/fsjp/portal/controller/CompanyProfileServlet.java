package com.fsjp.portal.controller;

import com.fsjp.portal.dao.CompanyDAO;
import com.fsjp.portal.model.Company;
import com.fsjp.portal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/company-profile")
public class CompanyProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        Company company = CompanyDAO.findByUserId(user.getId());
        request.setAttribute("company", company);
        request.getRequestDispatcher("/company/profile.jsp").forward(request, response);
    }

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

        company.setCompanyName(request.getParameter("companyName"));
        company.setMobile(request.getParameter("phone"));
        company.setLocation(request.getParameter("location"));
        company.setWebsite(request.getParameter("website"));
        company.setDescription(request.getParameter("description"));

        boolean updated = CompanyDAO.updateCompany(company);
        if (updated) {
            request.setAttribute("successMessage", "Company profile updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Unable to update company profile.");
        }

        request.setAttribute("company", company);
        request.getRequestDispatcher("/company/profile.jsp").forward(request, response);
    }
}
