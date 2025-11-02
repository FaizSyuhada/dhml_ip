<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<% User user = (User) session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Referral - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <h2><i class="bi bi-person-exclamation"></i> Refer At-Risk Student</h2>
        <% if (request.getParameter("success") != null) { %>
            <div class="alert alert-success">Referral submitted successfully!</div>
        <% } %>
        <% if ("consent".equals(request.getParameter("error"))) { %>
            <div class="alert alert-danger">You must confirm student consent before submitting.</div>
        <% } %>
        
        <div class="card">
            <div class="card-body">
                <form method="post" action="<%= request.getContextPath() %>/faculty/referral">
                    <div class="mb-3">
                        <label for="student_email" class="form-label">Student Email *</label>
                        <input type="email" class="form-control" id="student_email" name="student_email" required>
                    </div>
                    <div class="mb-3">
                        <label for="student_name" class="form-label">Student Name *</label>
                        <input type="text" class="form-control" id="student_name" name="student_name" required>
                    </div>
                    <div class="mb-3">
                        <label for="concern" class="form-label">Concern Description *</label>
                        <textarea class="form-control" id="concern" name="concern" rows="5" required 
                                  placeholder="Describe specific, factual observations..."></textarea>
                    </div>
                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" id="consent_confirmed" name="consent_confirmed" required>
                        <label class="form-check-label" for="consent_confirmed">
                            <strong>I confirm that I have spoken with the student and obtained their consent to share this information.</strong>
                        </label>
                    </div>
                    <button type="submit" class="btn btn-danger"><i class="bi bi-send"></i> Submit Referral</button>
                </form>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

