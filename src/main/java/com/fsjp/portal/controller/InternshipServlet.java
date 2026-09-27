package com.fsjp.portal.controller;

import com.fsjp.portal.dao.InternshipDAO;
import com.fsjp.portal.model.Internship;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = {"/internships", "/internship-details"})
public class InternshipServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String internshipId = request.getParameter("id");
        if (internshipId != null && !internshipId.trim().isEmpty()) {
            Internship internship = InternshipDAO.getById(Integer.parseInt(internshipId));
            request.setAttribute("internship", internship);
            request.getRequestDispatcher("/internship-details.jsp").forward(request, response);
            return;
        }

        String search = request.getParameter("search");
        String location = request.getParameter("location");
        String skill = request.getParameter("skill");
        String type = request.getParameter("type");

        request.setAttribute("internships", InternshipDAO.getApprovedInternships(search, location, skill, type));
        request.getRequestDispatcher("/internships.jsp").forward(request, response);
    }
}
