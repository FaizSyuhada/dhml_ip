package edu.university.dmhlh.model;

import java.sql.Timestamp;

/**
 * Care Plan entity (AI Coach output)
 */
public class CarePlan {
    private Integer id;
    private Integer userId;
    private String summary;
    private String riskLevel; // LOW, MODERATE, HIGH, SEVERE
    private Integer phq9Score;
    private Integer gad7Score;
    private String recommendationsJson;
    private Timestamp createdAt;

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public Integer getUserId() { return userId; }
    public void setUserId(Integer userId) { this.userId = userId; }
    
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    
    public String getRiskLevel() { return riskLevel; }
    public void setRiskLevel(String riskLevel) { this.riskLevel = riskLevel; }
    
    public Integer getPhq9Score() { return phq9Score; }
    public void setPhq9Score(Integer phq9Score) { this.phq9Score = phq9Score; }
    
    public Integer getGad7Score() { return gad7Score; }
    public void setGad7Score(Integer gad7Score) { this.gad7Score = gad7Score; }
    
    public String getRecommendationsJson() { return recommendationsJson; }
    public void setRecommendationsJson(String recommendationsJson) { this.recommendationsJson = recommendationsJson; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}

