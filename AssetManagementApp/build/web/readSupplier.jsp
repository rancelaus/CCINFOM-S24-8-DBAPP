<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Read Records</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
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
        
        form {
            text-align: left;
            display: flex;
            flex-direction: column;
        }

        input[type="text"],
        input[type="email"],
        input[type="submit"] {
            margin-bottom: 10px;
            width: 590px; /* optional: controls input width */
        }
        
    </style>
</head>
<body>

    <div class="container">
        <h1>Existing Supplier Records</h1>
            
            <% if (request.getAttribute("message") != null) { %>
                <p style="color: green;"><%= request.getAttribute("message") %></p>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <p style="color: red;"><%= request.getAttribute("error") %></p>
            <% } %>

            <table border="1" cellpadding="6" cellspacing="0">
            <tr>
                <th>ID</th><th>Company</th><th>First</th><th>Last</th><th>Contact</th><th>Email</th><th>Street</th><th>City</th><th>ZIP</th>
            </tr>
            <%
                java.util.List suppliers = (java.util.List) request.getAttribute("suppliers");
                if (suppliers != null) {
                    for (Object o : suppliers) {
                        Model.Supplier s = (Model.Supplier) o;
            %>
            <tr>
                <td><%= s.getSupplierID() %></td>
                <td><%= s.getCompanyName() %></td>
                <td><%= s.getFirstName() %></td>
                <td><%= s.getLastName() %></td>
                <td><%= s.getContactNumber() %></td>
                <td><%= s.getEmail() %></td>
                <td><%= s.getStreet() %></td>
                <td><%= s.getCity() %></td>
                <td><%= s.getZIP() %></td>
            </tr>
            <%      }
                } else { %>
            <tr><td colspan="9">No suppliers found.</td></tr>
            <% } %>
            </table>
    </div>
</body>
</html>
