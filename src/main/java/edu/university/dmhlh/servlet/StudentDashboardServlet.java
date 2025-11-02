package edu.university.dmhlh.servlet;

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
 * Student dashboard servlet
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(StudentDashboardServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isStudent()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // In a full implementation, we would load dashboard data here:
        // - Recent mood logs
        // - Latest assessment results
        // - Active goals
        // - Learning progress
        // - Upcoming bookings

        request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
    }
}

