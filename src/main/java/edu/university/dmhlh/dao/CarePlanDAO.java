package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.CarePlan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.sql.*;

public class CarePlanDAO {
    private static final Logger logger = LoggerFactory.getLogger(CarePlanDAO.class);

    public CarePlan save(CarePlan carePlan) {
        String sql = "INSERT INTO care_plan (user_id, summary, risk_level, phq9_score, gad7_score, recommendations_json) " +
                     "VALUES (?, ?, ?, ?, ?, ?) RETURNING id, created_at";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, carePlan.getUserId());
            stmt.setString(2, carePlan.getSummary());
            stmt.setString(3, carePlan.getRiskLevel());
            stmt.setObject(4, carePlan.getPhq9Score());
            stmt.setObject(5, carePlan.getGad7Score());
            stmt.setString(6, carePlan.getRecommendationsJson());
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                carePlan.setId(rs.getInt("id"));
                carePlan.setCreatedAt(rs.getTimestamp("created_at"));
                return carePlan;
            }
        } catch (SQLException e) {
            logger.error("Error saving care plan", e);
        }
        return null;
    }

    public CarePlan getLatest(Integer userId) {
        String sql = "SELECT * FROM care_plan WHERE user_id = ? ORDER BY created_at DESC LIMIT 1";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CarePlan cp = new CarePlan();
                cp.setId(rs.getInt("id"));
                cp.setUserId(rs.getInt("user_id"));
                cp.setSummary(rs.getString("summary"));
                cp.setRiskLevel(rs.getString("risk_level"));
                cp.setPhq9Score((Integer) rs.getObject("phq9_score"));
                cp.setGad7Score((Integer) rs.getObject("gad7_score"));
                cp.setRecommendationsJson(rs.getString("recommendations_json"));
                cp.setCreatedAt(rs.getTimestamp("created_at"));
                return cp;
            }
        } catch (SQLException e) {
            logger.error("Error getting latest care plan", e);
        }
        return null;
    }
}

