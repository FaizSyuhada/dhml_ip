package edu.university.dmhlh.servlet;

import com.google.gson.Gson;
import edu.university.dmhlh.dao.AssessmentDAO;
import edu.university.dmhlh.dao.CarePlanDAO;
import edu.university.dmhlh.model.AssessmentResult;
import edu.university.dmhlh.model.CarePlan;
import edu.university.dmhlh.model.User;
import edu.university.dmhlh.util.AssessmentUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/ai-coach")
public class AICoachServlet extends HttpServlet {
    private static final Logger logger = LoggerFactory.getLogger(AICoachServlet.class);
    private AssessmentDAO assessmentDAO = new AssessmentDAO();
    private CarePlanDAO carePlanDAO = new CarePlanDAO();
    private Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        CarePlan latestPlan = carePlanDAO.getLatest(user.getId());
        request.setAttribute("carePlan", latestPlan);
        request.getRequestDispatcher("/WEB-INF/views/ai-coach/dashboard.jsp").forward(request, response);
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

        // Get latest assessments
        AssessmentResult phq9 = assessmentDAO.getLatest(user.getId(), "PHQ9");
        AssessmentResult gad7 = assessmentDAO.getLatest(user.getId(), "GAD7");

        Integer phq9Score = phq9 != null ? phq9.getScore() : null;
        Integer gad7Score = gad7 != null ? gad7.getScore() : null;

        // Dummy AI logic - rule-based recommendations
        String riskLevel = AssessmentUtil.calculateRiskLevel(phq9Score, gad7Score);
        List<String> recommendations = generateRecommendations(riskLevel, phq9Score, gad7Score);
        
        String summary = "Based on your assessment results, we've created a personalized care plan for you.";

        CarePlan carePlan = new CarePlan();
        carePlan.setUserId(user.getId());
        carePlan.setSummary(summary);
        carePlan.setRiskLevel(riskLevel);
        carePlan.setPhq9Score(phq9Score);
        carePlan.setGad7Score(gad7Score);
        carePlan.setRecommendationsJson(gson.toJson(recommendations));

        carePlanDAO.save(carePlan);

        response.sendRedirect(request.getContextPath() + "/ai-coach?generated=true");
    }

    private List<String> generateRecommendations(String riskLevel, Integer phq9, Integer gad7) {
        List<String> recs = new ArrayList<>();
        
        if ("SEVERE".equals(riskLevel) || "HIGH".equals(riskLevel)) {
            recs.add("Book a counselling session immediately - professional support is recommended");
            recs.add("Contact crisis hotline if you're in immediate distress: 1-800-273-8255");
            recs.add("Practice daily self-care activities");
            recs.add("Reach out to trusted friends or family");
        } else if ("MODERATE".equals(riskLevel)) {
            recs.add("Consider booking a counselling session");
            recs.add("Complete the learning modules on depression and anxiety");
            recs.add("Track your mood daily to identify patterns");
            recs.add("Practice mindfulness and relaxation techniques");
            recs.add("Maintain regular sleep and exercise routines");
        } else {
            recs.add("Continue tracking your mood regularly");
            recs.add("Explore learning modules to increase mental health literacy");
            recs.add("Set wellness goals and track your progress");
            recs.add("Engage with peer support in the forum");
        }
        
        return recs;
    }
}

