import Model.Supplier;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ReadSupplierServlet")
public class ReadSupplierServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
                                        throws ServletException, IOException
    {
        try {
            SupplierDAO dao = new SupplierDAO();
            List<Supplier> suppliers = dao.getAllSuppliers();
            request.setAttribute("suppliers", suppliers);
            request.getRequestDispatcher("listSuppliers.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("listSuppliers.jsp").forward(request, response);
        }
    }
}

