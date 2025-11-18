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
 */
public class SupplierDAO {
    //var
    private Connection conn;

    //constructor
    public SupplierDAO()
    {
        conn = DBConnection.getConnection();
    }
}
