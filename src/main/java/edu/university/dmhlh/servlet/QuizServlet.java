package edu.university.dmhlh.servlet;

import edu.university.dmhlh.dao.QuizDAO;
import edu.university.dmhlh.model.Quiz;
import edu.university.dmhlh.model.QuizQuestion;
import edu.university.dmhlh.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to handle quiz functionality
 */
@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(QuizServlet.class);
    private QuizDAO quizDAO = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String quizIdStr = request.getParameter("id");
        if (quizIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/modules");
            return;
        }

        try {
            Integer quizId = Integer.parseInt(quizIdStr);
            Quiz quiz = quizDAO.findById(quizId);
            
            if (quiz != null) {
                request.setAttribute("quiz", quiz);
                request.getRequestDispatcher("/WEB-INF/views/modules/quiz.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/modules");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/modules");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String quizIdStr = request.getParameter("quiz_id");
        if (quizIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/modules");
            return;
        }

        try {
            Integer quizId = Integer.parseInt(quizIdStr);
            Quiz quiz = quizDAO.findById(quizId);
            
            if (quiz == null) {
                response.sendRedirect(request.getContextPath() + "/modules");
                return;
            }

            // Calculate score
            List<QuizQuestion> questions = quiz.getQuestions();
            int correctAnswers = 0;
            
            for (QuizQuestion question : questions) {
                String userAnswer = request.getParameter("q_" + question.getId());
                if (userAnswer != null && userAnswer.equals(question.getCorrectAnswer())) {
                    correctAnswers++;
                }
            }

            // Save result
            quizDAO.saveResult(user.getId(), quizId, correctAnswers, questions.size());
            
            // Calculate percentage
            int percentage = (correctAnswers * 100) / questions.size();
            boolean passed = percentage >= 70;

            // Redirect to results
            response.sendRedirect(request.getContextPath() + "/quiz/result?quiz_id=" + quizId + 
                                  "&score=" + correctAnswers + "&total=" + questions.size() + 
                                  "&passed=" + passed);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/modules");
        }
    }
}

