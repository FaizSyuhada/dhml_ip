<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.CarePlan, com.google.gson.Gson, com.google.gson.reflect.TypeToken, java.util.List" %>
<% 
    User user = (User) session.getAttribute("user");
    CarePlan carePlan = (CarePlan) request.getAttribute("carePlan");
%>
<!DOCTYPE html>
<html>
<head>
    <title>AI Coach - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3"><%@ include file="/WEB-INF/includes/sidebar.jsp" %></div>
            <div class="col-md-9">
                <h2><i class="bi bi-robot"></i> AI Coach & Care Plan</h2>
                
                <% if (carePlan != null) { %>
                    <div class="card mb-4">
                        <div class="card-header bg-<%= "SEVERE".equals(carePlan.getRiskLevel()) || "HIGH".equals(carePlan.getRiskLevel()) ? "danger" : "MODERATE".equals(carePlan.getRiskLevel()) ? "warning" : "success" %> text-white">
                            <h5><i class="bi bi-file-medical"></i> Your Care Plan</h5>
                            <small>Generated: <%= carePlan.getCreatedAt() %></small>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-<%= "SEVERE".equals(carePlan.getRiskLevel()) || "HIGH".equals(carePlan.getRiskLevel()) ? "danger" : "MODERATE".equals(carePlan.getRiskLevel()) ? "warning" : "info" %>">
                                <strong>Risk Level:</strong> <%= carePlan.getRiskLevel() %>
                                <% if (carePlan.getPhq9Score() != null) { %><br>PHQ-9 Score: <%= carePlan.getPhq9Score() %><% } %>
                                <% if (carePlan.getGad7Score() != null) { %><br>GAD-7 Score: <%= carePlan.getGad7Score() %><% } %>
                            </div>
                            <p><%= carePlan.getSummary() %></p>
                            
                            <h5>Personalized Recommendations:</h5>
                            <ul>
                                <% 
                                Gson gson = new Gson();
                                List<String> recommendations = gson.fromJson(carePlan.getRecommendationsJson(), new TypeToken<List<String>>(){}.getType());
                                for (String rec : recommendations) { %>
                                    <li><%= rec %></li>
                                <% } %>
                            </ul>
                            
                            <% if ("HIGH".equals(carePlan.getRiskLevel()) || "SEVERE".equals(carePlan.getRiskLevel())) { %>
                                <div class="alert alert-danger mt-3">
                                    <a href="<%= request.getContextPath() %>/booking" class="btn btn-danger">Book Counselling Now</a>
                                    <a href="tel:1-800-273-8255" class="btn btn-outline-danger ms-2">Crisis Hotline</a>
                                </div>
                            <% } %>
                        </div>
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> Complete your PHQ-9 or GAD-7 assessment to generate a personalized care plan.
                    </div>
                <% } %>
                
                <form method="post" action="<%= request.getContextPath() %>/ai-coach">
                    <button type="submit" class="btn btn-primary"><i class="bi bi-stars"></i> <%= carePlan != null ? "Regenerate" : "Generate" %> Care Plan</button>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

