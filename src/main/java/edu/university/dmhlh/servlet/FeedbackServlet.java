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

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/feedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        String message = request.getParameter("message");
        String ratingStr = request.getParameter("rating");
        Integer rating = ratingStr != null ? Integer.parseInt(ratingStr) : null;

        String sql = "INSERT INTO feedback (user_id, message, rating) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setObject(1, user != null ? user.getId() : null);
            stmt.setString(2, message);
            stmt.setObject(3, rating);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/feedback?success=true");
    }
}

