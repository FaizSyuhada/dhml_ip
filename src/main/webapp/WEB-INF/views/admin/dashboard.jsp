<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.isAdmin()) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    Integer studentCount = (Integer) request.getAttribute("studentCount");
    Integer counsellorCount = (Integer) request.getAttribute("counsellorCount");
    Integer facultyCount = (Integer) request.getAttribute("facultyCount");
    
    if (studentCount == null) studentCount = 0;
    if (counsellorCount == null) counsellorCount = 0;
    if (facultyCount == null) facultyCount = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <%@ include file="/WEB-INF/includes/sidebar.jsp" %>
            </div>
            <div class="col-md-9">
                <h2><i class="bi bi-speedometer2"></i> Admin Dashboard</h2>
                <p class="text-muted">System Overview & Analytics</p>
                <hr>

                <h5 class="mb-3">User Statistics</h5>
                <div class="row g-3 mb-4">
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-primary"><%= studentCount %></h3>
                                <small class="text-muted">Students</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-success"><%= counsellorCount %></h3>
                                <small class="text-muted">Counsellors</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-info"><%= facultyCount %></h3>
                                <small class="text-muted">Faculty</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <h3 class="text-warning"><%= studentCount + counsellorCount + facultyCount + 1 %></h3>
                                <small class="text-muted">Total Users</small>
                            </div>
                        </div>
                    </div>
                </div>

                <h5 class="mb-3">Quick Actions</h5>
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h5><i class="bi bi-people"></i> Manage Users</h5>
                                <p class="text-muted">View, edit, and deactivate user accounts</p>
                                <a href="<%= request.getContextPath() %>/admin/users" class="btn btn-primary btn-sm">
                                    Manage
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h5><i class="bi bi-book"></i> Content Management</h5>
                                <p class="text-muted">Add and edit learning modules</p>
                                <a href="<%= request.getContextPath() %>/admin/modules" class="btn btn-info btn-sm">
                                    Manage
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h5><i class="bi bi-shield-check"></i> Forum Moderation</h5>
                                <p class="text-muted">Review and moderate reported posts</p>
                                <a href="<%= request.getContextPath() %>/forum/moderate" class="btn btn-warning btn-sm">
                                    Moderate
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body">
                                <h5><i class="bi bi-chat-left-text"></i> User Feedback</h5>
                                <p class="text-muted">View feedback and ratings</p>
                                <a href="<%= request.getContextPath() %>/admin/feedback" class="btn btn-success btn-sm">
                                    View
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="alert alert-info">
                    <h5><i class="bi bi-info-circle"></i> System Status</h5>
                    <p class="mb-0">
                        <i class="bi bi-check-circle text-success"></i> All systems operational<br>
                        <small class="text-muted">Last updated: <%= new java.util.Date() %></small>
                    </p>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

