package com.fsjp.portal.controller;

import com.fsjp.portal.dao.StudentDAO;
import com.fsjp.portal.dao.UserDAO;
import com.fsjp.portal.model.Student;
import com.fsjp.portal.model.User;
import com.fsjp.portal.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/student-register")
public class StudentRegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String college = request.getParameter("college");
        String course = request.getParameter("course");
        String year = request.getParameter("year");
        String skills = request.getParameter("skills");

        if (fullName == null || email == null || mobile == null || password == null || confirmPassword == null || college == null || course == null || year == null || skills == null ||
                fullName.trim().isEmpty() || email.trim().isEmpty() || mobile.trim().isEmpty() || password.trim().isEmpty() || confirmPassword.trim().isEmpty() || college.trim().isEmpty() || course.trim().isEmpty() || year.trim().isEmpty() || skills.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            request.setAttribute("errorMessage", "Please enter a valid email address.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        if (!mobile.matches("^[0-9]{10,15}$")) {
            request.setAttribute("errorMessage", "Please enter a valid mobile number.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        if (UserDAO.findByEmail(email.trim()) != null) {
            request.setAttribute("errorMessage", "Email already exists. Please use another email.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setEmail(email.trim());
        user.setPassword(PasswordUtil.hashPassword(password));
        user.setRole("STUDENT");
        user.setStatus("ACTIVE");

        if (!UserDAO.createUser(user)) {
            request.setAttribute("errorMessage", "Unable to create user account. Please try again.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        Student student = new Student();
        student.setUserId(user.getId());
        student.setFullName(fullName.trim());
        student.setMobile(mobile.trim());
        student.setCollege(college.trim());
        student.setCourse(course.trim());
        student.setGraduationYear(year.trim());
        student.setSkills(skills.trim());
        student.setResumeLink("");

        if (!StudentDAO.createStudent(student)) {
            request.setAttribute("errorMessage", "Registration completed but student profile could not be created.");
            request.getRequestDispatcher("/student-register.jsp").forward(request, response);
            return;
        }

        request.setAttribute("successMessage", "Student account created successfully. Please login.");
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
