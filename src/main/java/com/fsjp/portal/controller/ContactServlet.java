package com.fsjp.portal.controller;

import com.fsjp.portal.dao.ContactMessageDAO;
import com.fsjp.portal.model.ContactMessage;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/contact-submit")
public class ContactServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (name == null || email == null || subject == null || message == null ||
                name.trim().isEmpty() || email.trim().isEmpty() || subject.trim().isEmpty() || message.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All contact fields are required.");
            request.getRequestDispatcher("/contact.jsp").forward(request, response);
            return;
        }

        ContactMessage contactMessage = new ContactMessage();
        contactMessage.setName(name.trim());
        contactMessage.setEmail(email.trim());
        contactMessage.setSubject(subject.trim());
        contactMessage.setMessage(message.trim());

        if (ContactMessageDAO.save(contactMessage)) {
            request.setAttribute("successMessage", "Your message has been sent successfully.");
        } else {
            request.setAttribute("errorMessage", "Unable to send message right now.");
        }
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
    }
}
