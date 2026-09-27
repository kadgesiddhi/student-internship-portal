<%@ page import="com.fsjp.portal.model.Application" %>
<%@ page import="com.fsjp.portal.model.User" %>
<%@ page import="com.fsjp.portal.dao.ApplicationDAO" %>
<%@ page import="com.fsjp.portal.dao.StudentDAO" %>
<%@ page import="com.fsjp.portal.model.Student" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User sessionUser = (User) session.getAttribute("user");
    if (sessionUser == null || !"STUDENT".equalsIgnoreCase(sessionUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Student student = StudentDAO.findByUserId(sessionUser.getId());
    List<Application> applications = student != null ? ApplicationDAO.getByStudentId(student.getId()) : java.util.Collections.emptyList();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications</title>
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
            <a class="nav-link" href="${pageContext.request.contextPath}/student-profile"><i class="fa-solid fa-user"></i> My Profile</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/internships"><i class="fa-solid fa-briefcase"></i> Browse Internships</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/applications.jsp"><i class="fa-solid fa-file-lines"></i> My Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <h4 class="mb-0">My Applications</h4>
        </div>
        <div class="card shadow-sm border-0 mt-4">
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Internship</th>
                        <th>Company</th>
                        <th>Location</th>
                        <th>Applied Date</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Application app : applications) { %>
                    <tr>
                        <td><%= app.getInternshipTitle() %></td>
                        <td><%= app.getCompanyName() %></td>
                        <td><%= app.getLocation() %></td>
                        <td><%= app.getAppliedDate() %></td>
                        <td>
                            <% if ("PENDING".equalsIgnoreCase(app.getStatus())) { %>
                            <span class="badge bg-warning text-dark">Pending</span>
                            <% } else if ("SELECTED".equalsIgnoreCase(app.getStatus())) { %>
                            <span class="badge bg-success">Selected</span>
                            <% } else { %>
                            <span class="badge bg-danger">Rejected</span>
                            <% } %>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
