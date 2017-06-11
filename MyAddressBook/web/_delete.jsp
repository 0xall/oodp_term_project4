<%@ include file="loadsql.jsp"%>

<%
    request.setCharacterEncoding("utf-8");

    String[] params = request.getParameterValues("contacts");

    if(params != null) {
        StringBuilder sql = new StringBuilder("DELETE FROM contacts WHERE ");

        for (int i = 0; i < params.length; ++i) {
            if (i != 0) sql.append(" OR ");
            sql.append("id = ");
            sql.append(params[i]);
        }

        PreparedStatement ps = conn.prepareStatement(sql.toString());
        ps.execute();
    }

    //addContact(conn, param);
%>

<script type="text/javascript" language="javascript">
    location.href = './';
</script>