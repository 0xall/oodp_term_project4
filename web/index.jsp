<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="loadsql.jsp"%>

<html>
  <head>
    <title>My Contacts</title>
    <link href="https://fonts.googleapis.com/css?family=Cabin|Patua+One|Open+Sans" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="mab_default.css" />
    <link rel="stylesheet" type="text/css" href="jquery.fancybox.min.css" />
    <script type="text/javascript" src="jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="jquery.fancybox.min.js"></script>
    <script type="text/javascript" language="javascript">

      $(document).ready( function() {

          $("#delete_button").on('click', function() {
              $('#delete').submit();
          });

          $("[data-fancybox]").fancybox({
              iframe : {
                  css : {
                      width : '512px',
                      height: '580px'
                  }
              }
          });

          $(document).click(function(e) {
              if($('.submenu').css('right') == "0px") {
                  if($(e.target).closest('.submenu').length == 0 && $(e.target).closest('.dropdown a').length == 0) {
                      $('.submenu').slideUp(200);
                  }
              }
          });

          $('.dropdown a').on('click', function() {
              $(this).parent().children('.submenu').slideToggle(200);
          });
      });

    </script>
  </head>
  <body>
    <!-- Top fixed menu -->
    <nav id="top_fixed_menu">
        <span>My Contacts</span>
      <ul class="menu">
        <li><a href="./index.jsp"><img src="images/contacts_icon.gif"></a></li>
        <li class="dropdown"><a href="#"><img src="images/etc_icon.gif"></a>
            <ul class="submenu">
              <li><a href="aboutus.jsp">About Us</a></li>
            </ul>
        </li>
      </ul>
    </nav>

    <!-- HEADER -- About this page -->
    <header class="title">
      Your Contacts List
    </header>

  <section>
    <!--article>
      <header>Your Information</header>
      <div>
        <ul class="myinfo">
          <li><span>First Name</span><a href="#">Seung Won</a></li>
          <li><span>Last Name</span><a href="#">Kang</a></li>
          <li><span>Phone Number</span><a href="#">010-3894-0662</a></li>
          <li><span>E-mail Address</span><a href="#">ksw3894@naver.com</a></li>
        </ul>
        <span class="help">To modify your information, click your information.</span>
      </div>
    </article-->

    <%
      // load contacts
      int rowCount = 0, i = 1;
      String sql = "SELECT count(*) FROM contacts";
      PreparedStatement ps = conn.prepareStatement(sql);
      ResultSet rs = ps.executeQuery();
      rs.next();
      rowCount = rs.getInt(1);

      sql = "SELECT id, contact_group, contact_name, phone_number FROM contacts ORDER BY lower(contact_group), lower(contact_name) ASC";
      ps = conn.prepareStatement(sql);
      rs = ps.executeQuery();
      rs.next();
    %>

    <article>
      <form action="_delete.jsp" method="post" id="delete">
      <div>
        <span class="attach">Count : <%=rowCount %>
          <span class="right">
            <a class="style_button blue_button" data-fancybox data-type="iframe" data-src="add_mod_contact.jsp" href="javascript:;">+</a>
            <a href="#" class="style_button red_button" id="delete_button">-</a>
          </span>
        </span>
        <table class="contacts_table">
          <tr class="table_title">
            <td class="table_no">-</td>
            <td class="table_group">Group</td>
            <td class="table_name">Name</td>
            <td class="table_phone">Phone Number</td>
            <td class="table_modify">-</td>
          </tr>

          <%
            while(rowCount > 0 && !rs.isAfterLast()) {

          %>
            <tr class="contact_row">
              <td><input type="checkbox" name="contacts" value="<%=rs.getString(1) %>"></td>
              <td><%
                String group = rs.getString(2);
                if(group == null) out.print("None");
                else out.print(group);
              %></td>
              <td> <a data-fancybox data-type="iframe" data-src="message_list.jsp?id=<%=rs.getString(1) %>" href="javascript:;"> <%=rs.getString(3) %></a></td>
              <td><%
                try {
                  PhoneNumber p = new PhoneNumber(rs.getString(4));
                  out.print(p.toString());
                } catch(WrongSyntaxException e) {
                  out.print(rs.getString(4));
                }
              %></td>
              <td>
                <a data-fancybox data-type="iframe" data-src="message.jsp?id=<%=rs.getString(1) %>" href="javascript:;" class="style_button white_button">SEND</a>
                <a data-fancybox data-type="iframe" data-src="add_mod_contact.jsp?id=<%=rs.getString(1) %>" href="javascript:;" class="style_button white_button">MODIFY</a>
              </td>
            </tr>
          <%
              rs.next();
            }
          %>
        </table>
      </div>
      </form>
    </article>
  </section>

  </body>
</html>
