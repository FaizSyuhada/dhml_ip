package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.ForumPost;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ForumDAO {
    private static final Logger logger = LoggerFactory.getLogger(ForumDAO.class);

    public ForumPost save(ForumPost post) {
        String sql = "INSERT INTO forum_post (user_id, pseudo_id, title, content, status) " +
                     "VALUES (?, ?, ?, ?, 'ACTIVE') RETURNING id, created_at";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, post.getUserId());
            stmt.setString(2, post.getPseudoId());
            stmt.setString(3, post.getTitle());
            stmt.setString(4, post.getContent());
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                post.setId(rs.getInt("id"));
                post.setCreatedAt(rs.getTimestamp("created_at"));
                return post;
            }
        } catch (SQLException e) {
            logger.error("Error saving forum post", e);
        }
        return null;
    }

    public List<ForumPost> getActivePosts() {
        String sql = "SELECT * FROM forum_post WHERE status = 'ACTIVE' ORDER BY created_at DESC LIMIT 50";
        List<ForumPost> posts = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                posts.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting active posts", e);
        }
        return posts;
    }

    private ForumPost mapResultSet(ResultSet rs) throws SQLException {
        ForumPost p = new ForumPost();
        p.setId(rs.getInt("id"));
        p.setUserId(rs.getInt("user_id"));
        p.setPseudoId(rs.getString("pseudo_id"));
        p.setTitle(rs.getString("title"));
        p.setContent(rs.getString("content"));
        p.setStatus(rs.getString("status"));
        p.setCreatedAt(rs.getTimestamp("created_at"));
        return p;
    }
}

