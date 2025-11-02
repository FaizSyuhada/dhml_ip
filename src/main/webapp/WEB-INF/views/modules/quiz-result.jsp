<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.Quiz" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    Integer score = (Integer) request.getAttribute("score");
    Integer total = (Integer) request.getAttribute("total");
    Boolean passed = (Boolean) request.getAttribute("passed");
    Integer percentage = (Integer) request.getAttribute("percentage");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Results - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .result-card {
            text-align: center;
            padding: 40px;
        }
        .result-icon {
            font-size: 100px;
            margin-bottom: 20px;
        }
        .score-display {
            font-size: 48px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card result-card">
                    <div class="card-body">
                        <% if (passed) { %>
                            <div class="result-icon text-success">
                                <i class="bi bi-check-circle"></i>
                            </div>
                            <h2 class="text-success">Congratulations!</h2>
                            <p class="lead">You passed the quiz!</p>
                        <% } else { %>
                            <div class="result-icon text-warning">
                                <i class="bi bi-exclamation-circle"></i>
                            </div>
                            <h2 class="text-warning">Keep Trying!</h2>
                            <p class="lead">You didn't pass this time, but you can try again.</p>
                        <% } %>

                        <div class="score-display mt-4 mb-4">
                            <%= score %> / <%= total %>
                        </div>

                        <div class="progress mb-3" style="height: 30px;">
                            <div class="progress-bar <%= passed ? "bg-success" : "bg-warning" %>" 
                                 role="progressbar" style="width: <%= percentage %>%; font-size: 16px;">
                                <%= percentage %>%
                            </div>
                        </div>

                        <p class="text-muted">
                            <% if (passed) { %>
                                Great job! You scored <%= percentage %>% on this quiz.
                            <% } else { %>
                                You scored <%= percentage %>%. The passing score is <%= quiz.getPassingScore() %>%.
                            <% } %>
                        </p>

                        <div class="mt-4">
                            <a href="<%= request.getContextPath() %>/modules?action=view&id=<%= quiz.getModuleId() %>" 
                               class="btn btn-primary me-2">
                                <i class="bi bi-arrow-left"></i> Back to Module
                            </a>
                            <% if (!passed) { %>
                                <a href="<%= request.getContextPath() %>/quiz?id=<%= quiz.getId() %>" 
                                   class="btn btn-warning">
                                    <i class="bi bi-arrow-repeat"></i> Retry Quiz
                                </a>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

