package edu.university.dmhlh.filter;

import edu.university.dmhlh.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Filter to handle authentication for protected resources
 */
public class AuthenticationFilter implements Filter {
    private static final Logger logger = LoggerFactory.getLogger(AuthenticationFilter.class);

    // Public paths that don't require authentication
    private static final List<String> PUBLIC_PATHS = Arrays.asList(
        "/login",
        "/login.jsp",
        "/auth/login",
        "/auth/google",
        "/auth/logout",
        "/index.jsp",
        "/css/",
        "/js/",
        "/images/",
        "/error/"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logger.info("AuthenticationFilter initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());

        // Check if path is public
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is authenticated
        HttpSession session = httpRequest.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // Not authenticated - redirect to login
            logger.debug("Unauthenticated access attempt to: " + path);
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // Check if user has consented (except for consent page itself)
        if (!path.startsWith("/consent") && !user.hasConsented() && user.isStudent()) {
            logger.debug("User has not consented, redirecting to consent page");
            httpResponse.sendRedirect(contextPath + "/consent");
            return;
        }

        // User is authenticated and has consented (if required)
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        logger.info("AuthenticationFilter destroyed");
    }

    /**
     * Check if path is public (doesn't require authentication)
     */
    private boolean isPublicPath(String path) {
        if (path.equals("/") || path.isEmpty()) {
            return true;
        }
        
        for (String publicPath : PUBLIC_PATHS) {
            if (path.startsWith(publicPath)) {
                return true;
            }
        }
        
        return false;
    }
}

