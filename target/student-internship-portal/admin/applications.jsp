<%@ page import="com.fsjp.portal.dao.*" %>
<%@ page import="com.fsjp.portal.model.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User sessionUser = (User) session.getAttribute("user");
    if (sessionUser == null || !"ADMIN".equalsIgnoreCase(sessionUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String statusFilter = request.getParameter("status");
    List<Application> applications = ApplicationDAO.getAllApplications();
    if (statusFilter != null && !statusFilter.trim().isEmpty()) {
        java.util.Iterator<Application> iterator = applications.iterator();
        while (iterator.hasNext()) {
            Application app = iterator.next();
            if (!statusFilter.equalsIgnoreCase(app.getStatus())) {
                iterator.remove();
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Applications</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
<div class="dashboard-layout">
    <aside class="sidebar">
        <div class="brand-box">Admin Panel</div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/students.jsp"><i class="fa-solid fa-users"></i> Students</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/companies.jsp"><i class="fa-solid fa-building"></i> Companies</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/internships.jsp"><i class="fa-solid fa-briefcase"></i> Internships</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/applications.jsp"><i class="fa-solid fa-file-lines"></i> Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <h4 class="mb-0">Application Overview</h4>
        </div>
        <div class="card shadow-sm border-0 mt-4 p-3">
            <form method="get" action="${pageContext.request.contextPath}/admin/applications.jsp" class="d-flex gap-2 mb-3">
                <select class="form-select" name="status">
                    <option value="">All</option>
                    <option value="PENDING">Pending</option>
                    <option value="SELECTED">Selected</option>
                    <option value="REJECTED">Rejected</option>
                </select>
                <button class="btn btn-primary" type="submit">Filter</button>
            </form>
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Student</th>
                        <th>Company</th>
                        <th>Internship</th>
                        <th>Applied Date</th>
                        <th>Status</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Application app : applications) { %>
                    <tr>
                        <td><%= app.getStudentName() %></td>
                        <td><%= app.getCompanyName() %></td>
                        <td><%= app.getInternshipTitle() %></td>
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
