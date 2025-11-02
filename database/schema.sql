-- Digital Mental Health Literacy Hub (DMHLH)
-- Database Schema for Supabase PostgreSQL

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS audit_log CASCADE;
DROP TABLE IF EXISTS integration_config CASCADE;
DROP TABLE IF EXISTS feedback CASCADE;
DROP TABLE IF EXISTS post_report CASCADE;
DROP TABLE IF EXISTS forum_post CASCADE;
DROP TABLE IF EXISTS booking CASCADE;
DROP TABLE IF EXISTS care_plan CASCADE;
DROP TABLE IF EXISTS habit_log CASCADE;
DROP TABLE IF EXISTS goal CASCADE;
DROP TABLE IF EXISTS mood_log CASCADE;
DROP TABLE IF EXISTS assessment_result CASCADE;
DROP TABLE IF EXISTS learning_progress CASCADE;
DROP TABLE IF EXISTS quiz_result CASCADE;
DROP TABLE IF EXISTS quiz_question CASCADE;
DROP TABLE IF EXISTS quiz CASCADE;
DROP TABLE IF EXISTS learning_module CASCADE;
DROP TABLE IF EXISTS faculty_referral CASCADE;
DROP TABLE IF EXISTS app_user CASCADE;

-- Users table
CREATE TABLE app_user (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('STUDENT', 'COUNSELLOR', 'FACULTY', 'ADMIN')),
    password_hash VARCHAR(255),
    auth_provider VARCHAR(50) DEFAULT 'SSO' CHECK (auth_provider IN ('SSO', 'GOOGLE')),
    consent_accepted_at TIMESTAMP,
    language_pref VARCHAR(10) DEFAULT 'en',
    accessibility_font_size VARCHAR(20) DEFAULT 'medium',
    accessibility_contrast VARCHAR(20) DEFAULT 'normal',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Learning Modules
CREATE TABLE learning_module (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    content_type VARCHAR(50) CHECK (content_type IN ('VIDEO', 'INFOGRAPHIC', 'TEXT', 'MIXED')),
    content_url TEXT,
    content_text TEXT,
    duration_minutes INTEGER,
    order_index INTEGER,
    is_published BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quizzes
CREATE TABLE quiz (
    id SERIAL PRIMARY KEY,
    module_id INTEGER REFERENCES learning_module(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    passing_score INTEGER DEFAULT 70,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Quiz Questions
CREATE TABLE quiz_question (
    id SERIAL PRIMARY KEY,
    quiz_id INTEGER REFERENCES quiz(id) ON DELETE CASCADE,
    question_text TEXT NOT NULL,
    option_a VARCHAR(500),
    option_b VARCHAR(500),
    option_c VARCHAR(500),
    option_d VARCHAR(500),
    correct_answer CHAR(1) CHECK (correct_answer IN ('A', 'B', 'C', 'D')),
    order_index INTEGER
);

-- Quiz Results
CREATE TABLE quiz_result (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    quiz_id INTEGER REFERENCES quiz(id) ON DELETE CASCADE,
    score INTEGER NOT NULL,
    total_questions INTEGER NOT NULL,
    passed BOOLEAN,
    taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Learning Progress
CREATE TABLE learning_progress (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    module_id INTEGER REFERENCES learning_module(id) ON DELETE CASCADE,
    completion_percentage INTEGER DEFAULT 0,
    last_viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP,
    UNIQUE(user_id, module_id)
);

-- Assessment Results (PHQ-9, GAD-7)
CREATE TABLE assessment_result (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    assessment_type VARCHAR(10) NOT NULL CHECK (assessment_type IN ('PHQ9', 'GAD7')),
    score INTEGER NOT NULL,
    severity VARCHAR(50),
    answers_json TEXT, -- Store individual answers as JSON
    taken_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Mood Log
CREATE TABLE mood_log (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 5),
    note TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Goals
CREATE TABLE goal (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    frequency VARCHAR(50) CHECK (frequency IN ('DAILY', 'WEEKLY', 'MONTHLY')),
    target_count INTEGER DEFAULT 1,
    start_date DATE,
    end_date DATE,
    status VARCHAR(50) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'COMPLETED', 'ABANDONED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Habit Log
CREATE TABLE habit_log (
    id SERIAL PRIMARY KEY,
    goal_id INTEGER REFERENCES goal(id) ON DELETE CASCADE,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    logged_date DATE NOT NULL,
    completed BOOLEAN DEFAULT TRUE,
    note TEXT,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(goal_id, logged_date)
);

-- Care Plan (AI Coach output)
CREATE TABLE care_plan (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    summary TEXT NOT NULL,
    risk_level VARCHAR(50) CHECK (risk_level IN ('LOW', 'MODERATE', 'HIGH', 'SEVERE')),
    phq9_score INTEGER,
    gad7_score INTEGER,
    recommendations_json TEXT, -- JSON array of recommendations
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Booking (Tele-counselling)
CREATE TABLE booking (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    counsellor_id INTEGER REFERENCES app_user(id) ON DELETE SET NULL,
    preferred_date DATE NOT NULL,
    preferred_time TIME NOT NULL,
    reason TEXT,
    status VARCHAR(50) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELLED')),
    counsellor_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Forum Posts
CREATE TABLE forum_post (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    pseudo_id VARCHAR(100) NOT NULL, -- Hashed/pseudonymous ID
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'HIDDEN', 'DELETED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Post Reports
CREATE TABLE post_report (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES forum_post(id) ON DELETE CASCADE,
    reporter_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    reason TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'REVIEWING', 'RESOLVED', 'DISMISSED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_by INTEGER REFERENCES app_user(id) ON DELETE SET NULL,
    resolved_at TIMESTAMP,
    resolution_notes TEXT
);

-- Faculty Referrals
CREATE TABLE faculty_referral (
    id SERIAL PRIMARY KEY,
    faculty_id INTEGER REFERENCES app_user(id) ON DELETE CASCADE,
    student_email VARCHAR(255) NOT NULL,
    student_name VARCHAR(255),
    concern_description TEXT NOT NULL,
    consent_confirmed BOOLEAN NOT NULL,
    status VARCHAR(50) DEFAULT 'SUBMITTED' CHECK (status IN ('SUBMITTED', 'UNDER_REVIEW', 'CONTACTED', 'CLOSED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    reviewed_by INTEGER REFERENCES app_user(id) ON DELETE SET NULL,
    reviewed_at TIMESTAMP
);

-- Feedback
CREATE TABLE feedback (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE SET NULL,
    message TEXT NOT NULL,
    rating INTEGER CHECK (rating BETWEEN 1 AND 5),
    page_context VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Integration Config (for future SSO/API settings)
CREATE TABLE integration_config (
    id SERIAL PRIMARY KEY,
    config_key VARCHAR(255) UNIQUE NOT NULL,
    config_value TEXT,
    description TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Audit Log
CREATE TABLE audit_log (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES app_user(id) ON DELETE SET NULL,
    action VARCHAR(100) NOT NULL,
    module VARCHAR(50),
    details TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_user_email ON app_user(email);
CREATE INDEX idx_user_role ON app_user(role);
CREATE INDEX idx_assessment_user ON assessment_result(user_id, taken_at DESC);
CREATE INDEX idx_mood_user ON mood_log(user_id, logged_at DESC);
CREATE INDEX idx_forum_status ON forum_post(status, created_at DESC);
CREATE INDEX idx_post_report_status ON post_report(status);
CREATE INDEX idx_booking_user ON booking(user_id);
CREATE INDEX idx_booking_counsellor ON booking(counsellor_id);
CREATE INDEX idx_audit_log_user ON audit_log(user_id, created_at DESC);

-- Insert default admin user (password: admin123)
INSERT INTO app_user (email, full_name, role, password_hash, consent_accepted_at, auth_provider) 
VALUES (
    'admin@university.edu', 
    'System Administrator', 
    'ADMIN', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', -- BCrypt hash of 'admin123'
    CURRENT_TIMESTAMP,
    'SSO'
);

-- Insert sample counsellor
INSERT INTO app_user (email, full_name, role, password_hash, consent_accepted_at, auth_provider) 
VALUES (
    'counsellor@university.edu', 
    'Dr. Sarah Johnson', 
    'COUNSELLOR', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', -- BCrypt hash of 'admin123'
    CURRENT_TIMESTAMP,
    'SSO'
);

-- Insert sample faculty
INSERT INTO app_user (email, full_name, role, password_hash, consent_accepted_at, auth_provider) 
VALUES (
    'faculty@university.edu', 
    'Prof. Michael Chen', 
    'FACULTY', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', -- BCrypt hash of 'admin123'
    CURRENT_TIMESTAMP,
    'SSO'
);

-- Insert sample student
INSERT INTO app_user (email, full_name, role, password_hash, consent_accepted_at, auth_provider) 
VALUES (
    'student@university.edu', 
    'Alex Thompson', 
    'STUDENT', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', -- BCrypt hash of 'admin123'
    NULL,
    'SSO'
);

-- Insert sample learning modules
INSERT INTO learning_module (title, description, content_type, content_text, duration_minutes, order_index) VALUES
('Understanding Mental Health', 'Learn the basics of mental health and wellness', 'TEXT', 
'Mental health includes our emotional, psychological, and social well-being. It affects how we think, feel, and act. It also helps determine how we handle stress, relate to others, and make choices.', 
15, 1),
('Recognizing Depression', 'Identify signs and symptoms of depression', 'VIDEO', 
'Depression is more than just feeling sad. It''s a serious mental health condition that requires understanding and medical care.', 
20, 2),
('Managing Anxiety', 'Practical strategies for anxiety management', 'MIXED', 
'Anxiety is a normal reaction to stress. Learn techniques like deep breathing, mindfulness, and cognitive restructuring.', 
25, 3);

-- Insert sample integration configs
INSERT INTO integration_config (config_key, config_value, description) VALUES
('sso.enabled', 'true', 'Enable/disable SSO authentication'),
('google.oauth.enabled', 'true', 'Enable/disable Google OAuth'),
('crisis.hotline.number', '1-800-273-8255', 'National Crisis Hotline'),
('max.login.attempts', '5', 'Maximum failed login attempts before lockout');

-- Insert sample quizzes
INSERT INTO quiz (module_id, title, description, passing_score) VALUES
(1, 'Mental Health Basics Quiz', 'Test your understanding of mental health fundamentals', 70),
(2, 'Depression Awareness Quiz', 'Assess your knowledge about depression', 70),
(3, 'Anxiety Management Quiz', 'Quiz on anxiety coping strategies', 70);

-- Insert quiz questions for Quiz 1 (Mental Health Basics)
INSERT INTO quiz_question (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer, order_index) VALUES
(1, 'What is mental health?', 'Only the absence of mental illness', 'Emotional, psychological, and social well-being', 'Being happy all the time', 'Never experiencing stress', 'B', 1),
(1, 'Mental health affects:', 'How we think', 'How we feel', 'How we act', 'All of the above', 'D', 2),
(1, 'Is it normal to experience mental health challenges?', 'No, it means weakness', 'Yes, it is common and treatable', 'Only for certain people', 'Mental health issues are rare', 'B', 3);

-- Insert quiz questions for Quiz 2 (Depression)
INSERT INTO quiz_question (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer, order_index) VALUES
(2, 'Depression is:', 'Just feeling sad occasionally', 'A serious mental health condition', 'Something people can snap out of', 'Only affects adults', 'B', 1),
(2, 'Common symptoms of depression include:', 'Persistent sadness', 'Loss of interest in activities', 'Changes in sleep or appetite', 'All of the above', 'D', 2),
(2, 'Depression is treatable through:', 'Therapy and/or medication', 'Ignoring it', 'Willpower alone', 'Avoiding people', 'A', 3);

-- Insert quiz questions for Quiz 3 (Anxiety)
INSERT INTO quiz_question (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_answer, order_index) VALUES
(3, 'What is anxiety?', 'Never feeling worried', 'A normal reaction to stress', 'A sign of weakness', 'Only happens to nervous people', 'B', 1),
(3, 'Effective anxiety management techniques include:', 'Deep breathing exercises', 'Mindfulness meditation', 'Regular physical activity', 'All of the above', 'D', 2),
(3, 'When should you seek help for anxiety?', 'When it interferes with daily life', 'Only when it is severe', 'Never, handle it alone', 'Only after many years', 'A', 3);

