package edu.university.dmhlh.servlet.auth;

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
 * Mock Google OAuth login - auto-provisions student accounts
 */
@WebServlet("/auth/google")
public class GoogleMockServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(GoogleMockServlet.class);
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Show Google login page
        request.getRequestDispatcher("/google-login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("google_email");
        String fullName = request.getParameter("google_name");

        // Validate input
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Email is required for Google login");
            request.getRequestDispatcher("/google-login.jsp").forward(request, response);
            return;
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            fullName = email.split("@")[0]; // Use email prefix as name if not provided
        }

        // Check if user exists
        User user = userDAO.findByEmail(email.trim());
        
        if (user == null) {
            // Auto-provision new student account
            user = new User();
            user.setEmail(email.trim());
            user.setFullName(fullName.trim());
            user.setRole("STUDENT");
            user.setAuthProvider("GOOGLE");
            user.setPasswordHash(null); // No password for Google auth
            
            user = userDAO.create(user);
            
            if (user == null) {
                request.setAttribute("error", "Failed to create account");
                request.getRequestDispatcher("/google-login.jsp").forward(request, response);
                return;
            }
            
            logger.info("Auto-provisioned Google user: " + email);
        } else {
            logger.info("Existing Google user logged in: " + email);
        }

        // Create session
        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes

        // Always redirect to consent for new Google users (students)
        if (!user.hasConsented() && user.isStudent()) {
            response.sendRedirect(request.getContextPath() + "/consent");
        } else {
            response.sendRedirect(request.getContextPath() + "/student/dashboard");
        }
    }
}

