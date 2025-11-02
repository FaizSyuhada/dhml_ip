<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consent - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background: #f8f9fa;
        }
        .consent-container {
            max-width: 800px;
            margin: 50px auto;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 40px;
        }
        .consent-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .consent-header i {
            font-size: 50px;
            color: #667eea;
        }
        .consent-content {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            max-height: 400px;
            overflow-y: auto;
            margin-bottom: 25px;
        }
        .consent-content h4 {
            color: #333;
            margin-top: 20px;
        }
        .consent-content p {
            color: #666;
            line-height: 1.6;
        }
        .consent-checkbox {
            background: #fff3cd;
            border: 2px solid #ffc107;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .btn-accept {
            background: #667eea;
            border: none;
            padding: 12px 40px;
            font-weight: 500;
        }
        .btn-accept:hover {
            background: #5568d3;
        }
        .btn-decline {
            background: #6c757d;
            border: none;
            padding: 12px 40px;
        }
    </style>
</head>
<body>
    <div class="consent-container">
        <div class="consent-header">
            <i class="bi bi-shield-check"></i>
            <h2>Privacy & Consent</h2>
            <p class="text-muted">Please review and accept to continue</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <div class="consent-content">
            <h4><i class="bi bi-file-text"></i> Terms of Use</h4>
            <p>
                Welcome to the Digital Mental Health Literacy Hub (DMHLH). This platform is designed to 
                support your mental health and wellness journey through educational resources, self-assessment 
                tools, and connections to professional support.
            </p>

            <h4><i class="bi bi-lock"></i> Data Collection & Privacy</h4>
            <p>
                We collect and process the following information to provide you with personalized support:
            </p>
            <ul>
                <li>Your name, email, and university affiliation</li>
                <li>Self-assessment results (PHQ-9, GAD-7 scores)</li>
                <li>Mood logs and personal goals</li>
                <li>Learning progress and quiz results</li>
                <li>Anonymous forum posts (pseudonymized)</li>
                <li>Counselling booking requests</li>
            </ul>

            <h4><i class="bi bi-shield-lock"></i> Data Protection</h4>
            <p>
                Your data is securely stored and will only be accessed by:
            </p>
            <ul>
                <li>You, at any time through your profile</li>
                <li>Licensed counsellors for appointments you book</li>
                <li>Administrators in aggregated, non-identifiable form for system analytics</li>
            </ul>

            <h4><i class="bi bi-exclamation-triangle"></i> Important Notes</h4>
            <p>
                <strong>This is NOT a clinical tool:</strong> DMHLH is for educational and support purposes. 
                It does not replace professional medical advice, diagnosis, or treatment.
            </p>
            <p>
                <strong>Crisis Support:</strong> If you're experiencing a mental health crisis, please contact 
                emergency services or the crisis hotline: <strong>1-800-273-8255</strong>
            </p>

            <h4><i class="bi bi-check-circle"></i> Your Rights</h4>
            <p>
                You have the right to:
            </p>
            <ul>
                <li>Access your data at any time</li>
                <li>Request data deletion (subject to regulatory requirements)</li>
                <li>Withdraw consent and discontinue use</li>
                <li>Report concerns to privacy@university.edu</li>
            </ul>
        </div>

        <form action="<%= request.getContextPath() %>/consent" method="post">
            <div class="consent-checkbox">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="consentCheck" required>
                    <label class="form-check-label" for="consentCheck">
                        <strong>I have read and understood the above information, and I consent to:</strong>
                        <ul class="mt-2">
                            <li>The collection and processing of my data as described</li>
                            <li>The use of this platform for mental health literacy and support</li>
                            <li>Receiving notifications and recommendations based on my usage</li>
                        </ul>
                    </label>
                </div>
            </div>

            <div class="text-center">
                <input type="hidden" name="consent_accepted" id="consent_accepted" value="false">
                <button type="submit" class="btn btn-primary btn-accept" onclick="document.getElementById('consent_accepted').value='true'">
                    <i class="bi bi-check-lg"></i> I Accept
                </button>
                <a href="<%= request.getContextPath() %>/auth/logout" class="btn btn-secondary btn-decline">
                    <i class="bi bi-x-lg"></i> Decline & Logout
                </a>
            </div>
        </form>

        <div class="mt-4 text-center">
            <small class="text-muted">
                Last updated: October 31, 2025 | Questions? Contact support@university.edu
            </small>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

