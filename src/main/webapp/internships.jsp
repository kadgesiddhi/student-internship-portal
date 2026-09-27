<%@ page import="com.fsjp.portal.model.Internship" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% List<Internship> internships = (List<Internship>) request.getAttribute("internships"); if (internships == null) internships = java.util.Collections.emptyList(); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Internships</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/internships">Internships</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
            </ul>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Login</a>
    </div>
</nav>

<section class="page-header">
    <div class="container">
        <h1>Available Internships</h1>
        <p>Discover opportunities that align with your skills and career goals.</p>
    </div>
</section>

<section class="container py-5">
    <form method="get" action="${pageContext.request.contextPath}/internships" class="filter-card card shadow-sm mb-4">
        <div class="row g-3">
            <div class="col-md-4">
                <input type="text" class="form-control" name="search" placeholder="Search internships or skills">
            </div>
            <div class="col-md-2">
                <input type="text" class="form-control" name="location" placeholder="Location">
            </div>
            <div class="col-md-2">
                <input type="text" class="form-control" name="skill" placeholder="Skill">
            </div>
            <div class="col-md-2">
                <select class="form-select" name="type">
                    <option value="">Type</option>
                    <option value="REMOTE">Remote</option>
                    <option value="HYBRID">Hybrid</option>
                    <option value="ON_SITE">On-site</option>
                </select>
            </div>
            <div class="col-md-2">
                <button class="btn btn-primary w-100" type="submit">Filter</button>
            </div>
        </div>
    </form>

    <div class="row g-4">
        <% for (Internship internship : internships) { %>
        <div class="col-lg-4 col-md-6">
            <div class="card internship-card h-100 shadow-sm border-0">
                <div class="card-body d-flex flex-column">
                    <div class="d-flex justify-content-between align-items-start mb-3">
                        <span class="badge bg-primary-subtle text-primary"><%= internship.getInternshipType() %></span>
                        <span class="text-muted small"><%= internship.getLocation() %></span>
                    </div>
                    <h5 class="card-title"><%= internship.getTitle() %></h5>
                    <p class="text-muted mb-2"><i class="fa-solid fa-building me-2"></i><%= internship.getCompanyName() %></p>
                    <div class="meta-row mb-3">
                        <span><i class="fa-solid fa-clock me-1"></i><%= internship.getDuration() %></span>
                        <span><i class="fa-solid fa-indian-rupee-sign me-1"></i><%= internship.getStipend() %></span>
                    </div>
                    <p class="text-muted small mb-3"><strong>Skills:</strong> <%= internship.getSkills() %></p>
                    <div class="mt-auto d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/internship-details?id=<%= internship.getId() %>" class="btn btn-outline-primary flex-grow-1">View Details</a>
                        <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary flex-grow-1">Apply</a>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</section>

<footer class="footer mt-5 py-4 bg-dark text-light">
    <div class="container text-center">© 2026 Student Internship Portal</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
