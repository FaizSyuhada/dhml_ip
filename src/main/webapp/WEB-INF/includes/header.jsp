<%@ page import="edu.university.dmhlh.model.User" %>
<%
    User headerUser = (User) session.getAttribute("user");
    String currentPath = request.getRequestURI();
%>
<style>
    .navbar {
        box-shadow: 0 2px 4px rgba(0,0,0,.1);
    }
    .navbar-brand {
        font-weight: 600;
        color: #667eea !important;
    }
    .nav-link {
        color: #333 !important;
        font-weight: 500;
    }
    .nav-link:hover {
        color: #667eea !important;
    }
    .dropdown-menu {
        box-shadow: 0 4px 6px rgba(0,0,0,.1);
    }
</style>

<nav class="navbar navbar-expand-lg navbar-light bg-white">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%= request.getContextPath() %>/<%= headerUser != null ? headerUser.getRole().toLowerCase() + "/dashboard" : "" %>">
            <i class="bi bi-heart-pulse-fill"></i> DMHLH
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <% if (headerUser != null) { %>
            <ul class="navbar-nav me-auto">
                <% if (headerUser.isStudent()) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/student/dashboard">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/modules">
                            <i class="bi bi-book"></i> Learn
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/assessment">
                            <i class="bi bi-clipboard-check"></i> Assessment
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/forum">
                            <i class="bi bi-chat-dots"></i> Forum
                        </a>
                    </li>
                <% } else if (headerUser.isCounsellor()) { %>
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
                            <i class="bi bi-shield-check"></i> Moderate
                        </a>
                    </li>
                <% } else if (headerUser.isFaculty()) { %>
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
                            <i class="bi bi-mortarboard"></i> Training
                        </a>
                    </li>
                <% } else if (headerUser.isAdmin()) { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/admin/dashboard">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/admin/users">
                            <i class="bi bi-people"></i> Users
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/forum/moderate">
                            <i class="bi bi-shield-check"></i> Moderate
                        </a>
                    </li>
                <% } %>
            </ul>
            
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" 
                       data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle"></i> <%= headerUser.getFullName() %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/profile">
                            <i class="bi bi-person"></i> Profile
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="<%= request.getContextPath() %>/feedback">
                            <i class="bi bi-chat-left-text"></i> Feedback
                        </a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="<%= request.getContextPath() %>/auth/logout">
                            <i class="bi bi-box-arrow-right"></i> Logout
                        </a></li>
                    </ul>
                </li>
            </ul>
            <% } %>
        </div>
    </div>
</nav>

