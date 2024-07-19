/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CategoryDAO;
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

/**
 *
 * @author admin
 */
public class CategoryServlet extends HttpServlet {

    private CategoryDAO categoryDAO;
    

    @Override
    public void init() {
        categoryDAO = new CategoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "updateStatus":
                updateCategoryStatus(request, response);
                break;
            case "list":
            default:
                listCategory(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "manageCategory";
        }

        switch (action) {
            case "insert":
                insertCategory(request, response);
                break;
            case "update":
                updateCategory(request, response);
                break;
            default:
                listCategory(request, response);
                break;
        }
    }

    private void listCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Category> listCategory = categoryDAO.getCategoryManagerment();
        request.setAttribute("categoryList", listCategory);
        request.getRequestDispatcher("shop/manageCategory.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("shop/addCategory.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Category existingCategory = categoryDAO.getCategoryById(id);
        request.setAttribute("category", existingCategory);
        request.getRequestDispatcher("shop/editCategory.jsp").forward(request, response);
    }

    private void insertCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String name = request.getParameter("name");
        categoryDAO.addCategory(name);
        response.sendRedirect("CategoryServlet?action=manageCategory");
    }

    private void updateCategory(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        categoryDAO.updateCategory(id, name);
        response.sendRedirect("CategoryServlet?action=manageCategory");
    }

    private void updateCategoryStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        HttpSession session = request.getSession();
        int id = Integer.parseInt(request.getParameter("id"));
        int status = Integer.parseInt(request.getParameter("status"));
        categoryDAO.updateCategoryStatus(id,status);
        ArrayList<Category> cList =(ArrayList) categoryDAO.getAllCategory();
        session.setAttribute("cList", cList);
        request.getRequestDispatcher("CategoryServlet?action=manageCategory").forward(request, response);
    }
}