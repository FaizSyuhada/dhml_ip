<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.isFaculty()) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard - DMHLH</title>
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
                <h2><i class="bi bi-speedometer2"></i> Faculty Dashboard</h2>
                <p class="text-muted">Welcome, <%= user.getFullName() %></p>
                <hr>

                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="bi bi-person-exclamation" style="font-size: 48px; color: #dc3545;"></i>
                                <h5 class="mt-3">Refer a Student</h5>
                                <p class="text-muted">Submit at-risk student referrals to counselling services</p>
                                <a href="<%= request.getContextPath() %>/faculty/referral" class="btn btn-danger">
                                    Submit Referral
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="bi bi-mortarboard" style="font-size: 48px; color: #667eea;"></i>
                                <h5 class="mt-3">Training Guides</h5>
                                <p class="text-muted">Access mental health training resources for faculty</p>
                                <a href="<%= request.getContextPath() %>/faculty/training" class="btn btn-primary">
                                    View Training
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="alert alert-warning mt-4">
                    <h5><i class="bi bi-exclamation-triangle"></i> Identifying At-Risk Students</h5>
                    <p>Watch for these warning signs:</p>
                    <ul class="mb-0">
                        <li>Significant decline in academic performance</li>
                        <li>Social withdrawal or isolation</li>
                        <li>Expressed hopelessness or despair</li>
                        <li>Increased absenteeism</li>
                        <li>Concerning written work or communications</li>
                    </ul>
                </div>

                <div class="card mt-4">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0"><i class="bi bi-info-circle"></i> Important Reminder</h5>
                    </div>
                    <div class="card-body">
                        <p>Before submitting a referral, please:</p>
                        <ul class="mb-0">
                            <li>Have a private conversation with the student about your concerns</li>
                            <li>Obtain the student's consent to share their information</li>
                            <li>Provide specific, factual observations (not diagnoses)</li>
                            <li>For immediate crises, contact campus security or emergency services</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

