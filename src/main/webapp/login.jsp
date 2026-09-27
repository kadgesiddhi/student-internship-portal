<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Student Internship Portal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="auth-body">
<div class="auth-shell">
    <div class="container">
        <div class="row justify-content-center align-items-center min-vh-100">
            <div class="col-lg-5 col-md-7">
                <div class="card shadow-lg border-0 rounded-4 auth-card">
                    <div class="card-body p-4 p-lg-5">
                        <div class="text-center mb-4">
                            <div class="auth-logo mb-3"><i class="fa-solid fa-briefcase"></i></div>
                            <h3 class="fw-bold">Welcome Back</h3>
                            <p class="text-muted mb-0">Sign in to continue</p>
                        </div>

                        <% String successMessage = (String) request.getAttribute("successMessage");
                           if (successMessage != null) { %>
                        <div class="alert alert-success"><%= successMessage %></div>
                        <% } %>
                        <% String errorMessage = (String) request.getAttribute("errorMessage");
                           if (errorMessage != null) { %>
                        <div class="alert alert-danger"><%= errorMessage %></div>
                        <% } %>

                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="">Select role</option>
                                    <option value="STUDENT">Student</option>
                                    <option value="COMPANY">Company</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Login</button>
                        </form>
                        <div class="text-center mt-4 small text-muted">
                            New student? <a href="${pageContext.request.contextPath}/student-register.jsp">Create account</a>
                        </div>
                        <div class="text-center mt-2 small text-muted">
                            New company? <a href="${pageContext.request.contextPath}/company-register.jsp">Register company</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
