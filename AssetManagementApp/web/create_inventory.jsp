<%-- 
    Document   : create_inventory
    Created on : Nov 19, 2025, 2:14:37 PM
    Author     : ranseeeee
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DAO.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Inventory</title>
    </head>
    <body>
        <jsp:useBean id="A" class="DAO.Inventory" scope="session"/>
        <% // Receive the values
            String v_itemName = request.getParameter("itemName");
            String v_itemType = request.getParameter("itemType");
            String v_unit = request.getParameter("unit");
            int v_stockQty = Integer.parseInt(request.getParameter("stockQty"));
            int v_reorderLevel = Integer.parseInt(request.getParameter("reorderLevel"));
            
            A.itemName = v_itemName;
            A.itemType = v_itemType;
            A.unit = v_unit;
            A.stockQty = v_stockQty;
            A.reorderLevel = v_reorderLevel;
            
            int status = A.createInventory();
            
            if (status == 1) {
        %>
        <h1>Create Inventory Successful</h1>
        <%
            } else {
        %>
        <h1>Create Inventory Failed</h1>
        <%
            }
        %>
    </body>
</html>
