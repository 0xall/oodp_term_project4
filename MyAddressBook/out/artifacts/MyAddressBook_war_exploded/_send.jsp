<%@ include file="loadsql.jsp"%>

<%
    request.setCharacterEncoding("utf-8");

    String message = request.getParameter("message_content");
    String cid = request.getParameter("id");

    String sql = "SELECT phone_number FROM contacts WHERE id=?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, cid);

    ResultSet rs = ps.executeQuery();
    rs.next();

    sendMessage(conn, "to", rs.getString(1), message);
%>

<script type="text/javascript" language="javascript">
    location.href = './message_list.jsp?id=<%=cid %> ';
</script>