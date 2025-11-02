package edu.university.dmhlh.util;

/**
 * Utility class for assessment calculations
 */
public class AssessmentUtil {
    
    /**
     * Calculate PHQ-9 severity based on score
     * Minimal: 0-4
     * Mild: 5-9
     * Moderate: 10-14
     * Moderately Severe: 15-19
     * Severe: 20-27
     */
    public static String calculatePHQ9Severity(int score) {
        if (score <= 4) {
            return "Minimal";
        } else if (score <= 9) {
            return "Mild";
        } else if (score <= 14) {
            return "Moderate";
        } else if (score <= 19) {
            return "Moderately Severe";
        } else {
            return "Severe";
        }
    }

    /**
     * Calculate GAD-7 severity based on score
     * Minimal: 0-4
     * Mild: 5-9
     * Moderate: 10-14
     * Severe: 15-21
     */
    public static String calculateGAD7Severity(int score) {
        if (score <= 4) {
            return "Minimal";
        } else if (score <= 9) {
            return "Mild";
        } else if (score <= 14) {
            return "Moderate";
        } else {
            return "Severe";
        }
    }

    /**
     * Determine risk level based on PHQ-9 and/or GAD-7 scores
     * Used for AI Coach care plan generation
     */
    public static String calculateRiskLevel(Integer phq9Score, Integer gad7Score) {
        int highestScore = 0;
        
        if (phq9Score != null) {
            highestScore = Math.max(highestScore, phq9Score);
        }
        if (gad7Score != null) {
            highestScore = Math.max(highestScore, gad7Score);
        }

        if (highestScore >= 20) {
            return "SEVERE";
        } else if (highestScore >= 15) {
            return "HIGH";
        } else if (highestScore >= 10) {
            return "MODERATE";
        } else {
            return "LOW";
        }
    }

    /**
     * Check if score warrants immediate counselling booking prompt
     */
    public static boolean requiresBookingPrompt(Integer phq9Score, Integer gad7Score) {
        if (phq9Score != null && phq9Score >= 15) {
            return true;
        }
        if (gad7Score != null && gad7Score >= 15) {
            return true;
        }
        return false;
    }
}

