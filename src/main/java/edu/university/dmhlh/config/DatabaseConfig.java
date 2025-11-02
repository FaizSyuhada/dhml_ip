package edu.university.dmhlh.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Database configuration and connection pool management using HikariCP
 */
public class DatabaseConfig {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseConfig.class);
    private static HikariDataSource dataSource;

    /**
     * Initialize the database connection pool
     */
    public static void initialize(ServletContext context) {
        if (dataSource != null) {
            logger.warn("DataSource already initialized");
            return;
        }

        try {
            // Read from environment variables first, fallback to context params
            String dbUrl = System.getenv("DB_URL");
            String dbUsername = System.getenv("DB_USERNAME");
            String dbPassword = System.getenv("DB_PASSWORD");
            
            // Fallback to web.xml if env vars not set
            if (dbUrl == null || dbUrl.isEmpty()) {
                dbUrl = context.getInitParameter("db.url");
            }
            if (dbUsername == null || dbUsername.isEmpty()) {
                dbUsername = context.getInitParameter("db.username");
            }
            if (dbPassword == null || dbPassword.isEmpty()) {
                dbPassword = context.getInitParameter("db.password");
            }
            
            logger.info("Database URL: " + (dbUrl != null ? dbUrl.replaceAll(":[^:]+@", ":***@") : "NULL"));
            logger.info("Database Username: " + (dbUsername != null ? dbUsername : "NULL"));

            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(dbUrl);
            config.setUsername(dbUsername);
            config.setPassword(dbPassword);
            config.setDriverClassName("org.postgresql.Driver"); // Explicitly set driver
            
            // Pool configuration
            config.setMaximumPoolSize(10);
            config.setMinimumIdle(2);
            config.setConnectionTimeout(30000);
            config.setIdleTimeout(600000);
            config.setMaxLifetime(1800000);
            
            // Connection test query
            config.setConnectionTestQuery("SELECT 1");
            
            dataSource = new HikariDataSource(config);
            logger.info("Database connection pool initialized successfully");
        } catch (Exception e) {
            logger.error("Failed to initialize database connection pool", e);
            throw new RuntimeException("Database initialization failed", e);
        }
    }

    /**
     * Get a connection from the pool
     */
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            throw new SQLException("DataSource not initialized");
        }
        return dataSource.getConnection();
    }

    /**
     * Get the DataSource instance
     */
    public static DataSource getDataSource() {
        return dataSource;
    }

    /**
     * Close the connection pool
     */
    public static void shutdown() {
        if (dataSource != null && !dataSource.isClosed()) {
            dataSource.close();
            logger.info("Database connection pool closed");
        }
    }

    /**
     * Close a connection and suppress any exceptions
     */
    public static void closeQuietly(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                logger.error("Error closing connection", e);
            }
        }
    }

    /**
     * Close AutoCloseable resources quietly
     */
    public static void closeQuietly(AutoCloseable... closeables) {
        for (AutoCloseable closeable : closeables) {
            if (closeable != null) {
                try {
                    closeable.close();
                } catch (Exception e) {
                    logger.error("Error closing resource", e);
                }
            }
        }
    }
}

