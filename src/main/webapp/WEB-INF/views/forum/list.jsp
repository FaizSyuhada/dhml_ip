<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.ForumPost, java.util.List" %>
<% 
    User user = (User) session.getAttribute("user");
    @SuppressWarnings("unchecked")
    List<ForumPost> posts = (List<ForumPost>) request.getAttribute("posts");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Peer Forum - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <h2><i class="bi bi-chat-dots"></i> Peer Support Forum</h2>
        <div class="alert alert-info">
            <i class="bi bi-incognito"></i> Posts are anonymous. Your identity is protected.
        </div>
        
        <button class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#newPostModal">
            <i class="bi bi-plus-circle"></i> New Post
        </button>

        <% if (posts != null && !posts.isEmpty()) { %>
            <% for (ForumPost post : posts) { %>
            <div class="card mb-3">
                <div class="card-body">
                    <h5><%= post.getTitle() %></h5>
                    <p><%= post.getContent() %></p>
                    <small class="text-muted">Posted by <%= post.getPseudoId() %> on <%= post.getCreatedAt() %></small>
                </div>
            </div>
            <% } %>
        <% } else { %>
            <p class="text-muted">No posts yet. Be the first to share!</p>
        <% } %>
    </div>

    <!-- New Post Modal -->
    <div class="modal fade" id="newPostModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">New Forum Post</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <form method="post" action="<%= request.getContextPath() %>/forum">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="title" class="form-label">Title *</label>
                            <input type="text" class="form-control" id="title" name="title" required>
                        </div>
                        <div class="mb-3">
                            <label for="content" class="form-label">Content *</label>
                            <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary">Post Anonymously</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

