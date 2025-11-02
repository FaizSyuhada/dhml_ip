package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.Booking;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {
    private static final Logger logger = LoggerFactory.getLogger(BookingDAO.class);

    public Booking save(Booking booking) {
        String sql = "INSERT INTO booking (user_id, preferred_date, preferred_time, reason, status) " +
                     "VALUES (?, ?, ?, ?, ?) RETURNING id, created_at";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, booking.getUserId());
            stmt.setDate(2, booking.getPreferredDate());
            stmt.setTime(3, booking.getPreferredTime());
            stmt.setString(4, booking.getReason());
            stmt.setString(5, "PENDING");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                booking.setId(rs.getInt("id"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                return booking;
            }
        } catch (SQLException e) {
            logger.error("Error saving booking", e);
        }
        return null;
    }

    public List<Booking> getAllPending() {
        String sql = "SELECT * FROM booking WHERE status = 'PENDING' ORDER BY preferred_date, preferred_time";
        List<Booking> bookings = new ArrayList<>();
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                bookings.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            logger.error("Error getting pending bookings", e);
        }
        return bookings;
    }

    public boolean updateNotes(Integer bookingId, String notes) {
        String sql = "UPDATE booking SET counsellor_notes = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, notes);
            stmt.setInt(2, bookingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            logger.error("Error updating notes", e);
        }
        return false;
    }

    private Booking mapResultSet(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setPreferredDate(rs.getDate("preferred_date"));
        b.setPreferredTime(rs.getTime("preferred_time"));
        b.setReason(rs.getString("reason"));
        b.setStatus(rs.getString("status"));
        b.setCounsellorNotes(rs.getString("counsellor_notes"));
        b.setCreatedAt(rs.getTimestamp("created_at"));
        return b;
    }
}

