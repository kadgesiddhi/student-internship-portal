<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/about.jsp">About</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/contact.jsp">Contact</a></li>
            </ul>
        </div>
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/login.jsp">Login</a>
    </div>
</nav>

<section class="page-header bg-light">
    <div class="container">
        <h1>About the Portal</h1>
        <p>Connecting students with industries and helping them grow professionally.</p>
    </div>
</section>

<section class="container py-5">
    <div class="row align-items-center g-4">
        <div class="col-lg-6">
            <h2>Our Mission</h2>
            <p>We are building a platform that simplifies the internship journey for students and employers by making relevant opportunities more discoverable, transparent, and accessible.</p>
            <h2 class="mt-4">Our Vision</h2>
            <p>To become the go-to internship ecosystem for college students, companies, and academic institutions by creating real career pathways and professional growth.</p>
        </div>
        <div class="col-lg-6">
            <div class="card shadow-sm border-0 p-4">
                <h4>Why Internships Matter</h4>
                <p>Internships offer hands-on experience, industry exposure, stronger resumes, and the confidence to launch a successful career. They bridge the gap between classroom learning and working life.</p>
            </div>
        </div>
    </div>

    <div class="mt-5">
        <h3 class="text-center mb-4">How the Portal Works</h3>
        <div class="row g-4">
            <div class="col-md-3">
                <div class="step-card text-center p-4 h-100">
                    <div class="step-number">1</div>
                    <h5>Create Account</h5>
                    <p>Register as a student or company in a few simple steps.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card text-center p-4 h-100">
                    <div class="step-number">2</div>
                    <h5>Build Profile</h5>
                    <p>Showcase your education, skills, and experience.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card text-center p-4 h-100">
                    <div class="step-number">3</div>
                    <h5>Find Internship</h5>
                    <p>Search and filter relevant internship opportunities.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="step-card text-center p-4 h-100">
                    <div class="step-number">4</div>
                    <h5>Apply & Track</h5>
                    <p>Apply with confidence and monitor application progress.</p>
                </div>
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
