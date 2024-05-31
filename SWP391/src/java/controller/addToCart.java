/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.FoodDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Food;

/**
 *
 * @author hieua
 */
public class addToCart extends HttpServlet {

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
            out.println("<title>Servlet addToCart</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addToCart at " + request.getContextPath() + "</h1>");
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
        String id = request.getParameter("id");
        String page = null;
        String detail = null;
        FoodDAO fd = new FoodDAO();
        Food f = fd.getFoodByID(id);
        if (request.getParameter("page") != null) {
            page = request.getParameter("page");
        }

        if (request.getParameter("detail") != null) {
            detail = request.getParameter("detail");
        }

        String minus = null;
        String plus = null;

        if (request.getParameter("minus") != null) {
            minus = request.getParameter("minus");
        }
        if (request.getParameter("plus") != null) {
            plus = request.getParameter("plus");
        }

        Cookie c[] = request.getCookies();
        boolean check = false;
        Cookie cart = null;
        for (Cookie e : c) {
            if (e.getName().compareTo("cart") == 0) {
                cart = e;
            }
        }

        String deleteP = null;
        int count = 0;

        if (cart != null) {
            String cart_arr[] = cart.getValue().split("_");

            StringBuilder new_cart = new StringBuilder();
            for (String p : cart_arr) {   // 2:1 , 3:1
                if (!p.isBlank()) {
                    

                    String num[] = p.split(":");
                    if (id.compareTo(num[0]) == 0) {
                        int quantity = Integer.parseInt(num[1]);

                        if (minus != null || plus != null) {
                            if (minus != null && plus == null) {
                                quantity--;

                            } else if (minus == null && plus != null) {
                                quantity++;

                            }

                            if (quantity == 0) {
                                deleteP = num[0];
                            }
                        } else {
                            quantity += 1;
                        }
                        if (quantity >= f.getStock()) {
                            quantity = f.getStock();
                        }

                        String newValue = id + ":" + quantity;
                        p = newValue;
                        check = true;
                    }

                    new_cart.append(p).append("_");
                    count++;
                }
            }

            if (!check) {
                new_cart.append(id).append(":1");
                count++;
            }

            cart.setValue(new_cart.toString());
            response.addCookie(cart);
        } else {
            Cookie new_cart = new Cookie("cart", id + ":1");
            new_cart.setMaxAge(3600);
            response.addCookie(new_cart);

        }
        
        HttpSession s = request.getSession();
        s.setAttribute("countfood", count);
        System.out.println("count"+count);
        if (deleteP != null) {
            response.sendRedirect("delete-cart?id=" + deleteP);
        } else if (minus != null || plus != null && deleteP == null) {
            response.sendRedirect("actioncustomer?action=cart");
        } else if (detail != null) {
            request.getRequestDispatcher("detail?foodId=" + detail).forward(request, response);
        } else {
            request.getRequestDispatcher("actioncustomer?action=getListFood&page=" + page).forward(request, response);
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
