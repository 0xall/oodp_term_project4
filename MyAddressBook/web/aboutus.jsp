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
    About Us
</header>

<section>

    <article>
        <div>Created By Kang Seung Won, Lee Ho Jun</div>
    </article>
</section>

</body>
</html>
