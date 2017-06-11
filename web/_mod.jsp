<%@ include file="loadsql.jsp"%>

<%
    request.setCharacterEncoding("utf-8");

    if(request.getParameter("id") != null) {

        String[] param = {
                request.getParameter("contact_group"), request.getParameter("contact_name"), request.getParameter("contact_number"),
                request.getParameter("contact_home_addr"), request.getParameter("contact_office_addr"), request.getParameter("contact_email"),
                request.getParameter("contact_url"), request.getParameter("contact_memo")
        };

        for (int i = 0; i < 8; ++i) {
            if (param[i] != null && param[i].trim().isEmpty()) param[i] = null;
        }

        String sql = "UPDATE contacts SET contact_group = ?, contact_name = ?, phone_number = ?, home_address = ?, office_address = ?, email = ?, url = ?, memo = ? WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);

        for (int i = 0; i < 8; ++i) {
            ps.setString(i + 1, param[i]);
        }

        ps.setString(9, request.getParameter("id"));
        ps.execute();
    }
%>

<script type="text/javascript" language="javascript">
    location.href = './';
</script>