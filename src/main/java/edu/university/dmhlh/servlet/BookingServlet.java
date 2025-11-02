package edu.university.dmhlh.servlet;

import edu.university.dmhlh.dao.BookingDAO;
import edu.university.dmhlh.model.Booking;
import edu.university.dmhlh.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.getRequestDispatcher("/WEB-INF/views/booking/form.jsp").forward(request, response);
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

        String dateStr = request.getParameter("preferred_date");
        String timeStr = request.getParameter("preferred_time");
        String reason = request.getParameter("reason");

        Booking booking = new Booking();
        booking.setUserId(user.getId());
        booking.setPreferredDate(Date.valueOf(dateStr));
        booking.setPreferredTime(Time.valueOf(timeStr + ":00"));
        booking.setReason(reason);

        bookingDAO.save(booking);
        response.sendRedirect(request.getContextPath() + "/booking?success=true");
    }
}

