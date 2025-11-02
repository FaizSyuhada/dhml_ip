-- Verify and update users for DMHLH
-- Run this in Supabase SQL Editor to check/update users

-- Check if users exist
SELECT 
    id,
    email, 
    full_name, 
    role, 
    auth_provider,
    is_active,
    created_at
FROM app_user 
ORDER BY role, email;

-- Update existing users or insert if they don't exist
-- Password hash is BCrypt of 'admin123'

-- Admin user
INSERT INTO app_user (email, full_name, role, password_hash, consent_accepted_at, auth_provider, is_active) 
VALUES (
    'admin@university.edu', 
    'System Administrator', 
    'ADMIN', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    CURRENT_TIMESTAMP,
    'SSO',
    TRUE
)
ON CONFLICT (email) 
DO UPDATE SET
    full_name = EXCLUDED.full_name,
    password_hash = EXCLUDED.password_hash,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- Counsellor user
INSERT INTO app_user (email, full_name, role, password_hash, consent_accepted_at, auth_provider, is_active) 
VALUES (
    'counsellor@university.edu', 
    'Dr. Sarah Johnson', 
    'COUNSELLOR', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    CURRENT_TIMESTAMP,
    'SSO',
    TRUE
)
ON CONFLICT (email) 
DO UPDATE SET
    full_name = EXCLUDED.full_name,
    password_hash = EXCLUDED.password_hash,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- Faculty user
INSERT INTO app_user (email, full_name, role, password_hash, consent_accepted_at, auth_provider, is_active) 
VALUES (
    'faculty@university.edu', 
    'Prof. Michael Chen', 
    'FACULTY', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    CURRENT_TIMESTAMP,
    'SSO',
    TRUE
)
ON CONFLICT (email) 
DO UPDATE SET
    full_name = EXCLUDED.full_name,
    password_hash = EXCLUDED.password_hash,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- Student user
INSERT INTO app_user (email, full_name, role, password_hash, auth_provider, is_active) 
VALUES (
    'student@university.edu', 
    'Alex Thompson', 
    'STUDENT', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    'SSO',
    TRUE
)
ON CONFLICT (email) 
DO UPDATE SET
    full_name = EXCLUDED.full_name,
    password_hash = EXCLUDED.password_hash,
    is_active = TRUE,
    updated_at = CURRENT_TIMESTAMP;

-- Verify users were created/updated
SELECT 
    id,
    email, 
    full_name, 
    role, 
    auth_provider,
    is_active,
    created_at,
    updated_at
FROM app_user 
ORDER BY role, email;

-- Count users by role
SELECT 
    role,
    COUNT(*) as user_count
FROM app_user 
WHERE is_active = TRUE
GROUP BY role
ORDER BY role;

