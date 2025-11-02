<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.LearningModule, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    @SuppressWarnings("unchecked")
    List<LearningModule> modules = (List<LearningModule>) request.getAttribute("modules");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Learning Modules - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .module-card {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .module-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        .module-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3">
                <%@ include file="/WEB-INF/includes/sidebar.jsp" %>
            </div>
            <div class="col-md-9">
                <h2><i class="bi bi-book"></i> Learning Modules</h2>
                <p class="text-muted">Explore mental health topics and increase your literacy</p>
                <hr>

                <% if (modules != null && !modules.isEmpty()) { %>
                    <div class="row g-4">
                        <% for (LearningModule module : modules) { %>
                        <div class="col-md-6">
                            <div class="card module-card">
                                <div class="card-body">
                                    <div class="text-center text-primary module-icon">
                                        <% 
                                        String icon = "bi-file-text";
                                        if ("VIDEO".equals(module.getContentType())) {
                                            icon = "bi-play-circle";
                                        } else if ("INFOGRAPHIC".equals(module.getContentType())) {
                                            icon = "bi-image";
                                        }
                                        %>
                                        <i class="bi <%= icon %>"></i>
                                    </div>
                                    <h5 class="card-title"><%= module.getTitle() %></h5>
                                    <p class="card-text"><%= module.getDescription() %></p>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <small class="text-muted">
                                            <i class="bi bi-clock"></i> <%= module.getDurationMinutes() %> minutes
                                        </small>
                                        <span class="badge bg-info"><%= module.getContentType() %></span>
                                    </div>
                                    <div class="mt-3">
                                        <a href="<%= request.getContextPath() %>/modules?action=view&id=<%= module.getId() %>" 
                                           class="btn btn-primary w-100">
                                            <i class="bi bi-eye"></i> View Module
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i> No learning modules available at this time.
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

