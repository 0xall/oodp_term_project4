
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
    <link rel="stylesheet" type="text/css" href="contact_form.css" />
    <script type="text/javascript" src="jquery-3.2.1.min.js"></script>
    <script type="text/javascript" language="javascript">

        $(document).ready(function() {

            var placeHolderTarget = $('.contact_form input[type="text"], .contact_form textarea');

            placeHolderTarget.on('check', function() {
                if($(this).val() != '') $(this).siblings('label').css('display', 'none');
            });

            placeHolderTarget.trigger('check');

            $('#send_button').on('click', function() {

                var err = $('#error');

                if($('#message_content').val().trim() == '') {
                    err.text('You should input text');
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

                if($('#message_content').val().trim() == '') {
                    err.text('You should input text');
                }

                else {
                    err.fadeOut('fast');
                    return;
                }

                err.fadeIn('fast');

            });

        });

    </script>
</head>
<body>

<section class="contact_form">
    <form action="_send.jsp?id=<%=cid %>" method="post" id="contact_form">
        <ul>
            <li><label for="message_content">Please Input Message to Send.</label><textarea name="message_content" id="message_content" maxlength="255"></textarea></li>
            <li style="display:none;" id="error"> ERROR</li>
            <li><a href="#" class="style_button white_button big_button" id="send_button">Send Message</a></li>
        </ul>
    </form>

</section>
</body>
</html>
