package com.fsjp.portal.controller;

import com.fsjp.portal.dao.CompanyDAO;
import com.fsjp.portal.dao.UserDAO;
import com.fsjp.portal.model.Company;
import com.fsjp.portal.model.User;
import com.fsjp.portal.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/company-register")
public class CompanyRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String companyName = request.getParameter("companyName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String website = request.getParameter("website");
        String description = request.getParameter("description");

        if (companyName == null || email == null || password == null || phone == null || location == null || website == null || description == null ||
                companyName.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty() || phone.trim().isEmpty() || location.trim().isEmpty() || website.trim().isEmpty() || description.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All company details are required.");
            request.getRequestDispatcher("/company-register.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.getRequestDispatcher("/company-register.jsp").forward(request, response);
            return;
        }

        if (UserDAO.findByEmail(email.trim()) != null) {
            request.setAttribute("errorMessage", "Email already exists. Please use another email.");
            request.getRequestDispatcher("/company-register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setEmail(email.trim());
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setRole("COMPANY");
        user.setStatus("ACTIVE");

        if (!UserDAO.createUser(user)) {
            request.setAttribute("errorMessage", "Unable to create company account.");
            request.getRequestDispatcher("/company-register.jsp").forward(request, response);
            return;
        }

        Company company = new Company();
        company.setUserId(user.getId());
        company.setCompanyName(companyName.trim());
        company.setMobile(phone.trim());
        company.setLocation(location.trim());
        company.setWebsite(website.trim());
        company.setDescription(description.trim());
        company.setApprovalStatus("PENDING");

        if (!CompanyDAO.createCompany(company)) {
            request.setAttribute("errorMessage", "Company profile could not be created.");
            request.getRequestDispatcher("/company-register.jsp").forward(request, response);
            return;
        }

        request.setAttribute("successMessage", "Company registration submitted successfully. Admin approval is required.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
