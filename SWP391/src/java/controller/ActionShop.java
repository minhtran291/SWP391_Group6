/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.FoodDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Food;
import java.sql.Date;
import model.User;

/**
 *
 * @author Dell
 */
public class ActionShop extends HttpServlet {

    CategoryDAO cd = new CategoryDAO();
    FoodDAO fd = new FoodDAO();
    UserDAO ud = new UserDAO();

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
            out.println("<title>Servlet ActionShop</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ActionShop at " + request.getContextPath() + "</h1>");
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
        String action = request.getParameter("action");
        switch (action) {
            case "homeFood":
                getAllFood(request, response, 8);
                request.getRequestDispatcher("shop/shopHome.jsp").forward(request, response);
                break;
            case "manageFood":
                getAllFood(request, response, 5);
                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
                break;
            case "deleteFood":
                deleteFood(request, response, 5);
//                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
                break;
            case "getFoodBySearch":
                getFoodBySearch(request, response, 5);
                request.getRequestDispatcher("shop/shopHome.jsp").forward(request, response);
                break;
            case "getFoodByCategory":
                getFoodByCategory(request, response, 5);
                request.getRequestDispatcher("shop/shopHome.jsp").forward(request, response);
                break;
            case "profile":
                getProfile(request, response);
                break;
            case "changepass":
                changePassJSP(request, response);
                
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
        String action = request.getParameter("action");
        switch (action) {
            case "addFood":
                addFood(request, response, 5);
                break;
            case "updateFood":
                updateFood(request, response, 5);
                break;
            case "changepass":
                changePass(request, response);
                break;
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

    private void getAllFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<Food> fList = (ArrayList) session.getAttribute("fList") == null ? fd.getAllFood() : (ArrayList) session.getAttribute("fList");
        ArrayList<Category> cList = (ArrayList) session.getAttribute("cList") == null ? cd.getAllCategory() : (ArrayList) session.getAttribute("cList");
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
        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("foodOnCurrentPage", foodOnCurrentPage);
    }

    private void addFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String errorName = "";
        String errorPrice = "";
        String errorStock = "";

        String nameS = request.getParameter("name");
        String priceS = request.getParameter("price");
        String stockS = request.getParameter("stock");
        String cidS = request.getParameter("cid");
        String descriptionS = request.getParameter("description");
        String imageS = request.getParameter("image");

        if (!fd.checkFoodName(nameS)) {
            errorName = "Tên món ăn đã có rồi";
            request.setAttribute("errorName", errorName);
        }
        if (priceS.equalsIgnoreCase("0")) {
            errorPrice = "Giá món ăn phải khác 0";
            request.setAttribute("errorPrice", errorPrice);
        }
        if (stockS.equalsIgnoreCase("0")) {
            errorStock = "Số lượng tồn kho phải khác 0";
            request.setAttribute("errorStock", errorStock);
        }
        if (!errorName.isEmpty() || !errorPrice.isEmpty() || !errorStock.isEmpty()) {
            request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
        } else {
            try {
                int price = Integer.parseInt(priceS);
                int stock = Integer.parseInt(stockS);
                int cid = Integer.parseInt(cidS);
                fd.addFood(nameS, price, stock, cid, descriptionS, imageS);
                ArrayList<Food> fList = fd.getAllFood();
                session.setAttribute("fList", fList);
                getAllFood(request, response, numberPerPage);
                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
            } catch (Exception e) {
            }
        }
    }

    private void updateFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String errorNameUpdate = "";
        String errorPriceUpdate = "";
        String errorStockUpdate = "";

        String idS = request.getParameter("id");
        String nameS = request.getParameter("name");
        String priceS = request.getParameter("price");
        String stockS = request.getParameter("stock");
        String cidS = request.getParameter("cidUpdate");
        String descriptionS = request.getParameter("description");
        String imageS = request.getParameter("image");
        String soldS = request.getParameter("sold");

        if (!fd.checkFoodName(nameS, idS)) {
            errorNameUpdate = "Tên món ăn đã có rồi";
            request.setAttribute("errorNameUpdate", errorNameUpdate);
        }
        if (priceS.equalsIgnoreCase("0")) {
            errorPriceUpdate = "Giá món ăn phải khác 0";
            request.setAttribute("errorPriceUpdate", errorPriceUpdate);
        }
        if (stockS.equalsIgnoreCase("0")) {
            errorStockUpdate = "Số lượng tồn kho phải khác 0";
            request.setAttribute("errorStockUpdate", errorStockUpdate);
        }
        if (!errorNameUpdate.isEmpty() || !errorPriceUpdate.isEmpty() || !errorStockUpdate.isEmpty()) {
            request.setAttribute("id", idS);
            request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
        } else {

            try {
                int id = Integer.parseInt(idS);
                int price = Integer.parseInt(priceS);
                int stock = Integer.parseInt(stockS);
                int cid = Integer.parseInt(cidS);
                int sold = Integer.parseInt(soldS);
                fd.updateFood(id, nameS, price, stock, cid, descriptionS, imageS, sold);

                ArrayList<Food> fList = fd.getAllFood();
                session.setAttribute("fList", fList);
                getAllFood(request, response, numberPerPage);
                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
            } catch (Exception e) {
            }
        }
    }

    private void deleteFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String idS = request.getParameter("deleteId");
        try {
            int id = Integer.parseInt(idS);
            fd.deleteFood(id);
            ArrayList<Food> fList = fd.getAllFood();
            session.setAttribute("fList", fList);
            getAllFood(request, response, numberPerPage);
            request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
        } catch (Exception e) {
        }

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

    private void getProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User)session.getAttribute("acc");
        session.setAttribute("acc", u);
        request.getRequestDispatcher("shop/profileShop.jsp").forward(request, response);
    }

    private void changePassJSP(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
        session.setAttribute("acc", u);
        request.getRequestDispatcher("/shop/changepass.jsp").forward(request, response);
    }

    private void changePass(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");

        if (!currentPassword.equals(u.getPassword())) {
            request.setAttribute("message", "Mật khẩu cũ không chính xác");
            request.getRequestDispatcher("/shop/changepass.jsp").forward(request, response);

        } else if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("message", "Mật khẩu mới và xác nhận mật khẩu không khớp");
            request.getRequestDispatcher("/shop/changepass.jsp").forward(request, response);

        } else {
            ud.updatePassword(u, newPassword);
            request.getRequestDispatcher("/shop/profileShop.jsp").forward(request, response);

        }
    }
}
