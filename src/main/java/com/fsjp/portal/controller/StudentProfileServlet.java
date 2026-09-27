package com.fsjp.portal.controller;

import com.fsjp.portal.dao.StudentDAO;
import com.fsjp.portal.model.Student;
import com.fsjp.portal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/student-profile")
public class StudentProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        Student student = StudentDAO.findByUserId(user.getId());
        request.setAttribute("student", student);
        request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        Student student = StudentDAO.findByUserId(user.getId());
        if (student == null) {
            student = new Student();
            student.setUserId(user.getId());
        }

        student.setFullName(request.getParameter("fullName"));
        student.setMobile(request.getParameter("mobile"));
        student.setCollege(request.getParameter("college"));
        student.setCourse(request.getParameter("course"));
        student.setGraduationYear(request.getParameter("year"));
        student.setSkills(request.getParameter("skills"));
        student.setResumeLink(request.getParameter("resume"));

        boolean saved = student.getId() > 0
                ? StudentDAO.updateStudent(student)
                : StudentDAO.createStudent(student);
        if (saved) {
            request.setAttribute("successMessage", "Profile updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Unable to save profile.");
        }

        request.setAttribute("student", StudentDAO.findByUserId(user.getId()));
        request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
    }
}
