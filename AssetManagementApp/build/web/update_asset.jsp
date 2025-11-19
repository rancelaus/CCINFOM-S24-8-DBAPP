<%-- 
    Document   : create_asset
    Created on : Nov 19, 2025, 2:03:00 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DAO.*"%>
<%@page import="java.sql.Date"%>


<%
    request.setCharacterEncoding("UTF-8");

    String method = request.getMethod();
    String message = "";
    AssetDAO dao = new AssetDAO();
    AssetDAO asset = null;

    if (method.equals("GET")) {
        try {
            int assetID = Integer.parseInt(request.getParameter("assetID"));
            asset = dao.getAssetById(assetID);
            if (asset == null) {
                message = "Asset not found.";
            }
        } catch (Exception e) {
            message = "Invalid asset ID.";
        }
    }

    if (method.equals("POST")) {
        int assetID = Integer.parseInt(request.getParameter("assetID"));
        String expiryRaw = request.getParameter("expiryDate");
        String purchaseRaw = request.getParameter("purchaseDate");
        String statusRaw = request.getParameter("a_status");

        Date expiry = (expiryRaw == null || expiryRaw.equals("")) ? null : Date.valueOf(expiryRaw);
        Date purchase = (purchaseRaw == null || purchaseRaw.equals("")) ? null : Date.valueOf(purchaseRaw);
        String status = (statusRaw == null || statusRaw.equals("")) ? null : statusRaw;

        boolean ok = dao.updateAssetOptional(assetID, expiry, purchase, status);

        if (ok) {
            message = "Asset updated successfully!";
        } else {
            message = "Update failed!";
        }

        asset = dao.getAssetById(assetID);
    }
%>

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
            width: 80%;
            max-width: 600px;
            margin: 100px auto;
            padding: 30px;
            background-color: #ffffff; 
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); 
            text-align: center;
        }

        /* 3. Title Styling */
        h1 {
            color: #1a73e8;
            font-size: 1.8em;
            margin-bottom: 30px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        
        /* 4. Subheader Styling */
        h2 {
            font-size: 1.3em; 
            font-weight: 500; 
            color: #000000; 
            margin-top: 20px;
            margin-bottom: 15px; 
        }

        /* 5. Link Styling */
        .menu a {
            display: block; 
            text-decoration: none;
            color: #333; 
            padding: 12px 0;
            margin: 5px 0;
            border-radius: 4px;
            transition: background-color 0.2s, color 0.2s; 
        }

        /* 6. Hover Effect */
        .menu a:hover {
            background-color: #e6f0ff; 
            color: #1a73e8; 
        }
    </style>
    
    </head>
    <div class="container">

<h2>Update Asset</h2>

<% if (!message.equals("")) { %>
    <p class="msg"><%= message %></p>
<% } %>

<% if (asset != null) { %>

<form method="post" action="update_asset.jsp">
    <input type="hidden" name="assetID" value="<%= asset.assetID %>">

    Expiry Date (optional):
    <input type="date" name="expiryDate" value="<%= asset.expiryDate %>">

    Purchase Date (optional):
    <input type="date" name="purchaseDate" value="<%= asset.purchaseDate %>">

    Status (optional):
    <select name="a_status">
        <option value="">-- Keep existing --</option>
        <option <%= asset.a_status.equals("active")?"selected":"" %>>active</option>
        <option <%= asset.a_status.equals("inactive")?"selected":"" %>>inactive</option>
        <option <%= asset.a_status.equals("expired")?"selected":"" %>>expired</option>
        <option <%= asset.a_status.equals("damaged")?"selected":"" %>>damaged</option>
        <option <%= asset.a_status.equals("lost")?"selected":"" %>>lost</option>
        <option <%= asset.a_status.equals("returned")?"selected":"" %>>returned</option>
    </select>

    <input type="submit" value="Save Changes">
</form>

<% } else { %>

<h3>No asset loaded.</h3>
<a href="updateAsset.html">Try Again</a>

<% } %>

<br><br>
<a href="index.html">🏠 Home</a>

</div>

</body>
</html>
