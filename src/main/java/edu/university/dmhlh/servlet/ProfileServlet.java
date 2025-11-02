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
 * Servlet to handle user profile management
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ProfileServlet.class);
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
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

        // Get form parameters
        String fullName = request.getParameter("full_name");
        String language = request.getParameter("language");
        String fontSize = request.getParameter("font_size");
        String contrast = request.getParameter("contrast");

        // Validate
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Full name is required");
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Update user object
        user.setFullName(fullName.trim());
        user.setLanguagePref(language != null ? language : "en");
        user.setAccessibilityFontSize(fontSize != null ? fontSize : "medium");
        user.setAccessibilityContrast(contrast != null ? contrast : "normal");

        // Save to database
        boolean updated = userDAO.update(user);

        if (updated) {
            // Update session
            session.setAttribute("user", user);
            logger.info("Profile updated for user: " + user.getId());
            request.setAttribute("success", "Profile updated successfully");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }

        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }
}

