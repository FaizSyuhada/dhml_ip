package edu.university.dmhlh.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Simple health check endpoint for debugging
 */
@WebServlet("/health")
public class HealthCheckServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        response.setStatus(HttpServletResponse.SC_OK);
        
        PrintWriter out = response.getWriter();
        out.println("OK");
        out.println("DMHLH Application is running");
        out.println("Server time: " + new java.util.Date());
        out.flush();
    }
}

