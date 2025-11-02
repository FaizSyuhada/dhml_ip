<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - DMHLH</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #8B0000 0%, #5D0000 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        .sso-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            max-width: 500px;
            width: 100%;
            overflow: hidden;
        }
        .sso-header {
            background: linear-gradient(135deg, #8B0000 0%, #6B0000 100%);
            padding: 40px 30px;
            text-align: center;
            color: white;
        }
        .sso-header .logo {
            width: 80px;
            height: 80px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            backdrop-filter: blur(10px);
        }
        .sso-header .logo i {
            font-size: 40px;
            color: white;
        }
        .sso-header h1 {
            font-size: 24px;
            font-weight: 600;
            margin: 0 0 5px 0;
        }
        .sso-header p {
            font-size: 14px;
            margin: 0;
            opacity: 0.9;
        }
        .sso-body {
            padding: 35px 40px 40px;
        }
        .sso-body h2 {
            font-size: 20px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 8px;
            text-align: center;
        }
        .sso-body .subtitle {
            text-align: center;
            color: #6b7280;
            font-size: 14px;
            margin-bottom: 25px;
        }
        .redirect-info {
            background: #fee;
            border: 1px solid #fcc;
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 25px;
            display: flex;
            align-items: flex-start;
            gap: 10px;
        }
        .redirect-info i {
            color: #8B0000;
            font-size: 18px;
            margin-top: 2px;
        }
        .redirect-info-content {
            flex: 1;
        }
        .redirect-info-content .label {
            font-size: 12px;
            color: #7B0000;
            font-weight: 500;
            margin-bottom: 2px;
        }
        .redirect-info-content .app-name {
            font-size: 14px;
            color: #5B0000;
            font-weight: 600;
        }
        .form-label {
            font-size: 13px;
            font-weight: 600;
            color: #374151;
            margin-bottom: 8px;
        }
        .form-control {
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px 15px;
            font-size: 14px;
            transition: all 0.2s;
        }
        .form-control:focus {
            border-color: #8B0000;
            box-shadow: 0 0 0 3px rgba(139, 0, 0, 0.1);
        }
        .form-control::placeholder {
            color: #9ca3af;
        }
        .btn-sign-in {
            width: 100%;
            background: #8B0000;
            border: none;
            border-radius: 8px;
            padding: 14px;
            font-size: 15px;
            font-weight: 600;
            color: white;
            transition: all 0.2s;
        }
        .btn-sign-in:hover {
            background: #6B0000;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(139, 0, 0, 0.3);
        }
        .divider {
            text-align: center;
            margin: 25px 0;
            position: relative;
        }
        .divider::before {
            content: "";
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            height: 1px;
            background: #e5e7eb;
        }
        .divider span {
            background: white;
            padding: 0 15px;
            position: relative;
            color: #6b7280;
            font-size: 13px;
            font-weight: 500;
        }
        .btn-alternative {
            width: 100%;
            background: white;
            border: 2px solid #e5e7eb;
            border-radius: 8px;
            padding: 12px;
            font-size: 14px;
            font-weight: 600;
            color: #374151;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
        }
        .btn-alternative:hover {
            background: #f9fafb;
            border-color: #8B0000;
            color: #8B0000;
        }
        .btn-alternative img {
            width: 20px;
            height: 20px;
        }
        .sso-footer {
            text-align: center;
            color: #6b7280;
            font-size: 12px;
            padding-top: 20px;
            border-top: 1px solid #e5e7eb;
        }
        .alert {
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 13px;
        }
        .alert-danger {
            background: #fef2f2;
            border: 1px solid #fecaca;
            color: #991b1b;
        }
        .alert-success {
            background: #f0fdf4;
            border: 1px solid #bbf7d0;
            color: #166534;
        }
    </style>
</head>
<body>
    <div class="sso-container">
        <div class="sso-header">
            <div class="logo">
                <i class="bi bi-heart-pulse-fill"></i>
            </div>
            <h1>University of Technology</h1>
            <p>Single Sign-On Portal</p>
        </div>

        <div class="sso-body">
            <h2>Sign in to your account</h2>
            <p class="subtitle">Use your university credentials to access DMHLH</p>

            <div class="redirect-info">
                <i class="bi bi-info-circle-fill"></i>
                <div class="redirect-info-content">
                    <div class="label">Redirecting to:</div>
                    <div class="app-name">Digital Mental Health Literacy Hub</div>
                </div>
            </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger" role="alert">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% if (request.getParameter("registered") != null) { %>
            <div class="alert alert-success" role="alert">
                Registration successful! Please login.
            </div>
        <% } %>

            <!-- SSO Login Form -->
            <form action="<%= request.getContextPath() %>/auth/login" method="post">
                <div class="mb-3">
                    <label for="email" class="form-label">Student/Staff ID or Email</label>
                    <input type="text" class="form-control" id="email" name="email" 
                           placeholder="e.g., ST2024001 or email@university.edu" required>
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">University Password</label>
                    <div style="position: relative;">
                        <input type="password" class="form-control" id="password" name="password" 
                               placeholder="Your university password" required style="padding-right: 45px;">
                        <button type="button" onclick="togglePassword()" 
                                style="position: absolute; right: 10px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer; color: #6b7280; padding: 5px;">
                            <i class="bi bi-eye" id="toggleIcon"></i>
                        </button>
                    </div>
                </div>

                <button type="submit" class="btn-sign-in">
                    Sign In
                </button>
            </form>

            <div class="divider">
                <span>Alternative sign-in methods</span>
            </div>

            <!-- University Gmail Login -->
            <button type="button" class="btn-alternative" onclick="showGoogleModal()">
                <img src="https://www.google.com/favicon.ico" alt="Google">
                Continue with Uni Gmail
            </button>

            <div class="sso-footer">
                <strong>Protected by University Security Systems</strong>
            </div>

            <!-- Demo Credentials -->
            <div class="mt-3">
                <details>
                    <summary style="font-size: 12px; cursor: pointer; color: #6b7280;">
                        Demo Credentials
                    </summary>
                    <div class="mt-2" style="font-size: 11px; color: #666;">
                        <strong>Emails:</strong> admin@university.edu, counsellor@university.edu, faculty@university.edu, student@university.edu<br>
                        <strong>Password:</strong> admin123
                    </div>
                </details>
            </div>
        </div>
    </div>

    <!-- Google SSO Modal -->
    <div id="googleModal" style="display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 9999; align-items: center; justify-content: center;">
        <div style="background: #374151; border-radius: 12px; padding: 25px; max-width: 400px; width: 90%; color: white; box-shadow: 0 10px 40px rgba(0,0,0,0.4);">
            <div style="display: flex; align-items: center; gap: 12px; margin-bottom: 20px;">
                <img src="https://www.google.com/favicon.ico" alt="Google" style="width: 24px; height: 24px;">
                <h3 style="margin: 0; font-size: 18px; font-weight: 600;">Google SSO Integration</h3>
            </div>
            <div style="margin-bottom: 20px;">
                <p style="margin: 0 0 15px 0; font-size: 14px; line-height: 1.6;">
                    This would redirect to:<br>
                    <code style="background: rgba(255,255,255,0.1); padding: 4px 8px; border-radius: 4px; font-size: 12px; display: inline-block; margin-top: 8px;">https://accounts.google.com/oauth/authorize</code>
                </p>
                <p style="margin: 0; font-size: 13px; color: #d1d5db;">
                    For demo purposes, use the form above.
                </p>
            </div>
            <button onclick="closeGoogleModal()" style="background: #06b6d4; border: none; border-radius: 6px; padding: 10px 20px; color: white; font-weight: 600; width: 100%; cursor: pointer; font-size: 14px;">
                OK
            </button>
        </div>
    </div>

    <script>
        function showGoogleModal() {
            document.getElementById('googleModal').style.display = 'flex';
        }

        function closeGoogleModal() {
            document.getElementById('googleModal').style.display = 'none';
        }

        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('bi-eye');
                toggleIcon.classList.add('bi-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('bi-eye-slash');
                toggleIcon.classList.add('bi-eye');
            }
        }

        // Close modal when clicking outside
        document.getElementById('googleModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeGoogleModal();
            }
        });
    </script>
</body>
</html>

