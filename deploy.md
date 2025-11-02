# DMHLH Deployment Guide

## Prerequisites
- Java 11 or higher
- Maven 3.6+
- Apache Tomcat 9
- PostgreSQL database (Supabase)

## Environment Variables

The application reads database credentials from environment variables (recommended for production).

### Required Environment Variables:

```bash
DB_URL=jdbc:postgresql://aws-1-ap-southeast-1.pooler.supabase.com:5432/postgres
DB_USERNAME=postgres.dzcwtuudnssrvugjgauf
DB_PASSWORD=your_password_here
```

### Local Development:

**Option 1: Use web.xml fallback values** (already configured)
- Just run Tomcat normally
- Values in `web.xml` will be used

**Option 2: Use environment variables** (recommended)
- **Windows:** Run `setenv-local.bat` before starting Tomcat
- **Linux/Mac:** Export variables in terminal:
  ```bash
  export DB_URL="jdbc:postgresql://..."
  export DB_USERNAME="postgres.dzcwtuudnssrvugjgauf"
  export DB_PASSWORD="ip_dhml@2026"
  ```

### Production Deployment:

Set environment variables in your hosting platform's dashboard (Docsploy, Railway, Render, etc.)

## Build Instructions

```bash
# Clean and build
mvn clean package -DskipTests

# The WAR file will be created at: target/dhml.war
```

## Deployment to Tomcat

1. Copy `target/dhml.war` to Tomcat's `webapps` directory
2. Start Tomcat
3. Access at: `http://your-domain:8080/dhml`

## Deployment to Cloud Platforms

### For Docsploy/Railway/Render:

1. **Push to GitHub:**
   ```bash
   git add .
   git commit -m "Initial commit"
   git push -u origin main
   ```

2. **Connect your repository** to the deployment platform

3. **Set environment variables** (DB_URL, DB_USERNAME, DB_PASSWORD)

4. **Build command:**
   ```bash
   mvn clean package -DskipTests
   ```

5. **Start command:**
   - If using embedded Tomcat, configure in `pom.xml`
   - Otherwise, deploy WAR to Tomcat instance

## Database Setup

Run the following SQL in your Supabase SQL Editor:

```sql
-- See: database/schema.sql
-- See: database/verify-users.sql
```

## Demo Credentials

- **Admin:** admin@university.edu / admin123
- **Counsellor:** counsellor@university.edu / admin123
- **Faculty:** faculty@university.edu / admin123
- **Student:** student@university.edu / admin123

## URLs

- **Login:** `/dhml/login`
- **Student Dashboard:** `/dhml/student/dashboard`
- **Faculty Dashboard:** `/dhml/faculty/dashboard`
- **Admin Dashboard:** `/dhml/admin/dashboard`

## Troubleshooting

1. **404 Error:** Make sure WAR file is deployed and Tomcat is running
2. **Database Connection Error:** Check environment variables and Supabase credentials
3. **Login Failed:** Verify users exist in database by running `verify-users.sql`

