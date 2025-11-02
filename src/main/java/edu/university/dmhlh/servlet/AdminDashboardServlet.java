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
 * Admin dashboard servlet
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AdminDashboardServlet.class);
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isAdmin()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Load basic stats for admin dashboard
        int studentCount = userDAO.countByRole("STUDENT");
        int counsellorCount = userDAO.countByRole("COUNSELLOR");
        int facultyCount = userDAO.countByRole("FACULTY");
        
        request.setAttribute("studentCount", studentCount);
        request.setAttribute("counsellorCount", counsellorCount);
        request.setAttribute("facultyCount", facultyCount);

        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}

