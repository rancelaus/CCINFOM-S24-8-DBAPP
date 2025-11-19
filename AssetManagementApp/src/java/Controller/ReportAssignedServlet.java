/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

/**
 *
 * @author kheig
 */
import Utilities.DBConnection;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ReportAssignedServlet")
public class ReportAssignedServlet extends HttpServlet {

    private String esc(String s) {
        if (s == null) return "";
        return s.replace("&","&amp;").replace("<","&lt;").replace(">","&gt;")
                .replace("\"","&quot;").replace("'", "&#x27;");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String q = request.getParameter("q"); // optional filter
        response.setContentType("text/html; charset=UTF-8");

        String sqlBase =
            "SELECT a.assignmentID, a.assetID, ar.type AS assetType, ar.brand, ar.model," +
            " a.assignedBy, e.firstName, e.lastName, a.assignmentDate, a.as_status " +
            "FROM assigning a " +
            "LEFT JOIN asset ar ON a.assetID = ar.assetID " +
            "LEFT JOIN employee e ON a.assignedBy = e.employeeID ";

        String sql;
        boolean useFilter = (q != null && !q.trim().isEmpty());
        if (useFilter) {
            sql = sqlBase + "WHERE ar.type LIKE ? OR ar.brand LIKE ? OR ar.model LIKE ? ORDER BY a.assignmentDate DESC";
        } else {
            sql = sqlBase + "ORDER BY a.assignmentDate DESC";
        }

        try (PrintWriter out = response.getWriter();
             Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (useFilter) {
                String p = "%" + q.trim() + "%";
                ps.setString(1, p);
                ps.setString(2, p);
                ps.setString(3, p);
            }

            try (ResultSet rs = ps.executeQuery()) {

                out.println("<!doctype html><html><head><meta charset='utf-8'><title>Assigned Asset Report</title>");
                out.println("<style>");
                out.println("body{font-family:'Segoe UI',Tahoma,Arial,sans-serif;background:#f7f7f7;margin:0;padding:0;color:#333}");
                out.println(".container{width:90%;max-width:1000px;margin:40px auto;padding:20px;background:#fff;border-radius:8px;box-shadow:0 6px 20px rgba(0,0,0,0.06)}");
                out.println("h1{color:#1a73e8;text-align:center}");
                out.println("table{width:100%;border-collapse:collapse;margin-top:18px}");
                out.println("th,td{padding:10px;border-bottom:1px solid #eee;text-align:left}");
                out.println("th{background:#f4f7ff;color:#1a73e8}");
                out.println(".small{font-size:0.9em;color:#666}");
                out.println(".actions{margin-top:14px;text-align:center}");
                out.println("a.button{display:inline-block;padding:8px 14px;background:#1a73e8;color:#fff;border-radius:6px;text-decoration:none}");
                out.println("</style></head><body><div class='container'>");

                out.println("<h1>Assigned Asset Report</h1>");
                out.println("<p class='small'>Filter: " + esc(q) + "</p>");

                out.println("<table>");
                out.println("<thead><tr>");
                out.println("<th>Assignment ID</th>");
                out.println("<th>Asset ID</th>");
                out.println("<th>Asset (type / brand / model)</th>");
                out.println("<th>Assigned To (ID / name)</th>");
                out.println("<th>Assignment Date</th>");
                out.println("<th>Status</th>");
                out.println("</tr></thead>");
                out.println("<tbody>");

                boolean any = false;
                while (rs.next()) {
                    any = true;
                    String assignmentID = rs.getString("assignmentID");
                    String assetID = rs.getString("assetID");
                    String assetType = rs.getString("assetType");
                    String brand = rs.getString("brand");
                    String model = rs.getString("model");
                    String assignedBy = rs.getString("assignedBy");
                    String first = rs.getString("firstName");
                    String last = rs.getString("lastName");
                    String name = "";
                    if (first != null || last != null) name = (first==null?"":first) + " " + (last==null?"":last);
                    String date = rs.getString("assignmentDate");
                    String status = rs.getString("as_status");

                    out.println("<tr>");
                    out.println("<td>" + esc(assignmentID) + "</td>");
                    out.println("<td>" + esc(assetID) + "</td>");
                    out.println("<td>" + esc((assetType==null?"":assetType) + " / " + (brand==null?"":brand) + " / " + (model==null?"":model)) + "</td>");
                    out.println("<td>" + esc(assignedBy) + " / " + esc(name.trim()) + "</td>");
                    out.println("<td>" + esc(date) + "</td>");
                    out.println("<td>" + esc(status) + "</td>");
                    out.println("</tr>");
                }

                if (!any) {
                    out.println("<tr><td colspan='6' style='text-align:center;color:#666;padding:18px'>No records found.</td></tr>");
                }

                out.println("</tbody></table>");

                out.println("<div class='actions'>");
                out.println("<a class='button' href='report_assigned.html'>New Query</a>&nbsp;&nbsp;");
                out.println("<a class='button' href='reports.html'>Back to Reports</a>");
                out.println("</div>");

                out.println("</div></body></html>");
            }

        } catch (SQLException ex) {
            throw new ServletException("Report query failed", ex);
        }
    }
}
