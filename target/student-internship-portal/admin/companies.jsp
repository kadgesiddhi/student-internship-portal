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
    List<Company> companies = CompanyDAO.getAllCompanies();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Companies</title>
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/companies.jsp"><i class="fa-solid fa-building"></i> Companies</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/internships.jsp"><i class="fa-solid fa-briefcase"></i> Internships</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/admin/applications.jsp"><i class="fa-solid fa-file-lines"></i> Applications</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
        </nav>
    </aside>
    <main class="content-area">
        <div class="topbar">
            <h4 class="mb-0">Company Management</h4>
        </div>
        <div class="card shadow-sm border-0 mt-4">
            <div class="table-responsive">
                <table class="table align-middle mb-0">
                    <thead class="table-light">
                    <tr>
                        <th>Company</th>
                        <th>Location</th>
                        <th>Approval</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Company company : companies) { %>
                    <% User user = UserDAO.findById(company.getUserId()); %>
                    <tr>
                        <td><%= company.getCompanyName() %></td>
                        <td><%= company.getLocation() %></td>
                        <td>
                            <% if ("APPROVED".equalsIgnoreCase(company.getApprovalStatus())) { %>
                            <span class="badge bg-success">Approved</span>
                            <% } else if ("REJECTED".equalsIgnoreCase(company.getApprovalStatus())) { %>
                            <span class="badge bg-danger">Rejected</span>
                            <% } else { %>
                            <span class="badge bg-warning text-dark">Pending</span>
                            <% } %>
                        </td>
                        <td>
                            <% if (user != null && "ACTIVE".equalsIgnoreCase(user.getStatus())) { %>
                            <span class="badge bg-success">Active</span>
                            <% } else { %>
                            <span class="badge bg-secondary">Inactive</span>
                            <% } %>
                        </td>
                        <td>
                            <div class="d-flex gap-2 flex-wrap">
                                <a href="${pageContext.request.contextPath}/admin?action=approve-company&companyId=<%= company.getId() %>" class="btn btn-sm btn-success">Approve</a>
                                <a href="${pageContext.request.contextPath}/admin?action=reject-company&companyId=<%= company.getId() %>" class="btn btn-sm btn-danger">Reject</a>
                                <% if (user != null) { %>
                                <a href="${pageContext.request.contextPath}/admin?action=toggle-company-user&userId=<%= user.getId() %>&status=<%= user.getStatus() %>" class="btn btn-sm btn-outline-primary">
                                    <%= "ACTIVE".equalsIgnoreCase(user.getStatus()) ? "Deactivate" : "Activate" %>
                                </a>
                                <% } %>
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
