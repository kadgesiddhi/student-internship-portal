<%@ page import="com.fsjp.portal.model.*" %>
<%@ page import="com.fsjp.portal.dao.*" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User sessionUser = (User) session.getAttribute("user");
    if (sessionUser == null || !"STUDENT".equalsIgnoreCase(sessionUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    Student student = StudentDAO.findByUserId(sessionUser.getId());
    List<Application> recentApps = student != null ? ApplicationDAO.getByStudentId(student.getId()) : java.util.Collections.emptyList();
    List<Internship> recommended = InternshipDAO.getRecommended();
    int totalApplications = recentApps.size();
    int pendingApplications = ApplicationDAO.countPendingForStudent(student != null ? student.getId() : 0);
    int selectedApplications = ApplicationDAO.countSelectedForStudent(student != null ? student.getId() : 0);
    int rejectedApplications = ApplicationDAO.countRejectedForStudent(student != null ? student.getId() : 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
<div class="dashboard-layout">
    <aside class="sidebar">
        <div class="brand-box">Student Portal</div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="${pageContext.request.contextPath}/student/dashboard.jsp"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student-profile"><i class="fa-solid fa-user"></i> My Profile</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/internships"><i class="fa-solid fa-briefcase"></i> Browse Internships</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/student/applications.jsp"><i class="fa-solid fa-file-lines"></i> My Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/login.jsp"><i class="fa-solid fa-key"></i> Change Password</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <div>
                <h4 class="mb-0">Welcome, Student!</h4>
            </div>
            <span class="badge bg-primary-subtle text-primary"><%= sessionUser.getEmail() %></span>
        </div>

        <div class="row g-4 mt-2">
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-primary-soft"><i class="fa-solid fa-file-lines"></i></div>
                    <div>
                        <h5><%= totalApplications %></h5>
                        <p>Total Applications</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-warning-soft"><i class="fa-solid fa-clock"></i></div>
                    <div>
                        <h5><%= pendingApplications %></h5>
                        <p>Pending Applications</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-success-soft"><i class="fa-solid fa-check"></i></div>
                    <div>
                        <h5><%= selectedApplications %></h5>
                        <p>Selected</p>
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <div class="stat-card">
                    <div class="icon bg-danger-soft"><i class="fa-solid fa-xmark"></i></div>
                    <div>
                        <h5><%= rejectedApplications %></h5>
                        <p>Rejected</p>
                    </div>
                </div>
            </div>
        </div>

        <section class="mt-5">
            <div class="section-header d-flex justify-content-between align-items-center mb-3">
                <h4>Recommended Internships</h4>
            </div>
            <div class="row g-4">
                <% for (Internship internship : recommended) { %>
                <div class="col-lg-3 col-md-6">
                    <div class="card internship-card h-100 border-0 shadow-sm">
                        <div class="card-body">
                            <span class="badge bg-primary-subtle text-primary mb-2"><%= internship.getInternshipType() %></span>
                            <h6><%= internship.getTitle() %></h6>
                            <p class="text-muted mb-2"><%= internship.getCompanyName() %></p>
                            <p class="small mb-2"><i class="fa-solid fa-location-dot me-2"></i><%= internship.getLocation() %></p>
                            <a href="${pageContext.request.contextPath}/internship-details?id=<%= internship.getId() %>" class="btn btn-sm btn-primary">View</a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </section>

        <section class="mt-5">
            <div class="section-header d-flex justify-content-between align-items-center mb-3">
                <h4>Recent Applications</h4>
                <a href="${pageContext.request.contextPath}/student/applications.jsp" class="btn btn-link text-primary p-0">View all</a>
            </div>
            <div class="card shadow-sm border-0">
                <div class="table-responsive">
                    <table class="table align-middle mb-0">
                        <thead class="table-light">
                        <tr>
                            <th>Internship</th>
                            <th>Company</th>
                            <th>Applied Date</th>
                            <th>Status</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% for (Application app : recentApps) { %>
                        <tr>
                            <td><%= app.getInternshipTitle() %></td>
                            <td><%= app.getCompanyName() %></td>
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
        </section>
    </main>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
