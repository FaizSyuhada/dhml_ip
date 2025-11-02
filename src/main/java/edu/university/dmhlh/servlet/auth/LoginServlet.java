package edu.university.dmhlh.servlet.auth;

import edu.university.dmhlh.dao.UserDAO;
import edu.university.dmhlh.model.User;
import edu.university.dmhlh.util.PasswordUtil;
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
 * Servlet for SSO login (dummy implementation)
 */
@WebServlet("/auth/login")
public class LoginServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(LoginServlet.class);
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the login page
        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Convert Student/Staff ID to email if needed
        String emailToSearch = mapIdToEmail(email.trim());
        logger.info("Login attempt for user");
        
        // Find user
        User user = userDAO.findByEmail(emailToSearch);
        
        // Generic error message to prevent user enumeration
        String genericError = "Invalid email or password";
        
        if (user == null) {
            logger.warn("Failed login attempt - user not found");
            request.setAttribute("error", genericError);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Verify password
        if (user.getPasswordHash() == null) {
            logger.error("User account has no password set");
            request.setAttribute("error", genericError);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        boolean passwordMatches = PasswordUtil.verifyPassword(password, user.getPasswordHash());
        
        if (!passwordMatches) {
            logger.warn("Failed login attempt - invalid password");
            request.setAttribute("error", genericError);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Successful login - create session
        HttpSession session = request.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userRole", user.getRole());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes

        logger.info("User logged in: " + email + " (Role: " + user.getRole() + ")");

        // Redirect based on consent status and role
        if (!user.hasConsented() && user.isStudent()) {
            response.sendRedirect(request.getContextPath() + "/consent");
        } else {
            redirectByRole(user, request, response);
        }
    }

    /**
     * Map student/staff ID to email address
     * If input is already an email, return as-is
     */
    private String mapIdToEmail(String input) {
        // If it's already an email, return it
        if (input.contains("@")) {
            return input;
        }
        
        // Map student/staff IDs to emails
        switch (input.toUpperCase()) {
            case "ST2024001":
            case "STUDENT":
                return "student@university.edu";
            case "FAC001":
            case "FACULTY":
                return "faculty@university.edu";
            case "COUNS001":
            case "COUNSELLOR":
                return "counsellor@university.edu";
            case "ADMIN001":
            case "ADMIN":
                return "admin@university.edu";
            default:
                // If no mapping found, return original (might be email anyway)
                return input;
        }
    }

    /**
     * Redirect user based on their role
     */
    private void redirectByRole(User user, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String contextPath = request.getContextPath();
        
        switch (user.getRole()) {
            case "STUDENT":
                response.sendRedirect(contextPath + "/student/dashboard");
                break;
            case "COUNSELLOR":
                response.sendRedirect(contextPath + "/counsellor/dashboard");
                break;
            case "FACULTY":
                response.sendRedirect(contextPath + "/faculty/dashboard");
                break;
            case "ADMIN":
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/login");
                break;
        }
    }
}

