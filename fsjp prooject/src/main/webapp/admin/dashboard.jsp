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
    List<ContactMessage> contactMessages = ContactMessageDAO.getAll();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
<div class="dashboard-layout">
    <aside class="sidebar">
        <div class="brand-box">Admin Panel</div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/students.jsp"><i class="fa-solid fa-users"></i> Students</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/companies.jsp"><i class="fa-solid fa-building"></i> Companies</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/internships.jsp"><i class="fa-solid fa-briefcase"></i> Internships</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/applications.jsp"><i class="fa-solid fa-file-lines"></i> Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <div>
                <h4 class="mb-0">Admin Dashboard</h4>
            </div>
            <span class="badge bg-primary-subtle text-primary"><%= sessionUser.getEmail() %></span>
        </div>

        <div class="row g-4 mt-2">
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-primary-soft"><i class="fa-solid fa-user-graduate"></i></div>
                    <div>
                        <h5><%= StudentDAO.countStudents() %></h5>
                        <p>Total Students</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-success-soft"><i class="fa-solid fa-building"></i></div>
                    <div>
                        <h5><%= CompanyDAO.countCompanies() %></h5>
                        <p>Total Companies</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-warning-soft"><i class="fa-solid fa-briefcase"></i></div>
                    <div>
                        <h5><%= InternshipDAO.countTotalInternships() %></h5>
                        <p>Total Internships</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-danger-soft"><i class="fa-solid fa-file-lines"></i></div>
                    <div>
                        <h5><%= ApplicationDAO.countTotalApplications() %></h5>
                        <p>Total Applications</p>
                    </div>
                </div>
            </div>
        </div>

        <section class="mt-5">
            <h4>Contact Messages</h4>
            <div class="card shadow-sm border-0 p-3">
                <% for (ContactMessage message : contactMessages) { %>
                <div class="border-bottom py-3">
                    <strong><%= message.getName() %></strong> <span class="text-muted small">(<%= message.getEmail() %>)</span>
                    <div class="text-muted small"><%= message.getSubject() %></div>
                    <p class="mb-0 mt-2"><%= message.getMessage() %></p>
                </div>
                <% } %>
            </div>
        </section>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
