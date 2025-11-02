<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.AssessmentResult" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    AssessmentResult latestPhq9 = (AssessmentResult) request.getAttribute("latestPhq9");
    AssessmentResult latestGad7 = (AssessmentResult) request.getAttribute("latestGad7");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Self-Assessment - DMHLH</title>
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
                <h2><i class="bi bi-clipboard-check"></i> Self-Assessment</h2>
                <p class="text-muted">Monitor your mental health with validated screening tools</p>
                <hr>

                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> 
                    <strong>Note:</strong> These assessments are screening tools only and do not replace professional diagnosis. 
                    If you're concerned about your mental health, please consult a healthcare provider.
                </div>

                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="bi bi-clipboard-heart"></i> PHQ-9</h5>
                                <small>Depression Screening</small>
                            </div>
                            <div class="card-body">
                                <p>The PHQ-9 is a 9-item questionnaire used to screen for depression.</p>
                                
                                <% if (latestPhq9 != null) { %>
                                    <div class="alert alert-secondary">
                                        <strong>Last Assessment:</strong><br>
                                        Score: <%= latestPhq9.getScore() %> / 27<br>
                                        Severity: <%= latestPhq9.getSeverity() %><br>
                                        <small class="text-muted"><%= latestPhq9.getTakenAt() %></small>
                                    </div>
                                <% } else { %>
                                    <p class="text-muted"><em>You haven't taken this assessment yet.</em></p>
                                <% } %>

                                <a href="<%= request.getContextPath() %>/assessment?type=phq9" class="btn btn-primary w-100">
                                    <i class="bi bi-play-circle"></i> <%= latestPhq9 != null ? "Retake" : "Take" %> PHQ-9
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="card h-100">
                            <div class="card-header bg-success text-white">
                                <h5 class="mb-0"><i class="bi bi-clipboard-pulse"></i> GAD-7</h5>
                                <small>Anxiety Screening</small>
                            </div>
                            <div class="card-body">
                                <p>The GAD-7 is a 7-item questionnaire used to screen for anxiety.</p>
                                
                                <% if (latestGad7 != null) { %>
                                    <div class="alert alert-secondary">
                                        <strong>Last Assessment:</strong><br>
                                        Score: <%= latestGad7.getScore() %> / 21<br>
                                        Severity: <%= latestGad7.getSeverity() %><br>
                                        <small class="text-muted"><%= latestGad7.getTakenAt() %></small>
                                    </div>
                                <% } else { %>
                                    <p class="text-muted"><em>You haven't taken this assessment yet.</em></p>
                                <% } %>

                                <a href="<%= request.getContextPath() %>/assessment?type=gad7" class="btn btn-success w-100">
                                    <i class="bi bi-play-circle"></i> <%= latestGad7 != null ? "Retake" : "Take" %> GAD-7
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-body">
                        <h5><i class="bi bi-lightbulb"></i> Next Steps</h5>
                        <ul class="mb-0">
                            <li>Complete both assessments to get a comprehensive view of your mental health</li>
                            <li>Use the AI Coach to generate a personalized care plan based on your results</li>
                            <li>Track your mood daily to identify patterns and triggers</li>
                            <li>Consider booking a counselling session if your scores indicate moderate or higher severity</li>
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

