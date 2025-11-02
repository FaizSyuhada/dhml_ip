<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User sidebarUser = (User) session.getAttribute("user");
    if (sidebarUser == null) return;
%>
<style>
    .sidebar {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,.1);
    }
    .sidebar .nav-link {
        color: #333;
        padding: 10px 15px;
        margin-bottom: 5px;
        border-radius: 5px;
        transition: all 0.3s;
    }
    .sidebar .nav-link:hover {
        background: #f8f9fa;
        color: #667eea;
    }
    .sidebar .nav-link.active {
        background: #667eea;
        color: white !important;
    }
    .sidebar .nav-link i {
        margin-right: 10px;
        width: 20px;
    }
</style>

<div class="sidebar">
    <% if (sidebarUser.isStudent()) { %>
        <h6 class="text-muted text-uppercase mb-3">Student Menu</h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/student/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/modules">
                    <i class="bi bi-book"></i> Learning Modules
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/assessment">
                    <i class="bi bi-clipboard-check"></i> Self-Assessment
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/mood">
                    <i class="bi bi-emoji-smile"></i> Mood Tracker
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/goals">
                    <i class="bi bi-target"></i> Goals & Habits
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/ai-coach">
                    <i class="bi bi-robot"></i> AI Coach
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/booking">
                    <i class="bi bi-calendar-check"></i> Book Counselling
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/forum">
                    <i class="bi bi-chat-dots"></i> Forum
                </a>
            </li>
        </ul>
    <% } else if (sidebarUser.isCounsellor()) { %>
        <h6 class="text-muted text-uppercase mb-3">Counsellor Menu</h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/counsellor/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/counsellor/bookings">
                    <i class="bi bi-calendar-check"></i> Bookings
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/forum/moderate">
                    <i class="bi bi-shield-check"></i> Moderate Forum
                </a>
            </li>
        </ul>
    <% } else if (sidebarUser.isFaculty()) { %>
        <h6 class="text-muted text-uppercase mb-3">Faculty Menu</h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/faculty/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/faculty/referral">
                    <i class="bi bi-person-exclamation"></i> Refer Student
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/faculty/training">
                    <i class="bi bi-mortarboard"></i> Training Guides
                </a>
            </li>
        </ul>
    <% } else if (sidebarUser.isAdmin()) { %>
        <h6 class="text-muted text-uppercase mb-3">Admin Menu</h6>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/admin/dashboard">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/admin/users">
                    <i class="bi bi-people"></i> Manage Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/admin/modules">
                    <i class="bi bi-book"></i> Content Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/forum/moderate">
                    <i class="bi bi-shield-check"></i> Moderate Forum
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/admin/feedback">
                    <i class="bi bi-chat-left-text"></i> View Feedback
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="<%= request.getContextPath() %>/admin/integrations">
                    <i class="bi bi-plug"></i> Integrations
                </a>
            </li>
        </ul>
    <% } %>
    
    <hr>
    <div class="text-center mt-3">
        <div class="alert alert-danger p-2" style="font-size: 12px;">
            <strong><i class="bi bi-telephone-fill"></i> Crisis Hotline</strong><br>
            1-800-273-8255
        </div>
    </div>
</div>

