
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="loadsql.jsp"%>

<%
    String cid = request.getParameter("id");
    boolean bMod = (cid == null)? false : true;
%>

<html>
<head>
    <title>My Contacts</title>
    <link href="https://fonts.googleapis.com/css?family=Cabin|Patua+One|Open+Sans" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="mab_default.css" />
    <link rel="stylesheet" type="text/css" href="contact_form.css" />
    <script type="text/javascript" src="jquery-3.2.1.min.js"></script>
    <script type="text/javascript" language="javascript">

        $(document).ready(function() {

            var placeHolderTarget = $('.contact_form input[type="text"], .contact_form textarea');

            placeHolderTarget.on('check', function() {
                if($(this).val() != '') $(this).siblings('label').css('display', 'none');
            });

            placeHolderTarget.trigger('check');

            $('#add_button').on('click', function() {

                var err = $('#error');

                if($('#contact_name').val().length > 32) {
                    err.text('The length of name cannot be over 32.');
                }

                else if($('#contact_name').val().trim().length == 0) {
                    err.text('You should input name.');
                }

                else if($('#contact_number').val().trim().length == 0) {
                    err.text('You should input phone number.');
                }

                else if(isNaN($('#contact_number').val())) {
                    err.text('You should input phone number only with numbers.');
                }

                else if($('#contact_group').val().length > 32) {
                    err.text('The length of group cannot be over 32.');
                }

                else if($('#contact_home_addr').val().length > 128) {
                    err.text('The length of home address cannot be over 128.');
                }

                else if($('#contact_office_addr').val().length > 128) {
                    err.text('The length of office address cannot be over 128.');
                }

                else if($('#contact_email').val().length > 64) {
                    err.text('The length of email cannot be over 64.');
                }

                else if($('#contact_url').val().length > 128) {
                    err.text('The length of email cannot be over 128.');
                }

                else {
                    err.fadeOut('fast');
                    $('#contact_form').submit();
                    return;
                }

                err.fadeIn('fast');
            });

            placeHolderTarget.on('focus', function() {
                $(this).siblings('label').fadeOut('fast');
            });

            placeHolderTarget.on('focusout', function() {
                if($(this).val() == '') {
                    $(this).siblings('label').fadeIn('fast');
                }
            });


            $('input[type="text"]').on('focusout', function() {
                var err = $('#error');

                if($('#contact_name').val().length > 32) {
                    err.text('The length of name cannot be over 32.');
                }

                else if(isNaN($('#contact_number').val())) {
                    err.text('You should input phone number only with numbers.');
                }

                else if($('#contact_group').val().length > 32) {
                    err.text('The length of group cannot be over 32.');
                }

                else if($('#contact_home_addr').val().length > 128) {
                    err.text('The length of home address cannot be over 128.');
                }

                else if($('#contact_office_addr').val().length > 128) {
                    err.text('The length of office address cannot be over 128.');
                }

                else if($('#contact_email').val().length > 64) {
                    err.text('The length of email cannot be over 64.');
                }

                else if($('#contact_url').val().length > 128) {
                    err.text('The length of email cannot be over 128.');
                }

                else {
                    err.fadeOut('fast');
                    return;
                }

                err.fadeIn('fast');
                //err.fadeIn('fast');
            });
        });

    </script>
</head>
<body>

<%
    String[] param = {"", "", "", "", "", "", "", ""};

    if(bMod) {
        String sql = "SELECT contact_name, contact_group, phone_number, home_address, office_address, email, url, memo FROM contacts WHERE id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, cid);

        ResultSet rs = ps.executeQuery();

        rs.next();
        //if(rs.isLast()) bMod = false;
        //else {
            for(int i=0; i<8; ++i) {
                String tmp = rs.getString(i+1);
                if(tmp != null) param[i] = tmp;
            }
        //}
    }
%>

<section class="contact_form">
    <form action="<%=(bMod) ? "_mod.jsp?id=" + cid : "_add.jsp" %>" method="post" id="contact_form" target="_parent">
        <ul>
            <li><label for="contact_name">Name (essential)</label><input type="text" name="contact_name" value="<%=param[0] %>" id="contact_name" maxlength="32"></li>
            <li><label for="contact_group">Group</label><input type="text" name="contact_group" id="contact_group" value="<%=param[1] %>" maxlength="32"></li>
            <li><label for="contact_number">Phone Number (essential)</label><input type="text" name="contact_number" value="<%=param[2] %>" id="contact_number" maxlength="64"></li>
            <li><label for="contact_home_addr">Home Address</label><input type="text" name="contact_home_addr" value="<%=param[3] %>" id="contact_home_addr" maxlength="128"></li>
            <li><label for="contact_office_addr">Office Address</label><input type="text" name="contact_office_addr" value="<%=param[4] %>" id="contact_office_addr" maxlength="128"></li>
            <li><label for="contact_email">E-mail</label><input type="text" name="contact_email" value="<%=param[5] %>" id="contact_email" maxlength="64"></li>
            <li><label for="contact_url">URL</label><input type="text" name="contact_url" value="<%=param[6] %>" id="contact_url" maxlength="128"></li>
            <li><label for="contact_memo">Memo</label><textarea name="contact_memo" id="contact_memo" maxlength="255"><%=param[7] %></textarea></li>
            <li style="display:none;" id="error"> d</li>
            <li><a href="#" class="style_button white_button big_button" id="add_button"><%=(bMod) ? "Modify the contact" : "Insert into contacts list" %></a></li>
        </ul>
    </form>

</section>
</body>
</html>
