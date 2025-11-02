package edu.university.dmhlh.servlet;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet("/faculty/referral")
public class FacultyReferralServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isFaculty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/faculty/referral.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isFaculty()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String studentEmail = request.getParameter("student_email");
        String studentName = request.getParameter("student_name");
        String concern = request.getParameter("concern");
        boolean consentConfirmed = "on".equals(request.getParameter("consent_confirmed"));

        if (!consentConfirmed) {
            response.sendRedirect(request.getContextPath() + "/faculty/referral?error=consent");
            return;
        }

        String sql = "INSERT INTO faculty_referral (faculty_id, student_email, student_name, concern_description, consent_confirmed) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getId());
            stmt.setString(2, studentEmail);
            stmt.setString(3, studentName);
            stmt.setString(4, concern);
            stmt.setBoolean(5, true);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/faculty/referral?success=true");
    }
}

