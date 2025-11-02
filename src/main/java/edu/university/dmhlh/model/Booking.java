package edu.university.dmhlh.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Booking {
    private Integer id;
    private Integer userId;
    private Integer counsellorId;
    private Date preferredDate;
    private Time preferredTime;
    private String reason;
    private String status; // PENDING, CONFIRMED, COMPLETED, CANCELLED
    private String counsellorNotes;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public Integer getCounsellorId() { return counsellorId; }
    public void setCounsellorId(Integer counsellorId) { this.counsellorId = counsellorId; }
    public Date getPreferredDate() { return preferredDate; }
    public void setPreferredDate(Date preferredDate) { this.preferredDate = preferredDate; }
    public Time getPreferredTime() { return preferredTime; }
    public void setPreferredTime(Time preferredTime) { this.preferredTime = preferredTime; }
    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getCounsellorNotes() { return counsellorNotes; }
    public void setCounsellorNotes(String counsellorNotes) { this.counsellorNotes = counsellorNotes; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public Timestamp getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(Timestamp updatedAt) { this.updatedAt = updatedAt; }
}

