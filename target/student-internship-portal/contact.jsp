<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
            </ul>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Login</a>
    </div>
</nav>

<section class="page-header bg-light">
    <div class="container">
        <h1>Contact Us</h1>
        <p>Reach out for support, partnership, or student guidance.</p>
    </div>
</section>

<section class="container py-5">
    <div class="row g-4">
        <div class="col-lg-5">
            <div class="card shadow-sm border-0 p-4 h-100">
                <h4 class="mb-3">Get in touch</h4>
                <ul class="list-unstyled contact-list">
                    <li><i class="fa-solid fa-envelope me-2"></i> support@internportal.edu</li>
                    <li><i class="fa-solid fa-phone me-2"></i> +91 98765 43210</li>
                    <li><i class="fa-solid fa-location-dot me-2"></i> Bengaluru, India</li>
                </ul>
            </div>
        </div>
        <div class="col-lg-7">
            <div class="card shadow-sm border-0 p-4">
                <% String errorMessage = (String) request.getAttribute("errorMessage"); if (errorMessage != null) { %>
                <div class="alert alert-danger"><%= errorMessage %></div>
                <% } %>
                <% String successMessage = (String) request.getAttribute("successMessage"); if (successMessage != null) { %>
                <div class="alert alert-success"><%= successMessage %></div>
                <% } %>
                <form action="${pageContext.request.contextPath}/contact-submit" method="post">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Name</label>
                            <input type="text" class="form-control" name="name" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Subject</label>
                            <input type="text" class="form-control" name="subject" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Message</label>
                            <textarea class="form-control" rows="5" name="message" required></textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary mt-4">Submit</button>
                </form>
            </div>
        </div>
    </div>
</section>

<footer class="footer mt-5 py-4 bg-dark text-light">
    <div class="container text-center">© 2026 Student Internship Portal</div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
