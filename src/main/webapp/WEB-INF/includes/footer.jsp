<style>
    footer {
        background: #f8f9fa;
        margin-top: 50px;
        padding: 30px 0;
        border-top: 1px solid #dee2e6;
    }
    footer p {
        margin: 0;
        color: #666;
    }
    footer a {
        color: #667eea;
        text-decoration: none;
    }
    footer a:hover {
        text-decoration: underline;
    }
</style>

<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h5><i class="bi bi-heart-pulse-fill text-primary"></i> DMHLH</h5>
                <p>Digital Mental Health Literacy Hub</p>
                <p class="text-muted" style="font-size: 12px;">
                    This is a prototype system for educational purposes only.<br>
                    Not intended for clinical diagnosis or treatment.
                </p>
            </div>
            <div class="col-md-3">
                <h6>Resources</h6>
                <ul class="list-unstyled">
                    <li><a href="#"><i class="bi bi-info-circle"></i> About</a></li>
                    <li><a href="#"><i class="bi bi-shield-lock"></i> Privacy Policy</a></li>
                    <li><a href="#"><i class="bi bi-file-text"></i> Terms of Use</a></li>
                    <li><a href="<%= request.getContextPath() %>/feedback"><i class="bi bi-chat-left-text"></i> Feedback</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h6>Support</h6>
                <ul class="list-unstyled">
                    <li><i class="bi bi-envelope"></i> support@university.edu</li>
                    <li><i class="bi bi-telephone"></i> Crisis: 1-800-273-8255</li>
                    <li><i class="bi bi-globe"></i> <a href="https://www.nimh.nih.gov" target="_blank">NIMH</a></li>
                </ul>
            </div>
        </div>
        <hr>
        <div class="text-center text-muted" style="font-size: 12px;">
            &copy; 2025 University Mental Health Services. All rights reserved.
        </div>
    </div>
</footer>

