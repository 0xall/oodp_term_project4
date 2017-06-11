<%@ page import="java.sql.*" %>
<%@ include file="_phonenumber.jsp"%>

<%
    // 조교님 MySQL 정보가 틀리면 수정해주세요!!
    String url  = "jdbc:mysql://localhost";
    String port = "3306";
    String id   = "root";
    String pwd  = "oodp";
%>

<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = null;

    String dbname = "oodp_ksw_lhj";
    String full_url;

    try {

        full_url = url + ":" + port + "/" + dbname;
        conn = DriverManager.getConnection(full_url, id, pwd);

    } catch(Exception e) {

        // if exception occured first
        // check the database doesn't exist

        try {
            full_url = url + ":" + port + "?useUnicode=true&characterEncoding=utf8";

            conn = DriverManager.getConnection(full_url, id, pwd);

            // if success, create database 'oodp'

            String sql = "CREATE DATABASE " + dbname;
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.execute();

            // close current connection and reconnect the created database

            conn.close();

            full_url = url + ":" + port + "/" + dbname + "?useUnicode=true&characterEncoding=utf8";
            conn = DriverManager.getConnection(full_url, id, pwd);

            // create tables
            CreateDatabaseTable(conn);

        } catch(Exception e2) {

            // Maybe the MySQL information is wrong..
            out.println("I think MySQL information is wrong..<br> Please edit loadsql.jsp file");
            out.close();
        }

    }
%>

<%!
   public void CreateDatabaseTable(Connection conn) {
       String sql_create_contacts = "CREATE TABLE contacts (" +
               "id int NOT NULL AUTO_INCREMENT PRIMARY KEY," +
               "contact_group VARCHAR (32), " +
               "contact_name VARCHAR(32) NOT NULL, " +
               "phone_number VARCHAR(32) NOT NULL, " +
               "home_address VARCHAR(128), " +
               "office_address VARCHAR(128), " +
               "email VARCHAR(64), " +
               "url VARCHAR(128), " +
               "memo TEXT" +
               ") charset=\"utf8\"";

       String sql_create_messages = "CREATE TABLE messages (" +
               "created_date DATE, " +
               "created_time TIME, " +
               "phone_number VARCHAR(32) NOT NULL," +
               "target INT," +      // 0 : from, 1 : to
               "message TEXT" +
               ") charset=\"utf8\"";

       try {
           PreparedStatement ps = conn.prepareStatement(sql_create_contacts);
           ps.execute();

           ps = conn.prepareStatement(sql_create_messages);
           ps.execute();

           addContact(conn, "Kang Seung Won", "01038940662");
           addContact(conn, "Lee Ho Jun", "01011111111");
           sendMessage(conn, "from", "01038940662", "Hello, \r\n You created a new website. Thank you!");
       } catch(Exception e) {
           e.printStackTrace();
       }
   }

   public boolean addContact(Connection conn, String name, String phoneNumber) {
       String sql = "INSERT INTO contacts (contact_name, phone_number) VALUE (?, ?)";

       try {
           PreparedStatement ps = conn.prepareStatement(sql);

           ps.setString(1, name);
           ps.setString(2, phoneNumber);

           ps.execute();

       } catch(Exception e) {

           // if failed to insert into the table, return FALSE
           return false;
       }

       return true;
   }

    public boolean addContact(Connection conn, String[] param) {
        String sql = "INSERT INTO contacts (contact_group, contact_name, phone_number, " +
                "home_address, office_address, email, url, memo) VALUE (?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);

            for(int i=0; i<8; ++i) {
                ps.setString(i+1, param[i]);
            }

            ps.execute();

        } catch(Exception e) {

            // if failed to insert into the table, return FALSE
            e.printStackTrace();
            return false;
        }

        return true;
    }

    public boolean sendMessage(Connection conn, String target, String phoneNumber, String message) {

       int targetInt = 0;
       try {
           PhoneNumber p = new PhoneNumber(phoneNumber);
       } catch(WrongSyntaxException e) {
           return false;
       }

       if(target.equals("from")) {
           targetInt = 0;
       }

       else if(target.equals("to")) {
           targetInt = 1;
       }

       try {
           String sql = "INSERT INTO messages (created_date, created_time, phone_number, target, message) VALUE (CURRENT_DATE(), CURRENT_TIME (), ?, ?, ?)";
           PreparedStatement ps = conn.prepareStatement(sql);

           ps.setString(1, phoneNumber);
           ps.setInt(2, targetInt);
           ps.setString(3, message);

           ps.execute();
       } catch(Exception e) {
           return false;
       }

       return true;
    }
%>