<%-- 
    Document   : create_asset
    Created on : Nov 19, 2025, 2:03:00 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DAO.AssetDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Creating Asset Record Processing</title>
        
        <style>
        /* 1. Global Styling & Font */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
            color: #333;
        }

        /* 2. Main Container Styling */
        .container {
            width: 95%;
            max-width: 900px;
            margin: auto;
            background: #fff;
            padding: 20px;
            background-color: #ffffff; 
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); 
        }

        /* 3. Title Styling */
        h1 {
            color: #1a73e8;
            font-size: 1.8em;
            margin-bottom: 30px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        
        table{
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background: #e6f0ff;
            color: #1a73e8;
        }

        a {
            display: inline-block;
            padding: 10px 15px;
            background: #1a73e8;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            margin-right: 10px;
        }
    </style>
    
    </head>
    <body>

        <h1>All Asset Records</h1>

    <%
        AssetDAO dao = new AssetDAO();
        List<AssetDAO> assets = dao.read_asset();
    %>
    <%= "Records loaded: " + assets.size() %>
    <table>
        <tr>
            <th>Asset ID</th>
            <th>Expiry Date</th>
            <th>Purchase Date</th>
            <th>Status</th>
            <th>Type</th>
        </tr>

    <% 
        if (assets == null || assets.isEmpty()) {
        %>
            <tr>
                <td colspan="5">No records found.</td>
            </tr>
        <% 
        } else {
            for (AssetDAO a : assets) { 
        %>
    <tr>
        <td><%= a.assetID %></td>
        <td><%= a.expiryDate %></td>
        <td><%= a.purchaseDate %></td>
        <td><%= a.a_status %></td>
        <td><%= a.assetType %></td>
    </tr>
    <% } %>

    </table>
    <a href="index.html">🏠 Back to Main Menu</a>

</body>
</html>
