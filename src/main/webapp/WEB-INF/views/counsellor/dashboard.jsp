<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.isCounsellor()) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Counsellor Dashboard - DMHLH</title>
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
                <h2><i class="bi bi-speedometer2"></i> Counsellor Dashboard</h2>
                <p class="text-muted">Welcome, <%= user.getFullName() %></p>
                <hr>

                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="bi bi-calendar-check" style="font-size: 48px; color: #667eea;"></i>
                                <h5 class="mt-3">Manage Bookings</h5>
                                <p class="text-muted">View and manage student counselling requests</p>
                                <a href="<%= request.getContextPath() %>/counsellor/bookings" class="btn btn-primary">
                                    View Bookings
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="bi bi-shield-check" style="font-size: 48px; color: #28a745;"></i>
                                <h5 class="mt-3">Moderate Forum</h5>
                                <p class="text-muted">Review and moderate reported forum posts</p>
                                <a href="<%= request.getContextPath() %>/forum/moderate" class="btn btn-success">
                                    Moderate
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="alert alert-info mt-4">
                    <h5><i class="bi bi-info-circle"></i> Counsellor Guidelines</h5>
                    <ul class="mb-0">
                        <li>Respond to booking requests within 24 hours</li>
                        <li>Add notes after each session for continuity of care</li>
                        <li>Monitor forum for posts requiring professional intervention</li>
                        <li>Maintain confidentiality and professional boundaries</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

