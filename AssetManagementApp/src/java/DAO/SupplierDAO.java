/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import Model.Supplier;
import Utilities.DBConnection;

/**
 *
 * @author Kimberly Chong
public class SupplierDAO {
    //var
    private Connection conn;

    //constructor
    public SupplierDAO()
    {
        try {
            conn = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
            conn = null;
        }
    }

    //methods

    /**
     * create a supplier record
     * @param supplier
     * @return
     */
    public boolean insertSupplier(Supplier supplier)
    {
        String sql = "INSERT INTO Supplier (companyName, firstName, lastName, contactNumber, email, zip, street, city) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try(PreparedStatement stm = conn.prepareStatement(sql)) 
        {
            stm.setString(1, supplier.getCompanyName());
            stm.setString(2, supplier.getFirstName());
            stm.setString(3, supplier.getLastName());
            stm.setString(4, supplier.getContactNumber());
            stm.setString(5, supplier.getEmail());
            stm.setString(6, supplier.getZIP());
            stm.setString(7, supplier.getStreet());
            stm.setString(8, supplier.getCity());

            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * read a supplier record by ID
     * @param supplierID
     * @return
     */
    public Supplier getSupplierByID(int supplierID)
    {
        String sql = "SELECT * FROM Supplier WHERE supplierID = ?";

        try(PreparedStatement stm = conn.prepareStatement(sql)) 
        {
            stm.setInt(1, supplierID);

            ResultSet rs = stm.executeQuery();

            if (rs.next())
            {
                Supplier supplier = new Supplier();

                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setCompanyName(rs.getString("companyName"));
                supplier.setFirstName(rs.getString("firstName"));
                supplier.setLastName(rs.getString("lastName"));
                supplier.setContactNumber(rs.getString("contactNumber"));
                supplier.setEmail(rs.getString("email"));
                supplier.setStreet(rs.getString("street"));
                supplier.setCity(rs.getString("city"));
                supplier.setZIP(rs.getString("zip"));

                return supplier;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * read all supplier records
     * @return
     */
    public ArrayList<Supplier> getAllSuppliers()
    {
        ArrayList<Supplier> list = new ArrayList<>();
        String sql = "SELECT * FROM Supplier";

        try(Statement stm = conn.createStatement()) 
        {
            ResultSet rs = stm.executeQuery(sql);

            while(rs.next())
            {
                Supplier supplier = new Supplier();

                supplier.setSupplierID(rs.getInt("supplierID"));
                supplier.setCompanyName(rs.getString("companyName"));
                supplier.setFirstName(rs.getString("firstName"));
                supplier.setLastName(rs.getString("lastName"));
                supplier.setContactNumber(rs.getString("contactNumber"));
                supplier.setEmail(rs.getString("email"));
                supplier.setStreet(rs.getString("street"));
                supplier.setCity(rs.getString("city"));
                supplier.setZIP(rs.getString("zip"));

                list.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public boolean updateSupplier(Supplier supplier)
    {
        String sql = "UPDATE Supplier SET companyName=?, contactPerson=?, contactNumber=?, email=?, street=?, city=?, zip=? WHERE supplierID=?";

        try (PreparedStatement stm = conn.prepareStatement(sql))
        {
            stm.setString(1, supplier.getCompanyName());
            stm.setString(2, supplier.getFirstName());
            stm.setString(3, supplier.getLastName());
            stm.setString(4, supplier.getContactNumber());
            stm.setString(5, supplier.getEmail());
            stm.setString(6, supplier.getZIP());
            stm.setString(7, supplier.getStreet());
            stm.setString(8, supplier.getCity());
            stm.setInt(9, supplier.getSupplierID());

            return stm.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
*/

// tinago ko muna cos it was giving build errors - rans :>