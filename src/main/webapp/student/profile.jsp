<%@ page import="com.fsjp.portal.model.Student" %>
<%@ page import="com.fsjp.portal.model.User" %>
<%@ page import="com.fsjp.portal.dao.StudentDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User sessionUser = (User) session.getAttribute("user");
    if (sessionUser == null || !"STUDENT".equalsIgnoreCase(sessionUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Student student = (Student) request.getAttribute("student");
    if (student == null) {
        student = StudentDAO.findByUserId(sessionUser.getId());
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
<div class="dashboard-layout">
    <aside class="sidebar">
        <div class="brand-box">Student Portal</div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/student/dashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/student-profile"><i class="fa-solid fa-user"></i> My Profile</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/internships"><i class="fa-solid fa-briefcase"></i> Browse Internships</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/applications.jsp"><i class="fa-solid fa-file-lines"></i> My Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <h4 class="mb-0">My Profile</h4>
        </div>
        <div class="card shadow-sm border-0 p-4 mt-4">
            <% String successMessage = (String) request.getAttribute("successMessage"); if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
            <% } %>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
            <% } %>
            <form action="${pageContext.request.contextPath}/student-profile" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="fullName" value="<%= student != null ? student.getFullName() : "" %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Mobile</label>
                        <input type="text" class="form-control" name="mobile" value="<%= student != null ? student.getMobile() : "" %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">College</label>
                        <input type="text" class="form-control" name="college" value="<%= student != null ? student.getCollege() : "" %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Course</label>
                        <input type="text" class="form-control" name="course" value="<%= student != null ? student.getCourse() : "" %>" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Year</label>
                        <select class="form-select" name="year">
                            <option value="1st Year" <%= "1st Year".equals(student != null ? student.getGraduationYear() : "") ? "selected" : "" %>>1st Year</option>
                            <option value="2nd Year" <%= "2nd Year".equals(student != null ? student.getGraduationYear() : "") ? "selected" : "" %>>2nd Year</option>
                            <option value="3rd Year" <%= "3rd Year".equals(student != null ? student.getGraduationYear() : "") ? "selected" : "" %>>3rd Year</option>
                            <option value="4th Year" <%= "4th Year".equals(student != null ? student.getGraduationYear() : "") ? "selected" : "" %>>4th Year</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Resume / Portfolio Link</label>
                        <input type="text" class="form-control" name="resume" value="<%= student != null && student.getResumeLink() != null ? student.getResumeLink() : "" %>">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Skills</label>
                        <textarea class="form-control" rows="3" name="skills" required><%= student != null ? student.getSkills() : "" %></textarea>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary mt-4">Save Changes</button>
            </form>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
