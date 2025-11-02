package edu.university.dmhlh.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet to display the login page
 */
@WebServlet("/login")
public class LoginPageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // If user is already logged in, redirect to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            String role = (String) session.getAttribute("userRole");
            redirectByRole(role, request, response);
            return;
        }
        
        // Show login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    /**
     * Redirect user based on their role
     */
    private void redirectByRole(String role, HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String contextPath = request.getContextPath();
        
        switch (role) {
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

