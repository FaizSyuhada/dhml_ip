package edu.university.dmhlh.servlet;

import edu.university.dmhlh.dao.ForumDAO;
import edu.university.dmhlh.model.ForumPost;
import edu.university.dmhlh.model.User;
import edu.university.dmhlh.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/forum")
public class ForumServlet extends HttpServlet {
    private ForumDAO forumDAO = new ForumDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<ForumPost> posts = forumDAO.getActivePosts();
        request.setAttribute("posts", posts);
        request.getRequestDispatcher("/WEB-INF/views/forum/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        ForumPost post = new ForumPost();
        post.setUserId(user.getId());
        post.setPseudoId(PasswordUtil.generatePseudoId(user.getId()));
        post.setTitle(title);
        post.setContent(content);

        forumDAO.save(post);
        response.sendRedirect(request.getContextPath() + "/forum");
    }
}

