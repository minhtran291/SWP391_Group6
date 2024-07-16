/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FoodDAO;
import dal.OrderDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Food;
import model.User;

/**
 *
 * @author hieua
 */
public class order extends HttpServlet {

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
            out.println("<title>Servlet order</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet order at " + request.getContextPath() + "</h1>");
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

        User acc = (User) session.getAttribute("acc");

        if (acc == null) {
            response.sendRedirect("login");
        } else {
            double total = (double) session.getAttribute("total_s");

            if (total != 0) {
                List<Food> list = (List<Food>) session.getAttribute("cart");
                request.setAttribute("list", list);
                request.setAttribute("user", acc);

                request.getRequestDispatcher("customer/order.jsp").forward(request, response);

            } else {
                request.setAttribute("err", "Bạn ko có sản phẩm đẻ thanh toán");
                request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
            }
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

        HttpSession session = request.getSession();
        User acc = (User) session.getAttribute("acc");
        List<Food> list = (List<Food>) session.getAttribute("cart");
        if (acc != null) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String district = request.getParameter("district");
            address = (district + ", " + address);
            if (name == "") {
                request.setAttribute("err", "Vui lòng nhập tên khách hàng");
            } else if (email == "") {
                request.setAttribute("err", "Vui lòng nhập email");
            } else if (phone == "") {
                request.setAttribute("err", "Vui lòng nhập số điện thoại");
            } else if (address == "") {
                request.setAttribute("err", "Vui lòng nhập địa chỉ");
            } else {
                if (phone.length() != 10) {
                    request.setAttribute("err", "Số điện thoại không hợp lệ");
                } else {
                    try {
                        if (list == null) {
                            request.setAttribute("err", "Bạn ko có sản phẩm đẻ thanh toán");
                            request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
                        } else {
                            String req = request.getParameter("payment");
                            if (req != null) {
                                if (req.equals("0")) {
                                    double total = (double) session.getAttribute("total_s");
                                    OrderDAO od = new OrderDAO();
                                    boolean check = od.insert(total, acc.getUsername());
                                    if (check) {
                                        int id = od.getLast();
                                        for (Food f : list) {
                                            od.insert_detail(id, f);
                                        }
                                        request.setAttribute("count_cart", 0);
                                        od.insertDelivery(id, address);
                                        session.removeAttribute("cart");
                                        request.setAttribute("success", "Đơn hàng đã được order");
                                    }
                                } else {
                                    session.setAttribute("address", address);
                                    Long total = total = (long) Double.parseDouble(session.getAttribute("total_s").toString());
                                    response.sendRedirect("vnpay?amount=" + total);
                                    return;
                                }
                            } else {
                                request.setAttribute("err", "Hãy chọn phương thức thanh toán.");
                                request.getRequestDispatcher("customer/cart.jsp").forward(request, response);
                            }
                        }
                    } catch (Exception e) {
                        System.out.println("Add : " + e);
                        request.setAttribute("err", "Số điện thoại không hợp lệ");
                    }
                }
            }
            request.setAttribute("list", list);
            request.setAttribute("user", acc);
            request.setAttribute("address", address);
            request.getRequestDispatcher("customer/order.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }

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
