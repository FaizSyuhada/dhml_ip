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
import java.util.List;

@WebServlet("/counsellor/bookings")
public class CounsellorBookingsServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isCounsellor()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Booking> bookings = bookingDAO.getAllPending();
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/views/counsellor/bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String bookingId = request.getParameter("booking_id");
        String notes = request.getParameter("notes");
        
        if (bookingId != null && notes != null) {
            bookingDAO.updateNotes(Integer.parseInt(bookingId), notes);
        }
        
        response.sendRedirect(request.getContextPath() + "/counsellor/bookings");
    }
}

