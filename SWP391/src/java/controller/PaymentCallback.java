/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Food;
import model.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "PaymentCallback", urlPatterns = {"/PaymentCallback"})
public class PaymentCallback extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PaymentCallback</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PaymentCallback at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String transactionStatus = request.getParameter("vnp_TransactionStatus");
        User acc = (User) session.getAttribute("acc");
        if (acc != null) {
            List<Food> list = (List<Food>) session.getAttribute("cart");
            String address = (String) session.getAttribute("address");
            if ("00".equals(transactionStatus)) {
                double total = (double) session.getAttribute("total_s");
                OrderDAO od = new OrderDAO();
                boolean check = od.insertOnline(total, acc.getUsername());
                if (check) {
                    int id = od.getLast();
                    for (Food f : list) {
                        od.insert_detail(id, f);
                    }
                    od.insertDelivery(id, address);
                    session.removeAttribute("cart");
                    request.setAttribute("success", "Đơn hàng đã được order");
                    request.setAttribute("count_cart", 0);
                }
            } else {
                request.setAttribute("err", "Đơn hàng thanh toán thất bại");
            }
            request.setAttribute("address", address);
            request.setAttribute("list", list);
            request.setAttribute("user", acc);
            request.getRequestDispatcher("customer/order.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
