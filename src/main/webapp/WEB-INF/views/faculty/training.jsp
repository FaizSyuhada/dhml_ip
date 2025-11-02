<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<% User user = (User) session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
    <title>Faculty Training - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <h2><i class="bi bi-mortarboard"></i> Faculty Training Resources</h2>
        <div class="card mb-3">
            <div class="card-body">
                <h5>Identifying At-Risk Students</h5>
                <p>Learn to recognize warning signs and provide appropriate support.</p>
                <a href="#" class="btn btn-primary">View Guide</a>
            </div>
        </div>
        <div class="card mb-3">
            <div class="card-body">
                <h5>Mental Health First Aid for Educators</h5>
                <p>Essential skills for supporting students in crisis.</p>
                <a href="#" class="btn btn-primary">View Guide</a>
            </div>
        </div>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

