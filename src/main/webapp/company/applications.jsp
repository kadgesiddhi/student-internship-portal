<%@ page import="com.fsjp.portal.model.*" %>
<%@ page import="com.fsjp.portal.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User sessionUser = (User) session.getAttribute("user");
    if (sessionUser == null || !"COMPANY".equalsIgnoreCase(sessionUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Company company = CompanyDAO.findByUserId(sessionUser.getId());
    List<Application> applications = company != null ? ApplicationDAO.getByCompanyId(company.getId()) : java.util.Collections.emptyList();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Applications</title>
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
            <a class="nav-link" href="${pageContext.request.contextPath}/company/add-internship.jsp"><i class="fa-solid fa-plus"></i> Post Internship</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company/internships.jsp"><i class="fa-solid fa-briefcase"></i> My Internships</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/company/applications.jsp"><i class="fa-solid fa-file-lines"></i> Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <h4 class="mb-0">Applications</h4>
        </div>
        <div class="card shadow-sm border-0 mt-4">
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Student</th>
                        <th>Email</th>
                        <th>College</th>
                        <th>Course</th>
                        <th>Skills</th>
                        <th>Internship</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Application app : applications) { %>
                    <tr>
                        <td><%= app.getStudentName() %></td>
                        <td><%= app.getEmail() %></td>
                        <td><%= app.getCollege() %></td>
                        <td><%= app.getCourse() %></td>
                        <td><%= app.getSkills() %></td>
                        <td><%= app.getInternshipTitle() %></td>
                        <td>
                            <% if ("PENDING".equalsIgnoreCase(app.getStatus())) { %>
                            <span class="badge bg-warning text-dark">Pending</span>
                            <% } else if ("SELECTED".equalsIgnoreCase(app.getStatus())) { %>
                            <span class="badge bg-success">Selected</span>
                            <% } else { %>
                            <span class="badge bg-danger">Rejected</span>
                            <% } %>
                        </td>
                        <td>
                            <div class="d-flex gap-2">
                                <a href="${pageContext.request.contextPath}/application?action=select&applicationId=<%= app.getId() %>" class="btn btn-sm btn-success">Select</a>
                                <a href="${pageContext.request.contextPath}/application?action=reject&applicationId=<%= app.getId() %>" class="btn btn-sm btn-danger">Reject</a>
                            </div>
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
