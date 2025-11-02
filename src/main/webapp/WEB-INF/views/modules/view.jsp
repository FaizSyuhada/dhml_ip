<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.LearningModule, edu.university.dmhlh.model.Quiz" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    LearningModule module = (LearningModule) request.getAttribute("module");
    Integer progress = (Integer) request.getAttribute("progress");
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    
    if (module == null) {
        response.sendRedirect(request.getContextPath() + "/modules");
        return;
    }
    
    if (progress == null) progress = 0;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= module.getTitle() %> - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="<%= request.getContextPath() %>/modules">Modules</a></li>
                        <li class="breadcrumb-item active"><%= module.getTitle() %></li>
                    </ol>
                </nav>

                <h2><%= module.getTitle() %></h2>
                <p class="text-muted"><%= module.getDescription() %></p>

                <div class="mb-3">
                    <span class="badge bg-info"><%= module.getContentType() %></span>
                    <span class="badge bg-secondary"><i class="bi bi-clock"></i> <%= module.getDurationMinutes() %> min</span>
                </div>

                <div class="progress mb-4">
                    <div class="progress-bar" role="progressbar" style="width: <%= progress %>%">
                        <%= progress %>%
                    </div>
                </div>

                <div class="card mb-4">
                    <div class="card-body">
                        <h4>Content</h4>
                        <hr>
                        
                        <% if ("VIDEO".equals(module.getContentType()) && module.getContentUrl() != null) { %>
                            <div class="ratio ratio-16x9 mb-3">
                                <iframe src="<%= module.getContentUrl() %>" allowfullscreen></iframe>
                            </div>
                        <% } %>
                        
                        <% if (module.getContentText() != null) { %>
                            <div class="content-text">
                                <%= module.getContentText().replace("\n", "<br>") %>
                            </div>
                        <% } %>
                    </div>
                </div>

                <div class="d-flex justify-content-between mb-4">
                    <form method="post" action="<%= request.getContextPath() %>/modules">
                        <input type="hidden" name="module_id" value="<%= module.getId() %>">
                        <input type="hidden" name="progress" value="100">
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-check-circle"></i> Mark as Complete
                        </button>
                    </form>

                    <% if (quiz != null) { %>
                        <a href="<%= request.getContextPath() %>/quiz?id=<%= quiz.getId() %>" class="btn btn-primary">
                            <i class="bi bi-clipboard-check"></i> Take Quiz
                        </a>
                    <% } %>
                </div>

                <a href="<%= request.getContextPath() %>/modules" class="btn btn-secondary">
                    <i class="bi bi-arrow-left"></i> Back to Modules
                </a>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

