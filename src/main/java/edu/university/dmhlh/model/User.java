package edu.university.dmhlh.model;

import java.sql.Timestamp;

/**
 * User entity representing app_user table
 */
public class User {
    private Integer id;
    private String email;
    private String fullName;
    private String role; // STUDENT, COUNSELLOR, FACULTY, ADMIN
    private String passwordHash;
    private String authProvider; // SSO, GOOGLE
    private Timestamp consentAcceptedAt;
    private String languagePref;
    private String accessibilityFontSize;
    private String accessibilityContrast;
    private boolean isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructors
    public User() {
    }

    public User(Integer id, String email, String fullName, String role) {
        this.id = id;
        this.email = email;
        this.fullName = fullName;
        this.role = role;
    }

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getAuthProvider() {
        return authProvider;
    }

    public void setAuthProvider(String authProvider) {
        this.authProvider = authProvider;
    }

    public Timestamp getConsentAcceptedAt() {
        return consentAcceptedAt;
    }

    public void setConsentAcceptedAt(Timestamp consentAcceptedAt) {
        this.consentAcceptedAt = consentAcceptedAt;
    }

    public String getLanguagePref() {
        return languagePref;
    }

    public void setLanguagePref(String languagePref) {
        this.languagePref = languagePref;
    }

    public String getAccessibilityFontSize() {
        return accessibilityFontSize;
    }

    public void setAccessibilityFontSize(String accessibilityFontSize) {
        this.accessibilityFontSize = accessibilityFontSize;
    }

    public String getAccessibilityContrast() {
        return accessibilityContrast;
    }

    public void setAccessibilityContrast(String accessibilityContrast) {
        this.accessibilityContrast = accessibilityContrast;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean hasConsented() {
        return consentAcceptedAt != null;
    }

    public boolean isStudent() {
        return "STUDENT".equals(role);
    }

    public boolean isCounsellor() {
        return "COUNSELLOR".equals(role);
    }

    public boolean isFaculty() {
        return "FACULTY".equals(role);
    }

    public boolean isAdmin() {
        return "ADMIN".equals(role);
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", fullName='" + fullName + '\'' +
                ", role='" + role + '\'' +
                '}';
    }
}

