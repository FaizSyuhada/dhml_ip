package edu.university.dmhlh.servlet;

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

/**
 * Servlet to display assessment results
 */
@WebServlet("/assessment/result")
public class AssessmentResultServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AssessmentResultServlet.class);

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
        String scoreStr = request.getParameter("score");
        String severity = request.getParameter("severity");

        if (type != null && scoreStr != null && severity != null) {
            try {
                Integer score = Integer.parseInt(scoreStr);
                
                request.setAttribute("type", type);
                request.setAttribute("score", score);
                request.setAttribute("severity", severity);
                
                // Check if high risk (needs booking prompt)
                boolean highRisk = ("PHQ9".equals(type) && score >= 15) || ("GAD7".equals(type) && score >= 15);
                request.setAttribute("highRisk", highRisk);
                
                request.getRequestDispatcher("/WEB-INF/views/assessment/result.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/assessment");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/assessment");
        }
    }
}

