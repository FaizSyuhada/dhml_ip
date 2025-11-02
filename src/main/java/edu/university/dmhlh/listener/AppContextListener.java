package edu.university.dmhlh.listener;

import edu.university.dmhlh.config.DatabaseConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Application lifecycle listener for initialization and cleanup
 */
@WebListener
public class AppContextListener implements ServletContextListener {
    private static final Logger logger = LoggerFactory.getLogger(AppContextListener.class);

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        logger.info("DMHLH Application starting...");
        try {
            // Initialize database connection pool
            DatabaseConfig.initialize(sce.getServletContext());
            logger.info("DMHLH Application started successfully");
        } catch (Exception e) {
            logger.error("Failed to start application", e);
            throw new RuntimeException("Application initialization failed", e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        logger.info("DMHLH Application shutting down...");
        try {
            // Close database connection pool
            DatabaseConfig.shutdown();
            logger.info("DMHLH Application stopped successfully");
        } catch (Exception e) {
            logger.error("Error during application shutdown", e);
        }
    }
}

