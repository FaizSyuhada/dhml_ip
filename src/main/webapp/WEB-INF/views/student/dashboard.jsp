<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !user.isStudent()) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .dashboard-card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,.1);
            transition: transform 0.3s;
            height: 100%;
        }
        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 12px rgba(0,0,0,.15);
        }
        .dashboard-card .card-body {
            padding: 25px;
        }
        .dashboard-card i {
            font-size: 48px;
            margin-bottom: 15px;
        }
        .welcome-banner {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 30px;
            margin-bottom: 30px;
        }
        .quick-link {
            text-decoration: none;
            color: inherit;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <div class="container mt-4">
        <div class="welcome-banner">
            <h2><i class="bi bi-hand-wave"></i> Welcome back, <%= user.getFullName() %>!</h2>
            <p class="mb-0">Let's continue your mental health wellness journey today.</p>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <a href="<%= request.getContextPath() %>/modules" class="quick-link">
                    <div class="dashboard-card card text-center">
                        <div class="card-body">
                            <i class="bi bi-book text-primary"></i>
                            <h5>Learning Modules</h5>
                            <p class="text-muted">Explore mental health topics</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-3">
                <a href="<%= request.getContextPath() %>/assessment" class="quick-link">
                    <div class="dashboard-card card text-center">
                        <div class="card-body">
                            <i class="bi bi-clipboard-check text-success"></i>
                            <h5>Self-Assessment</h5>
                            <p class="text-muted">PHQ-9 & GAD-7</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-3">
                <a href="<%= request.getContextPath() %>/mood" class="quick-link">
                    <div class="dashboard-card card text-center">
                        <div class="card-body">
                            <i class="bi bi-emoji-smile text-warning"></i>
                            <h5>Mood Tracker</h5>
                            <p class="text-muted">Log your daily mood</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-3">
                <a href="<%= request.getContextPath() %>/goals" class="quick-link">
                    <div class="dashboard-card card text-center">
                        <div class="card-body">
                            <i class="bi bi-target text-danger"></i>
                            <h5>Goals & Habits</h5>
                            <p class="text-muted">Track your progress</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/ai-coach" class="quick-link">
                    <div class="dashboard-card card text-center">
                        <div class="card-body">
                            <i class="bi bi-robot text-info"></i>
                            <h5>AI Coach</h5>
                            <p class="text-muted">Get personalized recommendations</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/booking" class="quick-link">
                    <div class="dashboard-card card text-center">
                        <div class="card-body">
                            <i class="bi bi-calendar-check text-primary"></i>
                            <h5>Book Counselling</h5>
                            <p class="text-muted">Schedule a session</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4">
                <a href="<%= request.getContextPath() %>/forum" class="quick-link">
                    <div class="dashboard-card card text-center">
                        <div class="card-body">
                            <i class="bi bi-chat-dots text-success"></i>
                            <h5>Peer Forum</h5>
                            <p class="text-muted">Connect with others</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <div class="alert alert-info mt-4">
            <h5><i class="bi bi-lightbulb"></i> Quick Tips</h5>
            <ul class="mb-0">
                <li>Complete a self-assessment to get personalized care recommendations</li>
                <li>Log your mood daily to track patterns and triggers</li>
                <li>Explore learning modules to increase your mental health literacy</li>
                <li>Don't hesitate to book a counselling session if you need support</li>
            </ul>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

