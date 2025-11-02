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
 * Counsellor dashboard servlet
 */
@WebServlet("/counsellor/dashboard")
public class CounsellorDashboardServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(CounsellorDashboardServlet.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isCounsellor()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/counsellor/dashboard.jsp").forward(request, response);
    }
}

