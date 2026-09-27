package com.fsjp.portal.controller;

import com.fsjp.portal.dao.ApplicationDAO;
import com.fsjp.portal.dao.StudentDAO;
import com.fsjp.portal.dao.InternshipDAO;
import com.fsjp.portal.model.Internship;
import com.fsjp.portal.model.Student;
import com.fsjp.portal.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/apply-internship")
public class ApplyInternshipServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"STUDENT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String internshipId = request.getParameter("internshipId");
        if (internshipId == null || internshipId.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/internships.jsp");
            return;
        }

        Student student = StudentDAO.findByUserId(user.getId());
        if (student == null || student.getFullName() == null || student.getFullName().trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please complete your student profile before applying.");
            request.getRequestDispatcher("/student/profile.jsp").forward(request, response);
            return;
        }

        int id = Integer.parseInt(internshipId);
        if (ApplicationDAO.hasApplied(id, student.getId())) {
            request.setAttribute("errorMessage", "Already applied.");
            Internship internship = InternshipDAO.getById(id);
            request.setAttribute("internship", internship);
            request.getRequestDispatcher("/internship-details.jsp").forward(request, response);
            return;
        }

        Internship internship = InternshipDAO.getById(id);
        if (internship == null) {
            response.sendRedirect(request.getContextPath() + "/internships.jsp");
            return;
        }

        LocalDate deadline = LocalDate.parse(internship.getDeadline());
        if (LocalDate.now().isAfter(deadline)) {
            request.setAttribute("errorMessage", "Internship deadline has expired.");
            request.setAttribute("internship", internship);
            request.getRequestDispatcher("/internship-details.jsp").forward(request, response);
            return;
        }

        boolean created = ApplicationDAO.createApplication(id, student.getId());
        if (created) {
            response.sendRedirect(request.getContextPath() + "/student/applications.jsp?success=applied");
        } else {
            request.setAttribute("errorMessage", "Unable to submit application.");
            request.setAttribute("internship", internship);
            request.getRequestDispatcher("/internship-details.jsp").forward(request, response);
        }
    }
}
