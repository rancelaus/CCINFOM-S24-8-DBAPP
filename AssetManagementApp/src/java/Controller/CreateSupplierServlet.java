import Model.Supplier;
import java.io.IOException;
import java.util.regex.Pattern;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CreateSupplierServlet")
public class CreateSupplierServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
                                        throws ServletException, IOException
    {
        String companyName = request.getParameter("companyName");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String zip = request.getParameter("zip");
        String street = request.getParameter("street");
        String city = request.getParameter("city");

        //from regex
        Pattern emailPat = Pattern.compile("^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"); //name@ext.ext
        Pattern zipPat   = Pattern.compile("^\\d{4}$");           // 4 digits
        Pattern phonePat = Pattern.compile("^\\d{11}$");      // 11 digit num 09--

        StringBuilder errors = new StringBuilder();

        if (companyName == null || companyName.trim().isEmpty()) {
            errors.append("Company name is required. ");
        }
        if (!emailPat.matcher(email == null ? "" : email.trim()).matches()) {
            errors.append("Invalid email. ");
        }
        if (!zipPat.matcher(zip == null ? "" : zip.trim()).matches()) {
            errors.append("Invalid ZIP code. ");
        }
        if (!phonePat.matcher(contactNumber == null ? "" : contactNumber.trim()).matches()) {
            errors.append("Invalid contact number. ");
        }

        // preserve values so JSP can re-populate the form
        if (errors.length() > 0) {
            request.setAttribute("error", errors.toString());
            request.setAttribute("companyName", companyName);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("contactNumber", contactNumber);
            request.setAttribute("email", email);
            request.setAttribute("zip", zip);
            request.setAttribute("street", street);
            request.setAttribute("city", city);

            request.getRequestDispatcher("createSupplier.jsp").forward(request, response);
            return;
        }
        
        try {
            Supplier supplier = new Supplier(companyName, firstName, lastName, contactNumber, email, street, city, zip);
            SupplierDAO dao = new SupplierDAO();
            boolean success = dao.createSupplier(supplier);

            if (success) {
                request.setAttribute("message", "Supplier added successfully!");
            } else {
                request.setAttribute("error", "Failed to create supplier. Check your input or try again.");
            }
            request.getRequestDispatcher("createSupplier.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("createSupplier.jsp").forward(request, response);
        }
    }
}

