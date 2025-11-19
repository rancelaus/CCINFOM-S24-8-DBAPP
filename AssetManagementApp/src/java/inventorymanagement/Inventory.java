/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package inventorymanagement;
import java.util.*;
import java.sql.*;

/**
 *
 * @author Rance Laus
 */
public class Inventory {
    // Attributes
    public int itemID;
    public String itemName;
    public String itemType;
    public String unit;
    public int stockQty;
    public int reoderLevel;
    public String i_status;
    
    // Array Lists
    public ArrayList<Integer> itemIDlist = new ArrayList<>();
    public ArrayList<String> itemNamelist = new ArrayList<>();
    public ArrayList<String> itemTypelist = new ArrayList<>();
    public ArrayList<String> unitlist = new ArrayList<>();
    public ArrayList<Integer> stockQtylist = new ArrayList<>();
    public ArrayList<Integer> reoderLevellist = new ArrayList<>();
    public ArrayList<String> i_statuslist = new ArrayList<>();
    
    public Inventory() {}
    
    public int createInventory() {
        try {
            // Connecting to Database
            Connection conn;
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/asset_management_db?useTimezone=true&serverTimezone=UTC&user=root&password=12345678");
            System.out.println("Connection Succesful");
            
            // Prepare SQL Statement
            PreparedStatement pstmt = conn.prepareStatement("SELECT MAX(itemID) + 1 AS newID FROM inventory");
            ResultSet rst = pstmt.executeQuery();
            while (rst.next()) {
                itemID = rst.getInt("newID");
            }
            
            // Save the new Inventory
            pstmt = conn.prepareStatement("INSERT INTO inventory (itemID, itemName, itemType, unit, stockQty, reorderLevel, i_status) VALUE (?, ?, ?, ?, ?, ?, ?)");
            pstmt.setInt(1, itemID);
            pstmt.setString(2, itemName);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }
    
    public static void main(String[] args) {
        
    }
}
