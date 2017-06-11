<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="loadsql.jsp"%>

<%
    String cid = request.getParameter("id");
%>

<html>
<head>
    <title>My Contacts</title>
    <link href="https://fonts.googleapis.com/css?family=Cabin|Patua+One|Open+Sans" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="mab_default.css" />
    <link rel="stylesheet" type="text/css" href="message_form.css" />
    <script type="text/javascript" src="jquery-3.2.1.min.js"></script>
    <script type="text/javascript" language="javascript">

        $(document).ready(function() {

        });

    </script>
</head>
<body>

<%
    String sql = "SELECT contact_name, phone_number FROM contacts WHERE id=?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, cid);

    ResultSet rs = ps.executeQuery();
    rs.next();

    String name = rs.getString(1);
    String phoneNumber = rs.getString(2);

    sql = "SELECT * FROM messages WHERE phone_number = ? ORDER BY created_time DESC";
    ps = conn.prepareStatement(sql);
    ps.setString(1, phoneNumber);

    rs = ps.executeQuery();


%>

<section class="message_list_form">
    <form action="_send.jsp?id=<%=cid %>" method="post" id="message_list_form" target="_parent">
        <ul>
            <li style="border:0px none"><a href="./message.jsp?id=<%=cid%>" class="style_button white_button big_button" id="send_button">Send Message</a></li>
            <%
                if(rs.next())

                while(!rs.isAfterLast()) {
                    java.sql.Date createdDate= rs.getDate(1);
                    java.sql.Time createdTime = rs.getTime(2);
                    String message = rs.getString(5);
                    int target = rs.getInt(4);

            %>
            <li><span class="sender"><%= (target==1)? "You" : name  %></span>
                <span class="time"><%
                    Calendar cDate = Calendar.getInstance();
                    Calendar cTime = Calendar.getInstance();
                    cDate.setTimeInMillis(createdDate.getTime());
                    cTime.setTimeInMillis(createdTime.getTime());

                    int year = cDate.get(Calendar.YEAR);
                    int month = cDate.get(Calendar.MONTH) + 1;
                    int day = cDate.get(Calendar.DAY_OF_MONTH);
                    int hour = cTime.get(Calendar.HOUR);
                    int minute = cTime.get(Calendar.MINUTE);
                    int second = cTime.get(Calendar.SECOND);

                    out.println(year + "." + month + "." + day + " " + hour + ":" + minute + ":" + second);
                %></span>
                <p class="content"><%= (message != null) ? message.replaceAll("\r\n", "<br>") : "" %></p></li>
            <%
                    rs.next();
                }
            %>
        </ul>
    </form>

</section>
</body>
</html>
