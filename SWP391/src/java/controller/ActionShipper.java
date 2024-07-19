/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.User;

/**
 *
 * @author Dell
 */
public class ActionShipper extends HttpServlet {

    OrderDAO od = new OrderDAO();
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
            out.println("<title>Servlet ActionShipper</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActionShipper at " + request.getContextPath() + "</h1>");
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
//        processRequest(request, response);
        String action = request.getParameter("action");
        switch (action) {
            case "homeShipper":
                getHomeShipper(request, response);
                break;
            case "updateStatus":
                updateStatus(request, response);
                break;
            case "deliveryDetail":
                getDeliveryDetail(request, response);
                break;
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

    private void getHomeShipper(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        ArrayList<Order> listDelivery = od.getDeliveryByUserName(u.getUsername());
        pagingDeliveryShipper(request, response, 5, listDelivery);
        session.setAttribute("listDelivery", listDelivery);
        request.getRequestDispatcher("shipper/homeShipper.jsp").forward(request, response);
    }

    private void updateStatus(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String statusS = request.getParameter("status");
        String orderIdS = request.getParameter("orderId");
        String shipperNotesS = request.getParameter("shipperNotes");

        int orderId = Integer.parseInt(orderIdS);
        if (statusS.equalsIgnoreCase("done")) {
            od.updateStatus(4, 2, orderId, shipperNotesS);
            od.updateDeliveryDate(orderId);
        }
        if (statusS.equalsIgnoreCase("break")) {
            od.updateStatus(5, 3, orderId, shipperNotesS);
            od.updateDeliveryDate(orderId);
        }
        getHomeShipper(request, response);
    }

    private void pagingDeliveryShipper(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Order> listOrder) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Order> deliveryShipperOnCurrentPage = new ArrayList<>(listOrder.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listOrder.size())));

        int totalPages = (int) Math.ceil((double) listOrder.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("deliveryShipperOnCurrentPage", deliveryShipperOnCurrentPage);
    }

    private void getDeliveryDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdS = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdS);
        ArrayList<OrderDetail> orderDetail = od.getOD(orderId);
        pagingForDeliveryDetail(request, response, 5, orderDetail);
        Order order = od.getOrderByID(orderId);
        request.setAttribute("order", order);
        request.getRequestDispatcher("shipper/DeliveryDetail.jsp").forward(request, response);
    }

    private void pagingForDeliveryDetail(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<OrderDetail> listDeliveryDetail) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<OrderDetail> deliveryDetailOnCurrentPage = new ArrayList<>(listDeliveryDetail.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listDeliveryDetail.size())));

        int totalPages = (int) Math.ceil((double) listDeliveryDetail.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("deliveryDetailOnCurrentPage", deliveryDetailOnCurrentPage);
    }
    
}
