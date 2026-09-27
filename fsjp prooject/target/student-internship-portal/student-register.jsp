<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-body">
<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-lg border-0 rounded-4 overflow-hidden">
                <div class="row g-0">
                    <div class="col-lg-5 bg-primary text-white d-flex align-items-center p-4">
                        <div>
                            <h3 class="fw-bold">Create Your Student Profile</h3>
                            <p>Join internships from leading companies and kickstart your career.</p>
                            <ul class="list-unstyled mt-4">
                                <li><i class="fa-solid fa-check me-2"></i>Build a professional profile</li>
                                <li><i class="fa-solid fa-check me-2"></i>Explore internship matches</li>
                                <li><i class="fa-solid fa-check me-2"></i>Track your applications</li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-7 p-4 p-lg-5">
                        <h4 class="mb-4">Student Registration</h4>
                        <% String errorMessage = (String) request.getAttribute("errorMessage"); if (errorMessage != null) { %>
                        <div class="alert alert-danger"><%= errorMessage %></div>
                        <% } %>
                        <form action="${pageContext.request.contextPath}/student-register" method="post">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" name="fullName" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Mobile Number</label>
                                    <input type="text" class="form-control" name="mobile" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Password</label>
                                    <input type="password" class="form-control" name="password" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Confirm Password</label>
                                    <input type="password" class="form-control" name="confirmPassword" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">College Name</label>
                                    <input type="text" class="form-control" name="college" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Course</label>
                                    <input type="text" class="form-control" name="course" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Year</label>
                                    <select class="form-select" name="year" required>
                                        <option value="">Select year</option>
                                        <option value="1st Year">1st Year</option>
                                        <option value="2nd Year">2nd Year</option>
                                        <option value="3rd Year">3rd Year</option>
                                        <option value="4th Year">4th Year</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Skills</label>
                                    <textarea class="form-control" name="skills" rows="3" required></textarea>
                                </div>
                            </div>
                            <button class="btn btn-primary w-100 mt-4" type="submit">Create Account</button>
                        </form>
                        <p class="text-center mt-3 mb-0">Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
