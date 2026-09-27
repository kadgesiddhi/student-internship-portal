<%@ page import="com.fsjp.portal.model.Internship" %>
<%@ page import="com.fsjp.portal.model.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% Internship internship = (Internship) request.getAttribute("internship"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internship Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/index.jsp"><i class="fa-solid fa-briefcase me-2"></i>Portal</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/internships">Internships</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
            </ul>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Login</a>
    </div>
</nav>

<div class="container py-5">
    <% if (internship == null) { %>
    <div class="alert alert-warning">Internship not found.</div>
    <% } else { %>
    <% String errorMessage = (String) request.getAttribute("errorMessage"); if (errorMessage != null) { %>
    <div class="alert alert-danger"><%= errorMessage %></div>
    <% } %>
    <div class="row">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0 p-4">
                <div class="d-flex justify-content-between align-items-center mb-3 flex-wrap gap-2">
                    <span class="badge bg-primary-subtle text-primary"><%= internship.getInternshipType() %></span>
                    <span class="text-muted small"><%= internship.getLocation() %></span>
                </div>
                <h1 class="mb-3"><%= internship.getTitle() %></h1>
                <p class="text-primary fw-semibold mb-4"><i class="fa-solid fa-building me-2"></i><%= internship.getCompanyName() %></p>

                <div class="row g-3 mb-4">
                    <div class="col-md-3"><div class="detail-box"><strong>Duration</strong><span><%= internship.getDuration() %></span></div></div>
                    <div class="col-md-3"><div class="detail-box"><strong>Stipend</strong><span><%= internship.getStipend() %></span></div></div>
                    <div class="col-md-3"><div class="detail-box"><strong>Deadline</strong><span><%= internship.getDeadline() %></span></div></div>
                    <div class="col-md-3"><div class="detail-box"><strong>Location</strong><span><%= internship.getLocation() %></span></div></div>
                </div>

                <h4>Description</h4>
                <p><%= internship.getDescription() %></p>
                <h4 class="mt-4">Responsibilities</h4>
                <p><%= internship.getRequirements() %></p>
                <h4 class="mt-4">Benefits</h4>
                <p><%= internship.getBenefits() %></p>
                <h4 class="mt-4">Skills</h4>
                <p><%= internship.getSkills() %></p>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="card shadow-sm border-0 p-4 sticky-top" style="top: 90px;">
                <h5 class="mb-3">Quick Overview</h5>
                <ul class="list-unstyled side-list">
                    <li><i class="fa-solid fa-location-dot me-2"></i><%= internship.getLocation() %></li>
                    <li><i class="fa-solid fa-clock me-2"></i><%= internship.getDuration() %></li>
                    <li><i class="fa-solid fa-indian-rupee-sign me-2"></i><%= internship.getStipend() %></li>
                    <li><i class="fa-solid fa-calendar-days me-2"></i>Apply by <%= internship.getDeadline() %></li>
                </ul>
                <% User user = (User) session.getAttribute("user"); %>
                <% if (user != null && "STUDENT".equalsIgnoreCase(user.getRole())) { %>
                <form action="${pageContext.request.contextPath}/apply-internship" method="post">
                    <input type="hidden" name="internshipId" value="<%= internship.getId() %>">
                    <button type="submit" class="btn btn-primary w-100">Apply Now</button>
                </form>
                <% } else { %>
                <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary w-100">Apply Now</a>
                <% } %>
            </div>
        </div>
    </div>
    <% } %>
</div>

<footer class="footer mt-5 py-4 bg-dark text-light">
    <div class="container text-center">© 2026 Student Internship Portal</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
