<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<% User user = (User) session.getAttribute("user"); %>
<!DOCTYPE html>
<html>
<head>
    <title>GAD-7 Assessment - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>
    <div class="container mt-4">
        <h2>GAD-7: Anxiety Screening</h2>
        <p class="text-muted">Over the last 2 weeks, how often have you been bothered by the following problems?</p>
        <form method="post" action="<%= request.getContextPath() %>/assessment">
            <input type="hidden" name="assessment_type" value="GAD7">
            <% String[] questions = {
                "Feeling nervous, anxious, or on edge",
                "Not being able to stop or control worrying",
                "Worrying too much about different things",
                "Trouble relaxing",
                "Being so restless that it's hard to sit still",
                "Becoming easily annoyed or irritable",
                "Feeling afraid as if something awful might happen"
            };
            for (int i = 0; i < questions.length; i++) { %>
            <div class="card mb-3">
                <div class="card-body">
                    <h6><%= i+1 %>. <%= questions[i] %></h6>
                    <div class="form-check"><input class="form-check-input" type="radio" name="q<%= i+1 %>" value="0" required><label class="form-check-label">Not at all (0)</label></div>
                    <div class="form-check"><input class="form-check-input" type="radio" name="q<%= i+1 %>" value="1"><label class="form-check-label">Several days (1)</label></div>
                    <div class="form-check"><input class="form-check-input" type="radio" name="q<%= i+1 %>" value="2"><label class="form-check-label">More than half the days (2)</label></div>
                    <div class="form-check"><input class="form-check-input" type="radio" name="q<%= i+1 %>" value="3"><label class="form-check-label">Nearly every day (3)</label></div>
                </div>
            </div>
            <% } %>
            <button type="submit" class="btn btn-success">Submit Assessment</button>
        </form>
    </div>
    <%@ include file="/WEB-INF/includes/footer.jsp" %>
</body>
</html>

