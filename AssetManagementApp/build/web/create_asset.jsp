<%-- 
    Document   : create_asset
    Created on : Nov 19, 2025, 2:03:00 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, DAO.*"%>
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
    <body>
        <%
            AssetDAO A = new AssetDAO();
            String expiryDate = request.getParameter("expiryDate");
            String purchaseDate = request.getParameter("purchaseDate");
            String assetType = request.getParameter("assetType");
            A.expiryDate = java.sql.Date.valueOf(expiryDate);
            A.purchaseDate = java.sql.Date.valueOf(purchaseDate);
            A.assetType = assetType.charAt(0);
            
            
            boolean status = A.create_asset();
            if(status){
        %>
                <h1>Creating Asset Successful!</h1>
        <%  } else{
        %>
                <h1>Creating Asset Failed!</h1>
        <%        }
        %>
    </body>
</html>
