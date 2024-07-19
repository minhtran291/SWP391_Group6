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
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import model.Food;
import model.User;

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

        FoodDAO fd = new FoodDAO();
        Food f = fd.getFoodByID(id);

        String deleteP = null;

        String page = null;
        String detail = null;
        String minus = null;
        String plus = null;

        if (request.getParameter("minus") != null) {
            minus = request.getParameter("minus");
        }
        if (request.getParameter("plus") != null) {
            plus = request.getParameter("plus");
        }

        if (request.getParameter("page") != null) {
            page = request.getParameter("page");
        }

        if (request.getParameter("detail") != null) {
            detail = request.getParameter("detail");
        }

        HttpSession s = request.getSession();

        User u = (User) s.getAttribute("acc");

        if (u != null) {
            List<Food> list = (List<Food>) s.getAttribute("cart");

            if (list != null && list.size() > 0) {
                int index = -1;

                for (int i = 0; i < list.size(); i++) {
                    if (list.get(i).getFoodId() == f.getFoodId()) {
                        index = i;
                        break;
                    }
                }

                if (plus != null || minus != null) {
                    if (plus != null) {
                        int quantity = list.get(index).getQuantity() + 1;
                        f.setQuantity(quantity);
                        list.set(index, f);
                    } else {
                        int quantity = list.get(index).getQuantity() - 1;
                        if (quantity == 0) {
                            deleteP = id;
                        }
                        f.setQuantity(quantity);
                        list.set(index, f);
                    }
                } else {
                    if (index != -1) {
                        int quantity = list.get(index).getQuantity() + 1;
                        f.setQuantity(quantity);
                        list.set(index, f);
                    } else {
                        f.setQuantity(1);
                        list.add(f);
                    }
                }
                s.setAttribute("cart", list);
            } else {
                list = new ArrayList<>();
                f.setQuantity(1);
                list.add(f);
                s.setAttribute("cart", list);
            }

            if (page != null) {
                response.sendRedirect("actioncustomer?action=getListFood&page=" + page);

            } else if (deleteP != null && minus != null) {

                response.sendRedirect("delete-cart?id=" + deleteP);

            } else if (detail != null) {
                response.sendRedirect("detail?foodId=" + detail);
            } else if (minus != null || plus != null && deleteP == null) {
                response.sendRedirect("actioncustomer?action=cart");
            } else {
                response.sendRedirect("actioncustomer?action=getListFood");
            }
        }

//        if (request.getParameter("page") != null) {
//            page = request.getParameter("page");
//        }
//
//        if (request.getParameter("detail") != null) {
//            detail = request.getParameter("detail");
//        }
//
//        String minus = null;
//        String plus = null;
//
//        if (request.getParameter("minus") != null) {
//            minus = request.getParameter("minus");
//        }
//        if (request.getParameter("plus") != null) {
//            plus = request.getParameter("plus");
//        }
//        
//        
//        HttpSession s = request.getSession();
//        
//        User u = (User)s.getAttribute("acc");
//        
//        if(u != null){
//            CartDAO cd = new CartDAO();
//            Cart c = cd.getCart(u.getUserid());
//            String cart_detail = "";
//            if(c!= null){
//                boolean check = false;
//                cart_detail = c.getCart_detail();
//                
//                StringBuilder newCart = new StringBuilder();
//                String cart_arr[] = cart_detail.split("_");
//                for(String item : cart_arr){
//                    String item_arr[] = item.split(":");
//                    if(item_arr[0].compareTo(id) == 0 && minus == null && plus == null){
//                        item_arr[1] = Integer.parseInt(item_arr[1]) + 1 +"";
//                        check = true;
//                    }
//                    else if(item_arr[0].compareTo(id) == 0 && minus != null ){
//                        item_arr[1] = Integer.parseInt(item_arr[1]) - 1 +"";
//                        if(Integer.parseInt(item_arr[1]) == 0){
//                            deleteP = item_arr[0];
//                        }
//                        check = true;
//                    }
//                    else if(item_arr[0].compareTo(id) == 0 && plus != null){
//                        item_arr[1] = Integer.parseInt(item_arr[1]) + 1 +"";
//                        check = true;
//                    }
//                   String newItem = item_arr[0] +":"+item_arr[1];
//                   newCart.append(newItem).append("_");
//                   
//                }
//                if(!check){
//                    newCart.append(id).append(":1");
//                }
//                cart_detail = newCart.toString();
//                if(cart_detail.endsWith("_")){
//                    cart_detail = cart_detail.substring(0, cart_detail.length() -1);
//                }
//            
//                cd.update(u.getUserid(), cart_detail);
//            }
//            else{
//                cart_detail = id+":1";
//                cd.insert(u.getUserid(), cart_detail);
//            }
//          
//            if(page != null){
//                response.sendRedirect("actioncustomer?action=getListFood&page="+page);
//                
//            }
//             else if(deleteP != null && minus != null){
//               
//                response.sendRedirect("delete-cart?id="+deleteP);
//                        
//            }
//            else if(detail != null){
//                response.sendRedirect("detail?foodId="+detail);
//            }
//            else if(minus != null || plus != null && deleteP == null){
//                 response.sendRedirect("actioncustomer?action=cart");
//            }
//            
//           
//            else{
//                response.sendRedirect("actioncustomer?action=getListFood");
//            }
//        }
//       
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
