# Digital Mental Health Literacy Hub (DMHLH)

## Overview

The Digital Mental Health Literacy Hub is a comprehensive web application designed to improve student mental health literacy and provide access to support services. This prototype includes self-paced learning modules, validated mental health assessments (PHQ-9/GAD-7), mood tracking, AI-driven care plans, counselling booking, and peer support forums.

## Features

### Module 1: User Access & Profile
- Dummy SSO login with username/password
- Mock Google OAuth login (auto-provisions student accounts)
- User consent management
- Profile customization (language, accessibility options)
- Role-based access control (Student, Counsellor, Faculty, Admin)

### Module 2: Awareness & Learning
- Educational modules on mental health topics
- Interactive quizzes with scoring
- Progress tracking
- Faculty training resources

### Module 3: Self-Assessment & Mood
- PHQ-9 (depression screening)
- GAD-7 (anxiety screening)
- Daily mood logging with trend visualization
- Automatic "light nudge" notifications for low mood patterns

### Module 4: Goals & Habits (Prototype)
- Goal setting and habit tracking
- Streak monitoring
- Self-care activity guides

### Module 5: AI Coach
- Dummy rule-based AI for care plan generation
- Risk level assessment based on PHQ-9/GAD-7 scores
- Personalized recommendations
- Crisis hotline integration for high-risk cases

### Module 6: Tele-Counselling (Prototype)
- Booking request form
- Counsellor dashboard for managing appointments
- Session note capability

### Module 7: Peer Support Forum
- Anonymous posting with pseudonymous IDs
- Post reporting mechanism
- Moderation dashboard for counsellors/admins

### Module 8: Admin Analytics & Faculty Referrals
- Aggregated analytics dashboard
- User management
- Faculty student referral system
- Feedback collection
- Integration configuration

## Technology Stack

- **Frontend:** JSP, Bootstrap 5, JavaScript
- **Backend:** Java Servlets (javax.servlet API)
- **Server:** Apache Tomcat 9
- **Database:** PostgreSQL (Supabase)
- **Connection Pool:** HikariCP
- **Build Tool:** Maven
- **Authentication:** BCrypt for password hashing

## Prerequisites

- Java JDK 11 or higher
- Apache Maven 3.6+
- Apache Tomcat 9
- PostgreSQL database (Supabase account recommended)

## Setup Instructions

### 1. Clone the Repository
```bash
cd d:/Kuliah/IP/Project/dhml
```

### 2. Configure Database

1. Create a Supabase PostgreSQL database (or use local PostgreSQL)
2. Run the schema creation script:
   ```bash
   psql -h YOUR_SUPABASE_HOST -U YOUR_USERNAME -d YOUR_DATABASE -f database/schema.sql
   ```

3. Update database credentials in `src/main/webapp/WEB-INF/web.xml`:
   ```xml
   <context-param>
       <param-name>db.url</param-name>
       <param-value>jdbc:postgresql://YOUR_SUPABASE_HOST:5432/YOUR_DATABASE</param-value>
   </context-param>
   <context-param>
       <param-name>db.username</param-name>
       <param-value>YOUR_USERNAME</param-value>
   </context-param>
   <context-param>
       <param-name>db.password</param-name>
       <param-value>YOUR_PASSWORD</param-value>
   </context-param>
   ```

### 3. Build the Application
```bash
mvn clean package
```

This will create a WAR file at `target/dmhlh.war`

### 4. Deploy to Tomcat

#### Option A: Manual Deployment
1. Copy `target/dmhlh.war` to Tomcat's `webapps` directory
2. Start Tomcat server
3. Access the application at `http://localhost:8080/dmhlh`

#### Option B: Maven Tomcat Plugin
1. Configure Tomcat manager credentials in `~/.m2/settings.xml`
2. Run: `mvn tomcat7:deploy`

### 5. Access the Application

Navigate to: `http://localhost:8080/dmhlh`

## Demo Credentials

The database is pre-populated with demo accounts:

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@university.edu | admin123 |
| Counsellor | counsellor@university.edu | admin123 |
| Faculty | faculty@university.edu | admin123 |
| Student | student@university.edu | admin123 |

## Application Structure

```
dmhlh/
├── src/
│   └── main/
│       ├── java/edu/university/dmhlh/
│       │   ├── config/          # Database configuration
│       │   ├── dao/              # Data Access Objects
│       │   ├── filter/           # Authentication filters
│       │   ├── listener/         # Application listeners
│       │   ├── model/            # Entity models
│       │   ├── servlet/          # HTTP servlets
│       │   └── util/             # Utility classes
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── views/        # JSP pages
│           │   ├── includes/     # Reusable JSP components
│           │   └── web.xml       # Deployment descriptor
│           └── login.jsp         # Public login page
├── database/
│   └── schema.sql                # Database schema & sample data
├── pom.xml                       # Maven configuration
└── README.md                     # This file
```

## Key Business Rules

- **BR-01:** Students must accept consent before accessing assessments/mood/goals
- **BR-02:** Light Nudge triggers when average of last 3 mood logs ≤ 2.0
- **BR-03:** PHQ-9 Risk Levels:
  - Minimal: 0-4
  - Mild: 5-9
  - Moderate: 10-14
  - Moderately Severe: 15-19
  - Severe: 20-27
- **BR-04:** Scores ≥15 on PHQ-9 or GAD-7 prompt counselling booking
- **BR-05:** Forum posts display pseudonymous IDs for privacy
- **BR-06:** Faculty referrals require explicit student consent

## Security Considerations

⚠️ **This is a PROTOTYPE for educational purposes:**
- Uses dummy SSO (not real campus authentication)
- No HTTPS enforcement (configure in production)
- Simplified session management
- Not HIPAA/GDPR compliant as-is
- Not intended for clinical use

## Development

### Running in Development Mode
```bash
mvn clean tomcat7:run
```

### Logging
Application logs are output to console and can be configured in `src/main/resources/simplelogger.properties`

### Database Migrations
For schema changes, update `database/schema.sql` and re-run the SQL script.

## Troubleshooting

### Database Connection Issues
- Verify Supabase credentials in `web.xml`
- Check firewall rules allow PostgreSQL connections
- Ensure HikariCP connection pool is properly configured

### Deployment Issues
- Verify Tomcat 9 is running
- Check `catalina.out` logs for errors
- Ensure Java 11+ is configured for Tomcat

### Authentication Issues
- Clear browser cookies/session
- Verify BCrypt password hashes in database
- Check `AuthenticationFilter` is registered in `web.xml`

## Future Enhancements

- Real university SSO integration (SAML/OAuth)
- True AI/ML-based care plan generation
- Email/SMS notifications
- Mobile app (React Native)
- EHR integration
- Advanced analytics and reporting
- Video counselling capability

## License

This is a prototype for educational purposes. Not licensed for production use.

## Support

For issues or questions:
- Email: support@university.edu
- Crisis Hotline: 1-800-273-8255

---
**Disclaimer:** This application is a prototype for demonstration purposes only. It is not intended to replace professional mental health diagnosis, treatment, or emergency services.

