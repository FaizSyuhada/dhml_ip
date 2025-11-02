package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.LearningModule;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Learning Modules
 */
public class LearningModuleDAO {
    private static final Logger logger = LoggerFactory.getLogger(LearningModuleDAO.class);

    /**
     * Get all published modules
     */
    public List<LearningModule> findAllPublished() {
        String sql = "SELECT * FROM learning_module WHERE is_published = true ORDER BY order_index";
        List<LearningModule> modules = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                modules.add(mapResultSetToModule(rs));
            }
        } catch (SQLException e) {
            logger.error("Error finding published modules", e);
        }
        return modules;
    }

    /**
     * Find module by ID
     */
    public LearningModule findById(Integer id) {
        String sql = "SELECT * FROM learning_module WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToModule(rs);
            }
        } catch (SQLException e) {
            logger.error("Error finding module by ID: " + id, e);
        }
        return null;
    }

    /**
     * Record or update learning progress
     */
    public boolean recordProgress(Integer userId, Integer moduleId, Integer completionPercentage) {
        String sql = "INSERT INTO learning_progress (user_id, module_id, completion_percentage, last_viewed_at) " +
                     "VALUES (?, ?, ?, CURRENT_TIMESTAMP) " +
                     "ON CONFLICT (user_id, module_id) " +
                     "DO UPDATE SET completion_percentage = ?, last_viewed_at = CURRENT_TIMESTAMP";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, moduleId);
            stmt.setInt(3, completionPercentage);
            stmt.setInt(4, completionPercentage);
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            logger.error("Error recording progress", e);
        }
        return false;
    }

    /**
     * Get user's progress for a module
     */
    public Integer getProgress(Integer userId, Integer moduleId) {
        String sql = "SELECT completion_percentage FROM learning_progress WHERE user_id = ? AND module_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, moduleId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("completion_percentage");
            }
        } catch (SQLException e) {
            logger.error("Error getting progress", e);
        }
        return 0;
    }

    /**
     * Map ResultSet to LearningModule
     */
    private LearningModule mapResultSetToModule(ResultSet rs) throws SQLException {
        LearningModule module = new LearningModule();
        module.setId(rs.getInt("id"));
        module.setTitle(rs.getString("title"));
        module.setDescription(rs.getString("description"));
        module.setContentType(rs.getString("content_type"));
        module.setContentUrl(rs.getString("content_url"));
        module.setContentText(rs.getString("content_text"));
        module.setDurationMinutes(rs.getInt("duration_minutes"));
        module.setOrderIndex(rs.getInt("order_index"));
        module.setPublished(rs.getBoolean("is_published"));
        module.setCreatedAt(rs.getTimestamp("created_at"));
        return module;
    }
}

