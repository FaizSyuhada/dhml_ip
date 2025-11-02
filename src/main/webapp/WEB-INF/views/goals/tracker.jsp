<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<% User user = (User) session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
    <title>Goals & Habits - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3"><%@ include file="/WEB-INF/includes/sidebar.jsp" %></div>
            <div class="col-md-9">
                <h2><i class="bi bi-target"></i> Goals & Habits Tracker</h2>
                <p class="text-muted">Track your wellness goals and build healthy habits</p>
                
                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> <strong>Prototype Feature:</strong> 
                    Full goal tracking and habit logging functionality will be available in the production release.
                </div>

                <div class="card mb-4">
                    <div class="card-header bg-primary text-white">
                        <h5><i class="bi bi-heart-pulse"></i> Self-Care Activities</h5>
                    </div>
                    <div class="card-body">
                        <h6>Suggested Activities:</h6>
                        <ul>
                            <li>Practice deep breathing for 5 minutes daily</li>
                            <li>Go for a 20-minute walk outside</li>
                            <li>Write in a gratitude journal</li>
                            <li>Practice mindfulness meditation</li>
                            <li>Connect with a friend or family member</li>
                            <li>Get 7-9 hours of sleep</li>
                        </ul>
                        <button class="btn btn-success" disabled>Start Activity (Coming Soon)</button>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="bi bi-trophy" style="font-size: 48px; color: gold;"></i>
                                <h5 class="mt-2">Achievements</h5>
                                <p class="text-muted">Track your progress and earn badges</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card">
                            <div class="card-body text-center">
                                <i class="bi bi-calendar-week" style="font-size: 48px; color: #667eea;"></i>
                                <h5 class="mt-2">Habit Streaks</h5>
                                <p class="text-muted">Build consistency over time</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

