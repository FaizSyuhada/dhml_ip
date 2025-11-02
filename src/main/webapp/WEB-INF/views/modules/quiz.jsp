<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User, edu.university.dmhlh.model.Quiz, edu.university.dmhlh.model.QuizQuestion, java.util.List" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    Quiz quiz = (Quiz) request.getAttribute("quiz");
    if (quiz == null) {
        response.sendRedirect(request.getContextPath() + "/modules");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= quiz.getTitle() %> - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <%@ include file="/WEB-INF/includes/header.jsp" %>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-10">
                <h2><i class="bi bi-clipboard-check"></i> <%= quiz.getTitle() %></h2>
                <p class="text-muted"><%= quiz.getDescription() %></p>

                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> 
                    <strong>Instructions:</strong> Answer all questions. Passing score is <%= quiz.getPassingScore() %>%.
                </div>

                <form method="post" action="<%= request.getContextPath() %>/quiz">
                    <input type="hidden" name="quiz_id" value="<%= quiz.getId() %>">

                    <% 
                    List<QuizQuestion> questions = quiz.getQuestions();
                    int questionNumber = 1;
                    for (QuizQuestion question : questions) { 
                    %>
                    <div class="card mb-3">
                        <div class="card-body">
                            <h5>Question <%= questionNumber++ %></h5>
                            <p><%= question.getQuestionText() %></p>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" 
                                       name="q_<%= question.getId() %>" 
                                       id="q<%= question.getId() %>_a" value="A" required>
                                <label class="form-check-label" for="q<%= question.getId() %>_a">
                                    A) <%= question.getOptionA() %>
                                </label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" 
                                       name="q_<%= question.getId() %>" 
                                       id="q<%= question.getId() %>_b" value="B">
                                <label class="form-check-label" for="q<%= question.getId() %>_b">
                                    B) <%= question.getOptionB() %>
                                </label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" 
                                       name="q_<%= question.getId() %>" 
                                       id="q<%= question.getId() %>_c" value="C">
                                <label class="form-check-label" for="q<%= question.getId() %>_c">
                                    C) <%= question.getOptionC() %>
                                </label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" 
                                       name="q_<%= question.getId() %>" 
                                       id="q<%= question.getId() %>_d" value="D">
                                <label class="form-check-label" for="q<%= question.getId() %>_d">
                                    D) <%= question.getOptionD() %>
                                </label>
                            </div>
                        </div>
                    </div>
                    <% } %>

                    <div class="d-flex justify-content-between">
                        <a href="<%= request.getContextPath() %>/modules" class="btn btn-secondary">
                            <i class="bi bi-arrow-left"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="bi bi-check-circle"></i> Submit Quiz
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="/WEB-INF/includes/footer.jsp" %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

