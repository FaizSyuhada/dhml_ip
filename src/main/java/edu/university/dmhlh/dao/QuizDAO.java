package edu.university.dmhlh.dao;

import edu.university.dmhlh.config.DatabaseConfig;
import edu.university.dmhlh.model.Quiz;
import edu.university.dmhlh.model.QuizQuestion;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Quizzes
 */
public class QuizDAO {
    private static final Logger logger = LoggerFactory.getLogger(QuizDAO.class);

    /**
     * Find quiz by ID with questions
     */
    public Quiz findById(Integer id) {
        String sql = "SELECT * FROM quiz WHERE id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Quiz quiz = mapResultSetToQuiz(rs);
                quiz.setQuestions(findQuestionsByQuizId(id));
                return quiz;
            }
        } catch (SQLException e) {
            logger.error("Error finding quiz by ID: " + id, e);
        }
        return null;
    }

    /**
     * Find quiz by module ID
     */
    public Quiz findByModuleId(Integer moduleId) {
        String sql = "SELECT * FROM quiz WHERE module_id = ? LIMIT 1";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, moduleId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                Quiz quiz = mapResultSetToQuiz(rs);
                quiz.setQuestions(findQuestionsByQuizId(quiz.getId()));
                return quiz;
            }
        } catch (SQLException e) {
            logger.error("Error finding quiz by module ID: " + moduleId, e);
        }
        return null;
    }

    /**
     * Find questions for a quiz
     */
    public List<QuizQuestion> findQuestionsByQuizId(Integer quizId) {
        String sql = "SELECT * FROM quiz_question WHERE quiz_id = ? ORDER BY order_index";
        List<QuizQuestion> questions = new ArrayList<>();
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quizId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                questions.add(mapResultSetToQuestion(rs));
            }
        } catch (SQLException e) {
            logger.error("Error finding questions for quiz: " + quizId, e);
        }
        return questions;
    }

    /**
     * Save quiz result
     */
    public boolean saveResult(Integer userId, Integer quizId, Integer score, Integer totalQuestions) {
        String sql = "INSERT INTO quiz_result (user_id, quiz_id, score, total_questions, passed) " +
                     "VALUES (?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Calculate if passed (70% or higher)
            boolean passed = (score * 100 / totalQuestions) >= 70;
            
            stmt.setInt(1, userId);
            stmt.setInt(2, quizId);
            stmt.setInt(3, score);
            stmt.setInt(4, totalQuestions);
            stmt.setBoolean(5, passed);
            
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            logger.error("Error saving quiz result", e);
        }
        return false;
    }

    /**
     * Get user's best score for a quiz
     */
    public Integer getBestScore(Integer userId, Integer quizId) {
        String sql = "SELECT MAX(score) as best_score FROM quiz_result WHERE user_id = ? AND quiz_id = ?";
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, quizId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("best_score");
            }
        } catch (SQLException e) {
            logger.error("Error getting best score", e);
        }
        return 0;
    }

    /**
     * Map ResultSet to Quiz
     */
    private Quiz mapResultSetToQuiz(ResultSet rs) throws SQLException {
        Quiz quiz = new Quiz();
        quiz.setId(rs.getInt("id"));
        quiz.setModuleId(rs.getInt("module_id"));
        quiz.setTitle(rs.getString("title"));
        quiz.setDescription(rs.getString("description"));
        quiz.setPassingScore(rs.getInt("passing_score"));
        quiz.setCreatedAt(rs.getTimestamp("created_at"));
        return quiz;
    }

    /**
     * Map ResultSet to QuizQuestion
     */
    private QuizQuestion mapResultSetToQuestion(ResultSet rs) throws SQLException {
        QuizQuestion question = new QuizQuestion();
        question.setId(rs.getInt("id"));
        question.setQuizId(rs.getInt("quiz_id"));
        question.setQuestionText(rs.getString("question_text"));
        question.setOptionA(rs.getString("option_a"));
        question.setOptionB(rs.getString("option_b"));
        question.setOptionC(rs.getString("option_c"));
        question.setOptionD(rs.getString("option_d"));
        question.setCorrectAnswer(rs.getString("correct_answer"));
        question.setOrderIndex(rs.getInt("order_index"));
        return question;
    }
}

