package edu.university.dmhlh.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for password hashing and verification using BCrypt
 */
public class PasswordUtil {
    
    /**
     * Hash a plain text password
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    /**
     * Verify a plain text password against a hashed password
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Generate a pseudonymous ID for forum posts
     */
    public static String generatePseudoId(Integer userId) {
        // Simple hash - in production, use a better salted hash
        return "user_" + Integer.toHexString(userId.hashCode() + 12345);
    }
}

