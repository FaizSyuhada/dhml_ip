package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.AssessmentResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Assessment Results
 */
public class AssessmentDAO {
    private static final Logger logger = LoggerFactory.getLogger(AssessmentDAO.class);

    /**
     * Save assessment result
     */
    public AssessmentResult save(AssessmentResult result) {
        String sql = "INSERT INTO assessment_result (user_id, assessment_type, score, severity, answers_json) " +
                     "VALUES (?, ?, ?, ?, ?) RETURNING id, taken_at";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, result.getUserId());
            stmt.setString(2, result.getAssessmentType());
            stmt.setInt(3, result.getScore());
            stmt.setString(4, result.getSeverity());
            stmt.setString(5, result.getAnswersJson());
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                result.setId(rs.getInt("id"));
                result.setTakenAt(rs.getTimestamp("taken_at"));
                logger.info("Assessment saved: user " + result.getUserId() + ", type " + result.getAssessmentType());
                return result;
            }
        } catch (SQLException e) {
            logger.error("Error saving assessment", e);
        }
        return null;
    }

    /**
     * Get latest assessment by type for a user
     */
    public AssessmentResult getLatest(Integer userId, String type) {
        String sql = "SELECT * FROM assessment_result WHERE user_id = ? AND assessment_type = ? " +
                     "ORDER BY taken_at DESC LIMIT 1";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, type);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToAssessment(rs);
            }
        } catch (SQLException e) {
            logger.error("Error getting latest assessment", e);
        }
        return null;
    }

    /**
     * Get assessment history for a user
     */
    public List<AssessmentResult> getHistory(Integer userId, String type) {
        String sql = "SELECT * FROM assessment_result WHERE user_id = ? AND assessment_type = ? " +
                     "ORDER BY taken_at DESC LIMIT 10";
        List<AssessmentResult> results = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setString(2, type);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                results.add(mapResultSetToAssessment(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting assessment history", e);
        }
        return results;
    }

    /**
     * Get average score for assessment type (for analytics)
     */
    public Double getAverageScore(String type) {
        String sql = "SELECT AVG(score) as avg_score FROM assessment_result WHERE assessment_type = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, type);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("avg_score");
            }
        } catch (SQLException e) {
            logger.error("Error getting average score", e);
        }
        return 0.0;
    }

    /**
     * Map ResultSet to AssessmentResult
     */
    private AssessmentResult mapResultSetToAssessment(ResultSet rs) throws SQLException {
        AssessmentResult result = new AssessmentResult();
        result.setId(rs.getInt("id"));
        result.setUserId(rs.getInt("user_id"));
        result.setAssessmentType(rs.getString("assessment_type"));
        result.setScore(rs.getInt("score"));
        result.setSeverity(rs.getString("severity"));
        result.setAnswersJson(rs.getString("answers_json"));
        result.setTakenAt(rs.getTimestamp("taken_at"));
        return result;
    }
}

