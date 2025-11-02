package edu.university.dmhlh.servlet;

import com.google.gson.Gson;
import edu.university.dmhlh.dao.AssessmentDAO;
import edu.university.dmhlh.model.AssessmentResult;
import edu.university.dmhlh.model.User;
import edu.university.dmhlh.util.AssessmentUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * Servlet to handle PHQ-9 and GAD-7 assessments
 */
@WebServlet("/assessment")
public class AssessmentServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AssessmentServlet.class);
    private AssessmentDAO assessmentDAO = new AssessmentDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String type = request.getParameter("type");
        
        if ("phq9".equals(type)) {
            request.getRequestDispatcher("/WEB-INF/views/assessment/phq9.jsp").forward(request, response);
        } else if ("gad7".equals(type)) {
            request.getRequestDispatcher("/WEB-INF/views/assessment/gad7.jsp").forward(request, response);
        } else if ("history".equals(type)) {
            String assessmentType = request.getParameter("assessment_type");
            request.setAttribute("assessmentType", assessmentType);
            request.getRequestDispatcher("/WEB-INF/views/assessment/history.jsp").forward(request, response);
        } else {
            // Show assessment dashboard
            AssessmentResult latestPhq9 = assessmentDAO.getLatest(user.getId(), "PHQ9");
            AssessmentResult latestGad7 = assessmentDAO.getLatest(user.getId(), "GAD7");
            
            request.setAttribute("latestPhq9", latestPhq9);
            request.setAttribute("latestGad7", latestGad7);
            
            request.getRequestDispatcher("/WEB-INF/views/assessment/dashboard.jsp").forward(request, response);
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

        String type = request.getParameter("assessment_type");
        
        if ("PHQ9".equals(type)) {
            processPHQ9(request, response, user);
        } else if ("GAD7".equals(type)) {
            processGAD7(request, response, user);
        } else {
            response.sendRedirect(request.getContextPath() + "/assessment");
        }
    }

    private void processPHQ9(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        // Calculate score from answers
        int score = 0;
        Map<String, Integer> answers = new HashMap<>();
        
        for (int i = 1; i <= 9; i++) {
            String answer = request.getParameter("q" + i);
            if (answer != null) {
                int value = Integer.parseInt(answer);
                score += value;
                answers.put("q" + i, value);
            }
        }

        // Determine severity
        String severity = AssessmentUtil.calculatePHQ9Severity(score);

        // Save result
        AssessmentResult result = new AssessmentResult();
        result.setUserId(user.getId());
        result.setAssessmentType("PHQ9");
        result.setScore(score);
        result.setSeverity(severity);
        result.setAnswersJson(gson.toJson(answers));

        assessmentDAO.save(result);

        // Redirect to results
        response.sendRedirect(request.getContextPath() + "/assessment/result?type=PHQ9&score=" + score + 
                              "&severity=" + severity);
    }

    private void processGAD7(HttpServletRequest request, HttpServletResponse response, User user)
            throws IOException {
        
        // Calculate score from answers
        int score = 0;
        Map<String, Integer> answers = new HashMap<>();
        
        for (int i = 1; i <= 7; i++) {
            String answer = request.getParameter("q" + i);
            if (answer != null) {
                int value = Integer.parseInt(answer);
                score += value;
                answers.put("q" + i, value);
            }
        }

        // Determine severity
        String severity = AssessmentUtil.calculateGAD7Severity(score);

        // Save result
        AssessmentResult result = new AssessmentResult();
        result.setUserId(user.getId());
        result.setAssessmentType("GAD7");
        result.setScore(score);
        result.setSeverity(severity);
        result.setAnswersJson(gson.toJson(answers));

        assessmentDAO.save(result);

        // Redirect to results
        response.sendRedirect(request.getContextPath() + "/assessment/result?type=GAD7&score=" + score + 
                              "&severity=" + severity);
    }
}

