package edu.university.dmhlh.model;

import java.sql.Timestamp;

public class ForumPost {
    private Integer id;
    private Integer userId;
    private String pseudoId;
    private String title;
    private String content;
    private String status; // ACTIVE, HIDDEN, DELETED
    private Timestamp createdAt;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    public String getPseudoId() { return pseudoId; }
    public void setPseudoId(String pseudoId) { this.pseudoId = pseudoId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

