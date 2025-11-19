/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package inventorymanagement;
import java.util.*;

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
    
    public Inventory() {}
    
    public int createInventory() {
        return 0;
    }
    
    public static void main(String[] args) {
        
    }
}
