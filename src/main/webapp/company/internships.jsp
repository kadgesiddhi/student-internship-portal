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
    List<Internship> internships = company != null ? InternshipDAO.getByCompanyId(company.getId()) : java.util.Collections.emptyList();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Internships</title>
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/company/internships.jsp"><i class="fa-solid fa-briefcase"></i> My Internships</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/company/applications.jsp"><i class="fa-solid fa-file-lines"></i> Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <h4 class="mb-0">My Internships</h4>
        </div>
        <div class="card shadow-sm border-0 mt-4">
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Title</th>
                        <th>Location</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Internship internship : internships) { %>
                    <tr>
                        <td><%= internship.getTitle() %></td>
                        <td><%= internship.getLocation() %></td>
                        <td><%= internship.getInternshipType() %></td>
                        <td>
                            <% if ("APPROVED".equalsIgnoreCase(internship.getStatus())) { %>
                            <span class="badge bg-success">Approved</span>
                            <% } else if ("REJECTED".equalsIgnoreCase(internship.getStatus())) { %>
                            <span class="badge bg-danger">Rejected</span>
                            <% } else { %>
                            <span class="badge bg-warning text-dark">Pending</span>
                            <% } %>
                        </td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/company-internships" class="d-inline">
                                <input type="hidden" name="internshipId" value="<%= internship.getId() %>">
                                <input type="hidden" name="title" value="<%= internship.getTitle() %>">
                                <input type="hidden" name="description" value="<%= internship.getDescription() %>">
                                <input type="hidden" name="skills" value="<%= internship.getSkills() %>">
                                <input type="hidden" name="location" value="<%= internship.getLocation() %>">
                                <input type="hidden" name="internshipType" value="<%= internship.getInternshipType() %>">
                                <input type="hidden" name="duration" value="<%= internship.getDuration() %>">
                                <input type="hidden" name="stipend" value="<%= internship.getStipend() %>">
                                <input type="hidden" name="requirements" value="<%= internship.getRequirements() %>">
                                <input type="hidden" name="benefits" value="<%= internship.getBenefits() %>">
                                <input type="hidden" name="deadline" value="<%= internship.getDeadline() %>">
                                <button class="btn btn-sm btn-outline-primary" type="submit">Edit</button>
                            </form>
                            <form method="post" action="${pageContext.request.contextPath}/company-internships" class="d-inline">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="internshipId" value="<%= internship.getId() %>">
                                <button class="btn btn-sm btn-outline-danger" type="submit">Delete</button>
                            </form>
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
