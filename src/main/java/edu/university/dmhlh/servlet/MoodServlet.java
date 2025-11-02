package edu.university.dmhlh.servlet;

import edu.university.dmhlh.dao.MoodDAO;
import edu.university.dmhlh.model.MoodLog;
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
import java.util.List;

/**
 * Servlet to handle mood tracking
 */
@WebServlet("/mood")
public class MoodServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(MoodServlet.class);
    private MoodDAO moodDAO = new MoodDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get recent mood logs (last 14 days)
        List<MoodLog> recentLogs = moodDAO.getRecent(user.getId(), 14);
        
        // Calculate average of last 3 moods for nudge check
        Double avgLast3 = moodDAO.getAverageRating(user.getId(), 3);
        boolean showNudge = avgLast3 <= 2.0;

        request.setAttribute("recentLogs", recentLogs);
        request.setAttribute("showNudge", showNudge);
        
        request.getRequestDispatcher("/WEB-INF/views/mood/tracker.jsp").forward(request, response);
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

        String ratingStr = request.getParameter("rating");
        String note = request.getParameter("note");

        if (ratingStr == null) {
            response.sendRedirect(request.getContextPath() + "/mood");
            return;
        }

        try {
            Integer rating = Integer.parseInt(ratingStr);
            
            // Validate rating (1-5)
            if (rating < 1 || rating > 5) {
                request.setAttribute("error", "Invalid rating. Must be between 1 and 5.");
                doGet(request, response);
                return;
            }

            // Save mood log
            MoodLog moodLog = new MoodLog();
            moodLog.setUserId(user.getId());
            moodLog.setRating(rating);
            moodLog.setNote(note);

            moodDAO.save(moodLog);

            response.sendRedirect(request.getContextPath() + "/mood?success=true");
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/mood");
        }
    }
}

