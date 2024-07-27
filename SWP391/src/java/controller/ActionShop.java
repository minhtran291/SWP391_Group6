/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.DeliveryDAO;
import dal.FoodDAO;
import dal.OrderDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Food;
import java.sql.Date;
import model.Delivery;
import model.Order;
import model.OrderDetail;
import model.User;

@MultipartConfig(maxFileSize = 16177216)

/**
 *
 * @author Dell
 */
public class ActionShop extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "img";
    CategoryDAO cd = new CategoryDAO();
    FoodDAO fd = new FoodDAO();
    UserDAO ud = new UserDAO();
    DeliveryDAO dd = new DeliveryDAO();
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
                break;
            case "manageGetFoodByCategory":
                getFoodByCategory(request, response, 5);
                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
                break;
            case "manageGetFoodBySearch":
                getFoodBySearch(request, response, 5);
                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
                break;
            case "homeSort":
                getFoodBySort(request, response, 5);
                request.getRequestDispatcher("shop/shopHome.jsp").forward(request, response);
                break;
            case "manageSort":
                getFoodBySort(request, response, 5);
                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
                break;
            case "orderDivision":
                getOrderDivision(request, response, 5);
                request.getRequestDispatcher("shop/orderDivision.jsp").forward(request, response);
                break;
            case "dashBoard":
                getDashBoard(request, response);
                break;
            case "updateStatusConfirm":
                updateStatusConfirm(request, response);
                break;
            case "od":
                od(request, response);
                break;
            case "all-order":
                getAllOrder(request, response);
                break;
            case "order-detail":
                getOrderDetail(request, response);
                break;
            case "update-status":
                updateStatus(request, response);
                break;
            case "confirmOrder":
                confirmOrder(request, response, 5);
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
            case "chooseEmployee":
                chooseEmployee(request, response);
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
//        ArrayList<Food> fList = (ArrayList) session.getAttribute("fList") == null ? fd.getAllFood() : (ArrayList) session.getAttribute("fList");
//        ArrayList<Category> cList = (ArrayList) session.getAttribute("cList") == null ? cd.getAllCategory() : (ArrayList) session.getAttribute("cList");
        ArrayList<Food> fList = fd.getAllFoodManager();
        ArrayList<Category> cList = cd.getAllCategory();
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
        Part imageS = request.getPart("image");
        String image = null;
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        String fileName = Paths.get(imageS.getSubmittedFileName()).getFileName().toString();
        String filePath = uploadPath + File.separator + fileName;
        imageS.write(filePath);
        image = UPLOAD_DIRECTORY + "/" + fileName;

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
                fd.addFood(nameS, price, stock, cid, descriptionS, image);
//                ArrayList<Food> fList = fd.getAllFood();
//                session.setAttribute("fList", fList);
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
//        String imageS = request.getParameter("image");
//        String soldS = request.getParameter("sold");

        Part imageS = request.getPart("image");
        String image = request.getParameter("imageOld");

        if (imageS != null && imageS.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String fileName = Paths.get(imageS.getSubmittedFileName()).getFileName().toString();
            String filePath = uploadPath + File.separator + fileName;
            imageS.write(filePath);
            image = UPLOAD_DIRECTORY + "/" + fileName;
        }

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
//                int sold = Integer.parseInt(soldS);
                fd.updateFood(id, nameS, price, stock, cid, descriptionS, image);

//                ArrayList<Food> fList = fd.getAllFood();
//                session.setAttribute("fList", fList);
                getAllFood(request, response, numberPerPage);
                request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
            } catch (Exception e) {
            }
        }
    }

    private void deleteFood(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String idS = request.getParameter("deleteId");
        String foodDeleteS = request.getParameter("foodDelete");
        try {
            int id = Integer.parseInt(idS);
            int foodDelete = Integer.parseInt(foodDeleteS);
            fd.deleteFood(id, foodDelete);
//            ArrayList<Food> fList = fd.getAllFood();
//            session.setAttribute("fList", fList);
            getAllFood(request, response, numberPerPage);
            request.getRequestDispatcher("shop/manageFood.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }

    private void getFoodBySearch(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String search = request.getParameter("search");
        ArrayList<Food> listSearch = fd.getFoodBySearchManage(search);
        request.setAttribute("listSearch", listSearch);
        request.setAttribute("search", search);
        pagingForFood(request, response, numberPerPage, listSearch);
    }

    private void getFoodByCategory(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String categoryId = request.getParameter("cid");
        ArrayList<Food> listFoodByCategory = new ArrayList<>();
        if (categoryId.equalsIgnoreCase("all")) {
            listFoodByCategory = fd.getAllFoodManager();
        } else {
            listFoodByCategory = fd.getFoodByCategoryManage(categoryId);
        }
        request.setAttribute("listFoodByCategory", listFoodByCategory);
        request.setAttribute("cid", categoryId);
        pagingForFood(request, response, numberPerPage, listFoodByCategory);
    }

    private void getProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("acc");
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

    private void getFoodBySort(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        String type = request.getParameter("type");
        ArrayList<Food> listSort = fd.sortManage(type);
        request.setAttribute("listSort", listSort);
        request.setAttribute("type", type);
        pagingForFood(request, response, numberPerPage, listSort);
    }

    private void getOrderDivision(HttpServletRequest request, HttpServletResponse response, int i) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<Delivery> listDelivery = dd.getAllDelivery();
        ArrayList<User> listEmployee = dd.getOrderNumber();
        session.setAttribute("listEmployee", listEmployee);
        if (listDelivery.isEmpty()) {
            request.setAttribute("mess", "Chưa có đơn hàng cần giao");
        }
        pagingForOrderDivision(request, response, i, listDelivery);
        //request.setAttribute("listDelivery", listDelivery);
    }

    private void pagingForOrderDivision(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Delivery> listDelivery) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Delivery> deliveryOnCurrentPage = new ArrayList<>(listDelivery.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listDelivery.size())));

        int totalPages = (int) Math.ceil((double) listDelivery.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("deliveryOnCurrentPage", deliveryOnCurrentPage);
    }

    private void chooseEmployee(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("employee");
        String deliveryIdS = request.getParameter("deliveryID");
        String orderIdS = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdS);
        int deliveryID = Integer.parseInt(deliveryIdS);
        dd.addEmployeeToDelivery(name, deliveryID);
        od.updateStatus(3, orderId);
        getOrderDivision(request, response, 6);
        request.getRequestDispatcher("shop/orderDivision.jsp").forward(request, response);
    }

    private void getDashBoard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ArrayList<Order> listOrderConfirm = od.getOrderConfirm();
        ArrayList<Food> foodOutOfStock = fd.foodOutOfStock();
        int numberOrder = od.getNumberOrder();
        int numberFood = fd.getNumberFood();
        int numberUser = ud.getNumberCustomer();
        double profit = od.getTotalProfit();
        String yearS = request.getParameter("year");
        int year;
        if (yearS == null) {
            yearS = "2024";
        } 
        year = Integer.parseInt(yearS);
        List<Double> listTotalPrice = od.getTotalByMonth(year);
        request.setAttribute("foodOutOfStock", foodOutOfStock);
        request.setAttribute("listTotalPrice", listTotalPrice);
        request.setAttribute("numberOrder", numberOrder);
        request.setAttribute("numberFood", numberFood);
        request.setAttribute("numberUser", numberUser);
        request.setAttribute("profit", profit);
        request.setAttribute("listOrderConfirm", listOrderConfirm);
        request.getRequestDispatcher("shop/dashBoard.jsp").forward(request, response);
    }

    private void updateStatusConfirm(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //String statusS = request.getParameter("status");
        String orderIdS = request.getParameter("orderId");
        String shipperNotesS = request.getParameter("shopNotes");

        int orderId = Integer.parseInt(orderIdS);
        od.updateStatusConfirm(orderId, shipperNotesS);
//        getDashBoard(request, response);
        confirmOrder(request, response, 5);
    }

    private void od(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderIdS = request.getParameter("orderId");
        int orderId = Integer.parseInt(orderIdS);
        ArrayList<OrderDetail> orderDetail = od.getOD(orderId);
        pagingForOD(request, response, 5, orderDetail);
        Order order = od.getOrderByID(orderId);
        Delivery d = dd.getDeliveryByOrderId(orderId);
//            request.setAttribute("orderId", orderId);
        request.setAttribute("order", order);
        request.setAttribute("d", d);
        request.setAttribute("orderDetail", orderDetail);
        request.getRequestDispatcher("shop/od.jsp").forward(request, response);
    }

    private void pagingForOD(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<OrderDetail> listOD) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<OrderDetail> odOnCurrentPage = new ArrayList<>(listOD.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listOD.size())));

        int totalPages = (int) Math.ceil((double) listOD.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("odOnCurrentPage", odOnCurrentPage);
    }

    public void updateStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idS = request.getParameter("id");
        String shopNotes = request.getParameter("shopNotes");
//        OrderDAO od = new OrderDAO();
        int id = Integer.parseInt(idS);
        od.updateStatus(5, id, 2, shopNotes, 3);
        getAllOrder(request, response);
//        response.sendRedirect("actionshop?action=order-detail&id=" + id + "&ostatus=" + status);
    }

    private void getOrderDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String id = request.getParameter("id");
        UserDAO ud = new UserDAO();

        OrderDAO od = new OrderDAO();

        Order o = od.getOrderById(Integer.parseInt(id));
        User u = ud.getUserByName(o.getName());
        String address = od.getaddress(o.getId());

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
//            default:
//                throw new AssertionError();
        }
        ArrayList<OrderDetail> orderDetail = od.getOD(Integer.parseInt(id));
        request.setAttribute("orderDetail", orderDetail);
        pagingOrderDetail(request, response, 5, orderDetail);
        List<Food> list = od.GetOrderDetail(Integer.parseInt(id));
        request.setAttribute("address", address);
        request.setAttribute("list", list);
        request.setAttribute("order", o);
        request.setAttribute("phone", u.getPhone());
        request.getRequestDispatcher("/shop/order_detail.jsp").forward(request, response);
    }

    private void getAllOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        OrderDAO od = new OrderDAO();
        List<Order> list = od.getOrderAll();
        if (list.size() > 0) {
            for (Order o : list) {
                o.setAddress(od.getaddress(o.getId()));
                o.setDate(od.getDate(o.getId()));
            }
            request.setAttribute("list", list);
        } else {
            request.setAttribute("list", null);
        }
        pagingAllOrder(request, response, 10, list);

        request.getRequestDispatcher("/shop/order_manager.jsp").forward(request, response);
    }

    private void pagingAllOrder(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, List<Order> listAllOrder) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Order> allOrderOnCurrentPage = new ArrayList<>(listAllOrder.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listAllOrder.size())));

        int totalPages = (int) Math.ceil((double) listAllOrder.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("allOrderOnCurrentPage", allOrderOnCurrentPage);
    }

    private void pagingOrderDetail(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, List<OrderDetail> listOrderDetail) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<OrderDetail> orderDetailOnCurrentPage = new ArrayList<>(listOrderDetail.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listOrderDetail.size())));

        int totalPages = (int) Math.ceil((double) listOrderDetail.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("orderDetailOnCurrentPage", orderDetailOnCurrentPage);
    }

    private void confirmOrder(HttpServletRequest request, HttpServletResponse response, int numberPerPage) throws ServletException, IOException {
        ArrayList<Order> listOrderConfirm = od.getOrderConfirm();
        pagingConfirmOrder(request, response, numberPerPage, listOrderConfirm);
        request.getRequestDispatcher("shop/confirmOrderManage.jsp").forward(request, response);
    }

    private void pagingConfirmOrder(HttpServletRequest request, HttpServletResponse response,
            int numberPerPage, ArrayList<Order> listOrderConfirm) throws ServletException, IOException {
        if (listOrderConfirm == null) {
            return;
        }
        HttpSession session = request.getSession();
        int currentPage = 1;
        if (request.getParameter("page") != null) {
            currentPage = Integer.parseInt(request.getParameter("page"));
        }

        List<Order> orderConfirmOnCurrentPage = new ArrayList<>(listOrderConfirm.subList(
                (currentPage - 1) * numberPerPage,
                Math.min(currentPage * numberPerPage,
                        listOrderConfirm.size())));

        int totalPages = (int) Math.ceil((double) listOrderConfirm.size() / numberPerPage);

        session.setAttribute("currentPage", currentPage);
        session.setAttribute("totalPages", totalPages);
        session.setAttribute("orderConfirmOnCurrentPage", orderConfirmOnCurrentPage);
    }
}
