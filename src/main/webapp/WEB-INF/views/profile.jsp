<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - DMHLH</title>
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
                <h2><i class="bi bi-person-circle"></i> My Profile</h2>
                <hr>

                <% if (request.getAttribute("success") != null) { %>
                    <div class="alert alert-success alert-dismissible fade show">
                        <%= request.getAttribute("success") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger alert-dismissible fade show">
                        <%= request.getAttribute("error") %>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                <% } %>

                <div class="card">
                    <div class="card-body">
                        <form action="<%= request.getContextPath() %>/profile" method="post">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" value="<%= user.getEmail() %>" disabled>
                                    <small class="text-muted">Email cannot be changed</small>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="role" class="form-label">Role</label>
                                    <input type="text" class="form-control" id="role" value="<%= user.getRole() %>" disabled>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="full_name" class="form-label">Full Name *</label>
                                <input type="text" class="form-control" id="full_name" name="full_name" 
                                       value="<%= user.getFullName() %>" required>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label for="language" class="form-label">Language</label>
                                    <select class="form-select" id="language" name="language">
                                        <option value="en" <%= "en".equals(user.getLanguagePref()) ? "selected" : "" %>>English</option>
                                        <option value="ms" <%= "ms".equals(user.getLanguagePref()) ? "selected" : "" %>>Bahasa Melayu</option>
                                        <option value="zh" <%= "zh".equals(user.getLanguagePref()) ? "selected" : "" %>>中文</option>
                                    </select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="font_size" class="form-label">Font Size</label>
                                    <select class="form-select" id="font_size" name="font_size">
                                        <option value="small" <%= "small".equals(user.getAccessibilityFontSize()) ? "selected" : "" %>>Small</option>
                                        <option value="medium" <%= "medium".equals(user.getAccessibilityFontSize()) ? "selected" : "" %>>Medium</option>
                                        <option value="large" <%= "large".equals(user.getAccessibilityFontSize()) ? "selected" : "" %>>Large</option>
                                    </select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label for="contrast" class="form-label">Contrast</label>
                                    <select class="form-select" id="contrast" name="contrast">
                                        <option value="normal" <%= "normal".equals(user.getAccessibilityContrast()) ? "selected" : "" %>>Normal</option>
                                        <option value="high" <%= "high".equals(user.getAccessibilityContrast()) ? "selected" : "" %>>High</option>
                                    </select>
                                </div>
                            </div>

                            <div class="alert alert-info">
                                <i class="bi bi-info-circle"></i> 
                                <strong>Consent Status:</strong> 
                                <% if (user.hasConsented()) { %>
                                    Accepted on <%= user.getConsentAcceptedAt() %>
                                <% } else { %>
                                    Not accepted
                                <% } %>
                            </div>

                            <div class="d-flex justify-content-between">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-save"></i> Save Changes
                                </button>
                                <a href="<%= request.getContextPath() %>/<%= user.getRole().toLowerCase() %>/dashboard" 
                                   class="btn btn-secondary">
                                    <i class="bi bi-arrow-left"></i> Back to Dashboard
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

