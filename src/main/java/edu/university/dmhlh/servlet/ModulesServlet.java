package edu.university.dmhlh.servlet;

import edu.university.dmhlh.dao.LearningModuleDAO;
import edu.university.dmhlh.dao.QuizDAO;
import edu.university.dmhlh.model.LearningModule;
import edu.university.dmhlh.model.Quiz;
import edu.university.dmhlh.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to display learning modules
 */
@WebServlet("/modules")
public class ModulesServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(ModulesServlet.class);
    private LearningModuleDAO moduleDAO = new LearningModuleDAO();
    private QuizDAO quizDAO = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        String moduleIdStr = request.getParameter("id");

        if (action != null && "view".equals(action) && moduleIdStr != null) {
            // View specific module
            try {
                Integer moduleId = Integer.parseInt(moduleIdStr);
                LearningModule module = moduleDAO.findById(moduleId);
                
                if (module != null) {
                    // Get user's progress
                    Integer progress = moduleDAO.getProgress(user.getId(), moduleId);
                    
                    // Check if quiz exists for this module
                    Quiz quiz = quizDAO.findByModuleId(moduleId);
                    
                    request.setAttribute("module", module);
                    request.setAttribute("progress", progress);
                    request.setAttribute("quiz", quiz);
                    
                    request.getRequestDispatcher("/WEB-INF/views/modules/view.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/modules");
                }
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/modules");
            }
        } else {
            // List all modules
            List<LearningModule> modules = moduleDAO.findAllPublished();
            request.setAttribute("modules", modules);
            request.getRequestDispatcher("/WEB-INF/views/modules/list.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Mark module as complete
        String moduleIdStr = request.getParameter("module_id");
        String progressStr = request.getParameter("progress");

        if (moduleIdStr != null && progressStr != null) {
            try {
                Integer moduleId = Integer.parseInt(moduleIdStr);
                Integer progress = Integer.parseInt(progressStr);
                
                boolean updated = moduleDAO.recordProgress(user.getId(), moduleId, progress);
                
                if (updated) {
                    logger.info("Progress updated for user " + user.getId() + ", module " + moduleId + ": " + progress + "%");
                }
                
                response.sendRedirect(request.getContextPath() + "/modules?action=view&id=" + moduleId);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/modules");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/modules");
        }
    }
}

