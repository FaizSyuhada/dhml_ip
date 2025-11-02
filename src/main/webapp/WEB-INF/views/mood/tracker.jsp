<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.MoodLog, java.util.List" %>
<% 
    User user = (User) session.getAttribute("user");
    @SuppressWarnings("unchecked")
    List<MoodLog> recentLogs = (List<MoodLog>) request.getAttribute("recentLogs");
    Boolean showNudge = (Boolean) request.getAttribute("showNudge");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Mood Tracker - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3"><%@ include file="/WEB-INF/includes/sidebar.jsp" %></div>
            <div class="col-md-9">
                <h2><i class="bi bi-emoji-smile"></i> Mood Tracker</h2>
                <% if (showNudge && showNudge) { %>
                <div class="alert alert-warning">
                    <i class="bi bi-heart-pulse"></i> <strong>Light Nudge:</strong> 
                    We noticed your recent moods have been low. Remember to take care of yourself. 
                    Consider trying a self-care activity or reaching out for support.
                </div>
                <% } %>
                <div class="card mb-4">
                    <div class="card-header bg-primary text-white"><h5>Log Today's Mood</h5></div>
                    <div class="card-body">
                        <form method="post" action="<%= request.getContextPath() %>/mood">
                            <div class="mb-3">
                                <label class="form-label">How are you feeling today?</label>
                                <div class="d-flex justify-content-between">
                                    <% String[] emojis = {"😢", "😟", "😐", "🙂", "😄"};
                                       for (int i = 1; i <= 5; i++) { %>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="rating" value="<%= i %>" id="mood<%= i %>" required>
                                        <label class="form-check-label" for="mood<%= i %>" style="font-size: 32px;"><%= emojis[i-1] %></label>
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="note" class="form-label">Note (optional)</label>
                                <textarea class="form-control" id="note" name="note" rows="3"></textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Save Mood</button>
                        </form>
                    </div>
                </div>
                <h5>Recent Mood History (Last 14 Days)</h5>
                <% if (recentLogs != null && !recentLogs.isEmpty()) { %>
                    <div class="list-group">
                        <% for (MoodLog log : recentLogs) { %>
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between">
                                <div>
                                    <span style="font-size: 24px;"><%= log.getRating() == 1 ? "😢" : log.getRating() == 2 ? "😟" : log.getRating() == 3 ? "😐" : log.getRating() == 4 ? "🙂" : "😄" %></span>
                                    Rating: <%= log.getRating() %>/5
                                    <% if (log.getNote() != null && !log.getNote().isEmpty()) { %>
                                        <p class="mb-0 text-muted"><small><%= log.getNote() %></small></p>
                                    <% } %>
                                </div>
                                <small class="text-muted"><%= log.getLoggedAt() %></small>
                            </div>
                        </div>
                        <% } %>
                    </div>
                <% } else { %>
                    <p class="text-muted">No mood logs yet. Start tracking today!</p>
                <% } %>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

