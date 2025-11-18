/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author Kimberly Chong
 */
public class Supplier {
    
    //var
    private int supplierID;
    private String companyName;
    private String firstName;
    private String lastName;
    private String contactNumber;
    private String email;
    private String street;
    private String city;
    private String zip;
    
    //constructor
    public Supplier (int supplierID, String companyName, String firstName, String lastName, String contactNumber, String email, String street, String city, String zip)
    {
        this.supplierID = supplierID;
        this.companyName = companyName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.street = street;
        this.city = city;
        this.zip = zip;
    }
    
    //getters/setters
    public int getSupplierID()
    {
        return supplierID;
    }
    public void setSupplierID(int supplierID)
    {
        this.supplierID = supplierID;
    }


    public String getCompanyName()
    {
        return companyName;
    }
    public void setCompanyName(String companyName)
    {
        this.companyName = companyName;
    }

    
        //contactPerson
    public String getLastName()
    {
        return lastName;
    }
    public void setLastName(String lastName)
    {
        this.lastName = lastName;
    }
    public String getFirstName()
    {
        return firstName;
    }
    public void setFirstName(String firstName)
    {
        this.firstName = firstName;
    }


    public String getContactNumber()
    {
        return contactNumber;
    }
    public void setContactNumber(String contactNumber)
    {
        this.contactNumber = contactNumber;
    }


    public String getEmail()
    {
        return email;
    }
    public void setEmail(String email)
    {
        this.email = email;
    }

        //address
    public String getStreet()
    {
        return street;
    }
    public void setStreet(String street)
    {
        this.street = street;
    }
    public String getCity()
    {
        return city;
    }
    public void setCity(String city)
    {
        this.city = city;
    }
    public String getZIP()
    {
        return zip;
    }
    public void setZIP(String zip)
    {
        this.zip = zip;
    }
}

