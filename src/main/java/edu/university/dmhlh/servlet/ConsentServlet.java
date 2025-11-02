package edu.university.dmhlh.servlet;

import edu.university.dmhlh.dao.UserDAO;
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
 * Servlet to handle user consent
 */
@WebServlet("/consent")
public class ConsentServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ConsentServlet.class);
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/consent.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String consentAccepted = request.getParameter("consent_accepted");
        
        if ("true".equals(consentAccepted)) {
            // Update consent in database
            boolean updated = userDAO.updateConsent(user.getId());
            
            if (updated) {
                // Reload user to get updated consent timestamp
                user = userDAO.findById(user.getId());
                session.setAttribute("user", user);
                
                logger.info("Consent accepted by user: " + user.getId());
                
                // Redirect to dashboard
                if (user.isStudent()) {
                    response.sendRedirect(request.getContextPath() + "/student/dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/login");
                }
            } else {
                request.setAttribute("error", "Failed to save consent. Please try again.");
                request.getRequestDispatcher("/WEB-INF/views/consent.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "You must accept the consent to continue.");
            request.getRequestDispatcher("/WEB-INF/views/consent.jsp").forward(request, response);
        }
    }
}

