<%@ page import="com.fsjp.portal.model.User" %>
<%@ page import="com.fsjp.portal.dao.CompanyDAO" %>
<%@ page import="com.fsjp.portal.model.Company" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User sessionUser = (User) session.getAttribute("user");
    if (sessionUser == null || !"COMPANY".equalsIgnoreCase(sessionUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Company company = CompanyDAO.findByUserId(sessionUser.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Post Internship</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
<div class="dashboard-layout">
    <aside class="sidebar">
        <div class="brand-box">Company Portal</div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/company/dashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company-profile"><i class="fa-solid fa-building"></i> Company Profile</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/company/add-internship.jsp"><i class="fa-solid fa-plus"></i> Post Internship</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company/internships.jsp"><i class="fa-solid fa-briefcase"></i> My Internships</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company/applications.jsp"><i class="fa-solid fa-file-lines"></i> Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <h4 class="mb-0">Post Internship</h4>
        </div>
        <div class="card shadow-sm border-0 p-4 mt-4">
            <% String errorMessage = (String) request.getAttribute("errorMessage"); if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/company-internships" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Internship Title</label>
                        <input type="text" class="form-control" name="title" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Location</label>
                        <input type="text" class="form-control" name="location" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Internship Type</label>
                        <select class="form-select" name="internshipType" required>
                            <option value="ON_SITE">On-Site</option>
                            <option value="REMOTE">Remote</option>
                            <option value="HYBRID">Hybrid</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Duration</label>
                        <input type="text" class="form-control" name="duration" value="3 Months" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Stipend</label>
                        <input type="text" class="form-control" name="stipend" value="₹10,000/month" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Application Deadline</label>
                        <input type="date" class="form-control" name="deadline" required>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" rows="4" name="description" required></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Skills</label>
                        <textarea class="form-control" rows="3" name="skills" required></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Requirements</label>
                        <textarea class="form-control" rows="3" name="requirements" required></textarea>
                    </div>
                    <div class="col-12">
                        <label class="form-label">Benefits</label>
                        <textarea class="form-control" rows="3" name="benefits" required></textarea>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary mt-4">Submit Internship</button>
            </form>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
