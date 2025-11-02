package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for User operations
 */
public class UserDAO {
    private static final Logger logger = LoggerFactory.getLogger(UserDAO.class);

    /**
     * Find user by email
     */
    public User findByEmail(String email) {
        String sql = "SELECT * FROM app_user WHERE email = ? AND is_active = true";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            logger.error("Error finding user by email: " + email, e);
        }
        return null;
    }

    /**
     * Find user by ID
     */
    public User findById(Integer id) {
        String sql = "SELECT * FROM app_user WHERE id = ? AND is_active = true";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToUser(rs);
            }
        } catch (SQLException e) {
            logger.error("Error finding user by ID: " + id, e);
        }
        return null;
    }

    /**
     * Create a new user
     */
    public User create(User user) {
        String sql = "INSERT INTO app_user (email, full_name, role, password_hash, auth_provider, " +
                     "language_pref, accessibility_font_size, accessibility_contrast) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?) RETURNING id";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getRole());
            stmt.setString(4, user.getPasswordHash());
            stmt.setString(5, user.getAuthProvider());
            stmt.setString(6, user.getLanguagePref() != null ? user.getLanguagePref() : "en");
            stmt.setString(7, user.getAccessibilityFontSize() != null ? user.getAccessibilityFontSize() : "medium");
            stmt.setString(8, user.getAccessibilityContrast() != null ? user.getAccessibilityContrast() : "normal");
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                user.setId(rs.getInt("id"));
                logger.info("Created new user: " + user.getEmail());
                return user;
            }
        } catch (SQLException e) {
            logger.error("Error creating user: " + user.getEmail(), e);
        }
        return null;
    }

    /**
     * Update user consent timestamp
     */
    public boolean updateConsent(Integer userId) {
        String sql = "UPDATE app_user SET consent_accepted_at = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            logger.error("Error updating consent for user ID: " + userId, e);
        }
        return false;
    }

    /**
     * Update user profile
     */
    public boolean update(User user) {
        String sql = "UPDATE app_user SET full_name = ?, language_pref = ?, " +
                     "accessibility_font_size = ?, accessibility_contrast = ?, updated_at = CURRENT_TIMESTAMP " +
                     "WHERE id = ?";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getLanguagePref());
            stmt.setString(3, user.getAccessibilityFontSize());
            stmt.setString(4, user.getAccessibilityContrast());
            stmt.setInt(5, user.getId());
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            logger.error("Error updating user: " + user.getId(), e);
        }
        return false;
    }

    /**
     * Deactivate user account
     */
    public boolean deactivate(Integer userId) {
        String sql = "UPDATE app_user SET is_active = false, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            logger.error("Error deactivating user ID: " + userId, e);
        }
        return false;
    }

    /**
     * Get all users by role
     */
    public List<User> findByRole(String role) {
        String sql = "SELECT * FROM app_user WHERE role = ? AND is_active = true ORDER BY full_name";
        List<User> users = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                users.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            logger.error("Error finding users by role: " + role, e);
        }
        return users;
    }

    /**
     * Count users by role
     */
    public int countByRole(String role) {
        String sql = "SELECT COUNT(*) FROM app_user WHERE role = ? AND is_active = true";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, role);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            logger.error("Error counting users by role: " + role, e);
        }
        return 0;
    }

    /**
     * Map ResultSet to User object
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setEmail(rs.getString("email"));
        user.setFullName(rs.getString("full_name"));
        user.setRole(rs.getString("role"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setAuthProvider(rs.getString("auth_provider"));
        user.setConsentAcceptedAt(rs.getTimestamp("consent_accepted_at"));
        user.setLanguagePref(rs.getString("language_pref"));
        user.setAccessibilityFontSize(rs.getString("accessibility_font_size"));
        user.setAccessibilityContrast(rs.getString("accessibility_contrast"));
        user.setActive(rs.getBoolean("is_active"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }
}

