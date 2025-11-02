<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<% User user = (User) session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
    <title>Book Counselling - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-3"><%@ include file="/WEB-INF/includes/sidebar.jsp" %></div>
            <div class="col-md-9">
                <h2><i class="bi bi-calendar-check"></i> Book Counselling Session</h2>
                <% if (request.getParameter("success") != null) { %>
                    <div class="alert alert-success">Your booking request has been submitted! A counsellor will contact you soon.</div>
                <% } %>
                <div class="card">
                    <div class="card-body">
                        <form method="post" action="<%= request.getContextPath() %>/booking">
                            <div class="mb-3">
                                <label for="preferred_date" class="form-label">Preferred Date *</label>
                                <input type="date" class="form-control" id="preferred_date" name="preferred_date" required>
                            </div>
                            <div class="mb-3">
                                <label for="preferred_time" class="form-label">Preferred Time *</label>
                                <input type="time" class="form-control" id="preferred_time" name="preferred_time" required>
                            </div>
                            <div class="mb-3">
                                <label for="reason" class="form-label">Reason for Booking (optional)</label>
                                <textarea class="form-control" id="reason" name="reason" rows="4" 
                                    placeholder="Briefly describe what you'd like to discuss..."></textarea>
                            </div>
                            <div class="alert alert-info">
                                <i class="bi bi-shield-lock"></i> Your information is confidential and will only be shared with your assigned counsellor.
                            </div>
                            <button type="submit" class="btn btn-primary"><i class="bi bi-send"></i> Submit Booking Request</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

