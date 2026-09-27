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
    List<Internship> companyInternships = company != null ? InternshipDAO.getByCompanyId(company.getId()) : java.util.Collections.emptyList();
    List<Application> applications = company != null ? ApplicationDAO.getByCompanyId(company.getId()) : java.util.Collections.emptyList();
    int totalInternships = companyInternships.size();
    int activeInternships = company != null ? InternshipDAO.countActiveByCompany(company.getId()) : 0;
    int totalApplications = applications.size();
    int selectedStudents = company != null ? ApplicationDAO.countSelectedStudentsForCompany(company.getId()) : 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
<div class="dashboard-layout">
    <aside class="sidebar">
        <div class="brand-box">Company Portal</div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="${pageContext.request.contextPath}/company/dashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company-profile"><i class="fa-solid fa-building"></i> Company Profile</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company/add-internship.jsp"><i class="fa-solid fa-plus"></i> Post Internship</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company/internships.jsp"><i class="fa-solid fa-briefcase"></i> My Internships</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company/applications.jsp"><i class="fa-solid fa-file-lines"></i> Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <div>
                <h4 class="mb-0">Company Dashboard</h4>
            </div>
            <span class="badge bg-primary-subtle text-primary"><%= sessionUser.getEmail() %></span>
        </div>

        <div class="row g-4 mt-2">
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-primary-soft"><i class="fa-solid fa-briefcase"></i></div>
                    <div>
                        <h5><%= totalInternships %></h5>
                        <p>Total Internships</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-success-soft"><i class="fa-solid fa-check-circle"></i></div>
                    <div>
                        <h5><%= activeInternships %></h5>
                        <p>Active Internships</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-warning-soft"><i class="fa-solid fa-user-check"></i></div>
                    <div>
                        <h5><%= totalApplications %></h5>
                        <p>Total Applications</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-danger-soft"><i class="fa-solid fa-user-graduate"></i></div>
                    <div>
                        <h5><%= selectedStudents %></h5>
                        <p>Selected Students</p>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
