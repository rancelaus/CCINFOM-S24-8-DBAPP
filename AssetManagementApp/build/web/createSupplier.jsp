<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Create a New Record</title>
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
        <h1>Create Supplier Record</h1>
            <h2> Fill-Up Form </h2>
            
            <% if (request.getAttribute("message") != null) { %>
                <p style="color: green;"><%= request.getAttribute("message") %></p>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <p style="color: red;"><%= request.getAttribute("error") %></p>
            <% } %>

            <form action="CreateSupplierServlet" method="post">
                Company            <input type="text" name="companyName" required />
                Name                   <input type="text" name="firstName" placeholder="First Name" required />
                                            <input type="text" name="lastName" placeholder="Last Name" required />
                Contact Number <input type="text" name="contactNumber" required />
                Email                 <input type="email" name="email" required />
                Address              <input type="text" name="zip" placeholder="ZIP Code" required />
                                            <input type="text" name="street" placeholder="Street" required />
                                            <input type="text" name="city" placeholder="City" required />
                                            <br>
                <input type="Submit" value="Submit">
                </form>
            
                <% String msg = (String) request.getAttribute("message"); %>
                <% if (msg != null) { %>
                    <p style="color: green;"><%= msg %></p>
                <% } %>
                
                 <nav class="menu">
                    <a href="supplier.html">🔙 Back</a>
                    <a href="index.html">🏠 Main Menu</a>
        </nav>
    </div>
</body>
</html>
