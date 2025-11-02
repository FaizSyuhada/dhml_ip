# Security Guidelines - DMHLH

## 🔐 Security Measures Implemented

### 1. **SQL Injection Protection** ✅
- All database queries use `PreparedStatement` with parameterized queries
- No string concatenation with user input
- User input is always sanitized before database operations

### 2. **Password Security** ✅
- Passwords hashed using BCrypt with salt (cost factor: 10)
- Passwords never stored in plain text
- Password verification uses constant-time comparison (BCrypt.checkpw)

### 3. **Authentication & Session Management** ✅
- Session-based authentication with HttpOnly cookies
- Session timeout: 30 minutes
- Authentication filter protects all routes except public pages
- Generic error messages to prevent user enumeration

### 4. **Database Credentials** ✅
- Environment variables for production (DB_URL, DB_USERNAME, DB_PASSWORD)
- No hardcoded credentials in version control
- Credentials masked in logs

### 5. **Logging** ✅
- No sensitive data (passwords, tokens) in logs
- Generic messages for failed login attempts
- IP addresses and user agents NOT logged (privacy)

## ⚠️ Security Recommendations for Production

### **CRITICAL - Must Do Before Deployment:**

1. **Enable HTTPS**
   ```xml
   <!-- In web.xml, change: -->
   <secure>true</secure>  <!-- Currently false -->
   ```

2. **Set Environment Variables**
   ```bash
   DB_URL=jdbc:postgresql://your-host:5432/postgres
   DB_USERNAME=your_username
   DB_PASSWORD=your_secure_password
   ```

3. **Change Default Passwords**
   - All demo accounts use `admin123`
   - Change these in production or disable demo accounts

4. **Enable Supabase Row Level Security (RLS)**
   - Go to Supabase Dashboard → Authentication → Policies
   - Enable RLS on all tables
   - Create policies to restrict access

5. **Database Connection Security**
   - Use SSL/TLS for database connections
   - Restrict database access to application IP only
   - Use connection pooling (HikariCP already implemented)

### **Recommended - Should Do:**

6. **Implement CSRF Protection**
   - Add CSRF tokens to forms
   - Verify tokens on POST requests

7. **Add Rate Limiting**
   - Limit login attempts (5 attempts per 15 minutes)
   - Add captcha after multiple failed attempts

8. **Input Validation**
   - Add more comprehensive input validation
   - Implement content security policy (CSP)

9. **Error Handling**
   - Custom error pages (already implemented)
   - Don't expose stack traces in production

10. **Security Headers**
    Add these HTTP headers:
    ```
    X-Content-Type-Options: nosniff
    X-Frame-Options: DENY
    X-XSS-Protection: 1; mode=block
    Strict-Transport-Security: max-age=31536000
    ```

## 🚨 Known Limitations

1. **No CSRF Protection** - Forms don't have CSRF tokens
2. **No Rate Limiting** - Brute force attacks possible
3. **Basic XSS Protection** - Relies on JSP default escaping
4. **Session Fixation** - Not fully protected
5. **No Account Lockout** - Unlimited login attempts

## 📋 Security Checklist for Deployment

- [ ] Set environment variables (DB_URL, DB_USERNAME, DB_PASSWORD)
- [ ] Enable HTTPS and set `secure=true` for cookies
- [ ] Change all demo account passwords
- [ ] Enable Supabase RLS
- [ ] Restrict database access by IP
- [ ] Enable database SSL
- [ ] Review and update Supabase API keys
- [ ] Set up monitoring and alerts
- [ ] Backup database regularly
- [ ] Test authentication and authorization
- [ ] Scan for vulnerabilities (OWASP ZAP, etc.)

## 🔒 Supabase Specific Security

### 1. **Enable Row Level Security**
```sql
-- Example: Only users can see their own data
ALTER TABLE app_user ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own data" ON app_user
  FOR SELECT USING (auth.uid() = id::text);
```

### 2. **Database Permissions**
- Don't use the `postgres` superuser role
- Create a dedicated role with limited permissions
- Grant only necessary permissions (SELECT, INSERT, UPDATE)

### 3. **API Security**
- Use Supabase service_role key only on server-side
- Never expose service_role key in client code
- Use anon key with RLS for client operations

### 4. **Network Security**
- Enable connection pooling (already done)
- Use Session Pooler for IPv4 (already configured)
- Consider IP whitelisting in Supabase settings

## 🛡️ Security Contact

If you discover a security vulnerability, please:
1. **DO NOT** open a public issue
2. Email: security@yourdomain.com (replace with actual)
3. Include detailed steps to reproduce
4. Allow reasonable time for fix before disclosure

## 📚 Additional Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Supabase Security Best Practices](https://supabase.com/docs/guides/database/security)
- [Java Servlet Security](https://docs.oracle.com/javaee/7/tutorial/security-intro.htm)
- [BCrypt Information](https://github.com/jeremyh/jBCrypt)

---

**Last Updated:** 2025-11-02
**Security Review:** Recommended quarterly

