/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.CommentDAO;
import dal.DiscountDAO;
import dal.FoodDAO;
import dal.OrderDAO;
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
import model.Category;
import model.Comment;
import model.Food;
import model.User;
import model.Cart;
import model.Discount;
import model.Order;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 *
 * @author Dell
 */
public class ActionCustomer extends HttpServlet {

    CategoryDAO cd = new CategoryDAO();
    FoodDAO fd = new FoodDAO();
    CommentDAO cmtd = new CommentDAO();
    DiscountDAO dd = new DiscountDAO();

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
            out.println("<title>Servlet ActionCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActionCustomer at " + request.getContextPath() + "</h1>");
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

        User u = (User) session.getAttribute("acc");
        if (u != null) {
            List<Food> list = (List<Food>) session.getAttribute("cart");
            if (list != null) {
                session.setAttribute("count_cart", list.size());
            } else {
                session.setAttribute("count_cart", 0);
            }
        } else {
            session.setAttribute("count_cart", 0);
        }
        String action = request.getParameter("action");
        switch (action) {
            case "getListFood":
                getAllFood(request, response, 8);
                break;
            case "getFoodBySearch":
                getFoodBySearch(request, response, 5);
                break;
            case "getFoodByCategory":
                getFoodByCategory(request, response, 5);
                break;
            case "cart":
                goToCart(request, response);
                break;
            case "history":
                goToHistory(request, response);
                break;
            case "history_detail":
                history_detail(request, response);
                break;
            case "remove-order":
                removeOrder(request, response);
                break;
            case "homeSort":
                getFoodBySort(request, response, 8);
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

    private void removeOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String customerNotes = request.getParameter("customerNotes");
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u != null) {
            OrderDAO od = new OrderDAO();
//            List<Order> list = od.getOrder(u.getUsername());
            Order o = od.getOrderById(Integer.parseInt(id));
            od.updateStatus(5, o.getId(), 1, customerNotes, 3);
//            response.sendRedirect("actioncustomer?action=history");
            goToHistory(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    private void goToHistory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u != null) {
            OrderDAO od = new OrderDAO();
            List<Order> list = od.getOrder(u.getUsername());

            if (list.size() == 0) {
                request.setAttribute("list", null);
            } else {
                for (Order o : list) {
                    o.setAddress(od.getaddress(o.getId()));
                    o.setDate(od.getDate(o.getId()));
                    switch (o.getStatus()) {
                        case 1:
                            o.setStatus_text("Chưa xử lý");
                            break;
                        case 2:
                            o.setStatus_text("Đang xử lý");
                            break;
                        case 3:
                            o.setStatus_text("Đang giao");
                            break;
                        case 4:
                            o.setStatus_text("Đã giao");
                            break;
                        case 5:
                            o.setStatus_text("Đã hủy");
                            break;
//                        default:
//                            throw new AssertionError();
                    }
                }
                request.setAttribute("list", list);
            }
            pagingForHitory(request, response, 10, list);
            request.getRequestDispatcher("/customer/history.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    private void history_detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        if (u != null) {
            String id = request.getParameter("id");
            OrderDAO od = new OrderDAO();
            List<Food> list = od.GetOrderDetail(Integer.parseInt(id));
            Order o = od.getOrderById(Integer.parseInt(id));
            o.setDate(od.getDate(o.getId()));
            String address = od.getaddress(o.getId());
            switch (o.getStatus()) {
                case 1:
                    o.setStatus_text("Chưa xử lý");
                    break;
                case 2:
                    o.setStatus_text("Đơn hàng đã được đặt thành công");
                    break;
                case 3:
                    o.setStatus_text("Đơn hàng đang được giao");
                    break;
                case 4:
                    o.setStatus_text("Giao hàng thành công");
                    break;
                case 5:
                    o.setStatus_text("Đã hủy đơn hàng");
                    break;
//                default:
//                    throw new AssertionError();
            }
            request.setAttribute("address", address);
            request.setAttribute("user", u);
            request.setAttribute("list", list);
            request.setAttribute("order", o);
            pagingForHitoryDetail(request, response, 5, list);
            request.getRequestDispatcher("/customer/historyDetail.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    private void goToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        double total = 0;
        User u = (User) session.getAttribute("acc");
        if (u != null) {
            List<Food> list = (List<Food>) session.getAttribute("cart");
            if (list != null) {
                System.out.println(list.size());
                if (list.size() == 0) {
                    request.setAttribute("cart", null);
                    System.out.println("co");
                } else {
                    request.setAttribute("cart", list);
                    for (Food f : list) {
                        total += f.getPrice();
                    }
                }

            } else {
                request.setAttribute("cart", null);
            }

        } else {
            request.setAttribute("cart", null);
        }

        session.setAttribute("total_s", total);
        request.getRequestDispatcher("/customer/cart.jsp").forward(request, response);
    }

    private void getAllFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<Food> fList = (ArrayList) session.getAttribute("fList") == null ? fd.getAllFood() : (ArrayList) session.getAttribute("fList");
        ArrayList<Category> cList = (ArrayList) session.getAttribute("cList") == null ? cd.getAllCategory() : (ArrayList) session.getAttribute("cList");
        // ko phan phai lan dau tien chay ko can get all nua chi goi du lieu ve
        session.setAttribute("fList", fList);
        session.setAttribute("cList", cList);
        /* bat buoc phai set cac thuoc tinh ben tren theo dung thu tu va dat cai
            phan trang o cuoi vi khi vao phan trang se chuyen sang trang luon
         */
        pagingForFood(request, response, numberPerPage, fList);
        // lan dau tien chay trang web thi su dung get all de lay du lieu
    }

    private void pagingForFood(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Food> listFood) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }
        // lay trang hien tai

        // ko the ep kieu thanh arrayList tu list su dung phuong thuc subList
        // 
        List<Food> foodOnCurrentPage = new ArrayList<>(listFood.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listFood.size())));
        // lay san pham tren trang hien tai

        int totalPages = (int) Math.ceil((double) listFood.size() / numberPerPage);
        /* Math.ceil ko ap dung cho cho kieu int phai ep kieu sang double
         Math.ceil lam tron nen xong lai ep kieu ve int, trang ko le
        
         san pham dau tien tren trang hien tai = (trang hien tai - 1) * so san
        pham tren 1 trang
        san pham cuoi cung tren trang hien tai = (trang hien tai * so luong san
        pham tren 1 trang) - 1

        vi du trang 2, san pham dau tien trang 2 = (2 - 1) * 6 = 6
        doi tuong o chi muc thu 6 trong arrayList vi arrayList chay tu 0
        san pham cuoi trang 2 = 2 * 6 - 1 = 11
        doi tuong o chi muc thu 11 
        san pham cuoi o trang cuoi cung arrayList.size() - 1
        
        
         */

        Cookie c[] = request.getCookies();
        Cookie cart = null;
        int count = 0;

        for (Cookie e : c) {
            if (e.getName().compareTo("cart") == 0) {
                cart = e;
            }
        }

        if (cart != null) {
            String s[] = cart.getValue().split("_");
            for (String f : s) {
                if (!f.isBlank()) {
                    count++;
                }
            }
        }

        session.setAttribute("countfood", count);
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("foodOnCurrentPage", foodOnCurrentPage);
        request.setAttribute("page", currentPage);
        request.getRequestDispatcher("/customer/home.jsp").forward(request, response);

    }

    private void getFoodBySearch(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String search = request.getParameter("search");
        ArrayList<Food> listSearch = fd.getFoodBySearch(search);
        request.setAttribute("listSearch", listSearch);
        request.setAttribute("search", search);
        pagingForFood(request, response, numberPerPage, listSearch);
    }

    private void getFoodByCategory(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String categoryId = request.getParameter("cid");
        ArrayList<Food> listFoodByCategory = fd.getFoodByCategory(categoryId);
        request.setAttribute("listFoodByCategory", listFoodByCategory);
        request.setAttribute("cid", categoryId);
        pagingForFood(request, response, numberPerPage, listFoodByCategory);
    }

    private void getFoodBySort(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String type = request.getParameter("type");
        ArrayList<Food> listSort = fd.sort(type);
        request.setAttribute("listSort", listSort);
        request.setAttribute("type", type);
        pagingForFood(request, response, numberPerPage, listSort);
    }

    private void pagingForHitoryDetail(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, List<Food> listHitoryDetail) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Food> hitoryDetailOnCurrentPage = new ArrayList<>(listHitoryDetail.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listHitoryDetail.size())));

        int totalPages = (int) Math.ceil((double) listHitoryDetail.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("hitoryDetailOnCurrentPage", hitoryDetailOnCurrentPage);
    }

    private void pagingForHitory(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, List<Order> listHitory) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Order> hitoryOnCurrentPage = new ArrayList<>(listHitory.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listHitory.size())));

        int totalPages = (int) Math.ceil((double) listHitory.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("hitoryOnCurrentPage", hitoryOnCurrentPage);
    }
}
