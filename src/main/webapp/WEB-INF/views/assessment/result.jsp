<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<% 
    User user = (User) session.getAttribute("user");
    String type = (String) request.getAttribute("type");
    Integer score = (Integer) request.getAttribute("score");
    String severity = (String) request.getAttribute("severity");
    Boolean highRisk = (Boolean) request.getAttribute("highRisk");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Assessment Result - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body text-center p-5">
                        <i class="bi bi-clipboard-check" style="font-size: 80px; color: #667eea;"></i>
                        <h2 class="mt-3"><%= type %> Results</h2>
                        <div class="alert <%= highRisk ? "alert-warning" : "alert-info" %> mt-4">
                            <h3>Score: <%= score %> / <%= "PHQ9".equals(type) ? "27" : "21" %></h3>
                            <h4>Severity: <%= severity %></h4>
                        </div>
                        <% if (highRisk) { %>
                        <div class="alert alert-danger">
                            <i class="bi bi-exclamation-triangle"></i> <strong>Recommendation:</strong> 
                            Your score indicates you may benefit from professional support. Please consider booking a counselling session.
                            <div class="mt-3">
                                <a href="<%= request.getContextPath() %>/booking" class="btn btn-danger">Book Counselling Now</a>
                            </div>
                        </div>
                        <% } %>
                        <div class="mt-4">
                            <a href="<%= request.getContextPath() %>/ai-coach" class="btn btn-primary me-2">
                                <i class="bi bi-robot"></i> Generate Care Plan
                            </a>
                            <a href="<%= request.getContextPath() %>/assessment" class="btn btn-secondary">
                                <i class="bi bi-arrow-left"></i> Back
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

