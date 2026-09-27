<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Internship Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/index.jsp">
            <i class="fa-solid fa-briefcase me-2"></i>Student Internship Portal
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/internships">Internships</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
            </ul>
            <div class="d-flex gap-2">
                <a class="btn btn-outline-primary" href="${pageContext.request.contextPath}/login.jsp">Login</a>
                <a class="btn btn-primary" href="${pageContext.request.contextPath}/student-register.jsp">Register</a>
            </div>
        </div>
    </div>
</nav>

<section class="hero-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <span class="badge text-bg-primary-soft mb-3">Career Growth Starts Here</span>
                <h1>Find Your Dream Internship</h1>
                <p class="lead text-muted">Discover opportunities, build your skills and take the first step towards your career.</p>
                <div class="d-flex gap-3 mt-4">
                    <a href="${pageContext.request.contextPath}/internships" class="btn btn-primary btn-lg">Browse Internships</a>
                    <a href="${pageContext.request.contextPath}/student-register.jsp" class="btn btn-outline-primary btn-lg">Get Started</a>
                </div>
                <div class="stats-row mt-5">
                    <div>
                        <strong>5K+</strong>
                        <span>Students</span>
                    </div>
                    <div>
                        <strong>350+</strong>
                        <span>Companies</span>
                    </div>
                    <div>
                        <strong>1200+</strong>
                        <span>Placements</span>
                    </div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="hero-illustration">
                    <img src="https://images.unsplash.com/photo-1522202176988-66273c2fd55f?auto=format&fit=crop&w=900&q=80" alt="Students working" class="img-fluid rounded-4 shadow-lg">
                </div>
            </div>
        </div>
    </div>
</section>

<section class="container py-5">
    <div class="row g-4">
        <div class="col-md-4">
            <div class="feature-card card h-100 border-0 shadow-sm p-4">
                <div class="icon-box bg-primary-soft"><i class="fa-solid fa-magnifying-glass"></i></div>
                <h4>Discover Roles</h4>
                <p>Explore internships across technology, marketing, business, design, and many other domains.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card card h-100 border-0 shadow-sm p-4">
                <div class="icon-box bg-success-soft"><i class="fa-solid fa-user-graduate"></i></div>
                <h4>Build Your Profile</h4>
                <p>Highlight your skills, education, and resume to improve your placement readiness.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature-card card h-100 border-0 shadow-sm p-4">
                <div class="icon-box bg-warning-soft"><i class="fa-solid fa-chart-line"></i></div>
                <h4>Track Applications</h4>
                <p>Follow application status in real time and increase your chances with targeted opportunities.</p>
            </div>
        </div>
    </div>
</section>

<footer class="footer mt-5 py-4 bg-dark text-light">
    <div class="container d-flex justify-content-between flex-wrap gap-2">
        <span>© 2026 Student Internship Portal</span>
        <span>Empowering students to launch successful careers</span>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
