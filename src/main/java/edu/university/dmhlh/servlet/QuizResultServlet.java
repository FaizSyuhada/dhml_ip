package edu.university.dmhlh.servlet;

import edu.university.dmhlh.dao.QuizDAO;
import edu.university.dmhlh.model.Quiz;
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

/**
 * Servlet to display quiz results
 */
@WebServlet("/quiz/result")
public class QuizResultServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(QuizResultServlet.class);
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

        String quizIdStr = request.getParameter("quiz_id");
        String scoreStr = request.getParameter("score");
        String totalStr = request.getParameter("total");
        String passedStr = request.getParameter("passed");

        if (quizIdStr != null && scoreStr != null && totalStr != null) {
            try {
                Integer quizId = Integer.parseInt(quizIdStr);
                Integer score = Integer.parseInt(scoreStr);
                Integer total = Integer.parseInt(totalStr);
                boolean passed = Boolean.parseBoolean(passedStr);

                Quiz quiz = quizDAO.findById(quizId);
                
                request.setAttribute("quiz", quiz);
                request.setAttribute("score", score);
                request.setAttribute("total", total);
                request.setAttribute("passed", passed);
                request.setAttribute("percentage", (score * 100) / total);
                
                request.getRequestDispatcher("/WEB-INF/views/modules/quiz-result.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/modules");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/modules");
        }
    }
}

