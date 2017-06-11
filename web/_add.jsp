<%@ include file="loadsql.jsp"%>

<%
    request.setCharacterEncoding("utf-8");

    String[] param = {
            request.getParameter("contact_group"), request.getParameter("contact_name"), request.getParameter("contact_number"),
            request.getParameter("contact_home_addr"), request.getParameter("contact_office_addr"), request.getParameter("contact_email"),
            request.getParameter("contact_url"), request.getParameter("contact_memo")
    };

    for(int i=0; i<8; ++i) {
        if(param[i] != null && param[i].trim().isEmpty()) param[i] = null;
    }

    addContact(conn, param);
%>

<script type="text/javascript" language="javascript">
    location.href = './';
</script>