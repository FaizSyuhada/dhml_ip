<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.Booking, java.util.List" %>
<% 
    User user = (User) session.getAttribute("user");
    @SuppressWarnings("unchecked")
    List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Bookings - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <h2><i class="bi bi-calendar-check"></i> Booking Requests</h2>
        <% if (bookings != null && !bookings.isEmpty()) { %>
            <div class="list-group">
                <% for (Booking booking : bookings) { %>
                <div class="list-group-item">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h6>User ID: <%= booking.getUserId() %></h6>
                            <p><strong>Date:</strong> <%= booking.getPreferredDate() %> at <%= booking.getPreferredTime() %></p>
                            <p><strong>Reason:</strong> <%= booking.getReason() != null ? booking.getReason() : "Not specified" %></p>
                        </div>
                        <span class="badge bg-warning">PENDING</span>
                    </div>
                    <form method="post" class="mt-2">
                        <input type="hidden" name="booking_id" value="<%= booking.getId() %>">
                        <textarea class="form-control mb-2" name="notes" placeholder="Add notes..."></textarea>
                        <button type="submit" class="btn btn-sm btn-primary">Save Notes</button>
                    </form>
                </div>
                <% } %>
            </div>
        <% } else { %>
            <p class="text-muted">No pending bookings.</p>
        <% } %>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

