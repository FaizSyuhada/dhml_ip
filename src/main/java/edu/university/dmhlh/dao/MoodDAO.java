package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.MoodLog;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Mood Logs
 */
public class MoodDAO {
    private static final Logger logger = LoggerFactory.getLogger(MoodDAO.class);

    /**
     * Save mood log
     */
    public MoodLog save(MoodLog moodLog) {
        String sql = "INSERT INTO mood_log (user_id, rating, note) VALUES (?, ?, ?) RETURNING id, logged_at";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, moodLog.getUserId());
            stmt.setInt(2, moodLog.getRating());
            stmt.setString(3, moodLog.getNote());
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                moodLog.setId(rs.getInt("id"));
                moodLog.setLoggedAt(rs.getTimestamp("logged_at"));
                logger.info("Mood logged: user " + moodLog.getUserId() + ", rating " + moodLog.getRating());
                return moodLog;
            }
        } catch (SQLException e) {
            logger.error("Error saving mood log", e);
        }
        return null;
    }

    /**
     * Get recent mood logs for a user (last N days)
     */
    public List<MoodLog> getRecent(Integer userId, Integer days) {
        String sql = "SELECT * FROM mood_log WHERE user_id = ? AND logged_at >= NOW() - INTERVAL '" + days + " days' " +
                     "ORDER BY logged_at DESC";
        List<MoodLog> logs = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                logs.add(mapResultSetToMoodLog(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting recent mood logs", e);
        }
        return logs;
    }

    /**
     * Get last N mood entries
     */
    public List<MoodLog> getLastN(Integer userId, Integer count) {
        String sql = "SELECT * FROM mood_log WHERE user_id = ? ORDER BY logged_at DESC LIMIT ?";
        List<MoodLog> logs = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, count);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                logs.add(mapResultSetToMoodLog(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting last N mood logs", e);
        }
        return logs;
    }

    /**
     * Calculate average mood rating for last N entries
     */
    public Double getAverageRating(Integer userId, Integer count) {
        String sql = "SELECT AVG(rating) as avg_rating FROM (" +
                     "  SELECT rating FROM mood_log WHERE user_id = ? ORDER BY logged_at DESC LIMIT ?" +
                     ") AS recent_moods";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, count);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
        } catch (SQLException e) {
            logger.error("Error calculating average rating", e);
        }
        return 0.0;
    }

    /**
     * Map ResultSet to MoodLog
     */
    private MoodLog mapResultSetToMoodLog(ResultSet rs) throws SQLException {
        MoodLog log = new MoodLog();
        log.setId(rs.getInt("id"));
        log.setUserId(rs.getInt("user_id"));
        log.setRating(rs.getInt("rating"));
        log.setNote(rs.getString("note"));
        log.setLoggedAt(rs.getTimestamp("logged_at"));
        return log;
    }
}

