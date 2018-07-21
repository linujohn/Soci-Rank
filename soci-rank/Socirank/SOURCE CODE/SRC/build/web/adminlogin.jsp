<%-- 
    Document   : adminlogin
     
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html lang="en">
<head>
<title>SociRank</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">
<link rel='stylesheet' id='prettyphoto-css'  href="css/prettyPhoto.css" type='text/css' media='all'>
<link href="css/fontello.css" type="text/css" rel="stylesheet">
<!--[if lt IE 7]>
<link href="css/fontello-ie7.css" type="text/css" rel="stylesheet">  
<![endif]-->
<link href='http://fonts.googleapis.com/css?family=Quattrocento:400,700' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Patua+One' rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<style type="text/css">
body {
	padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
}
</style>
<link href="css/bootstrap-responsive.css" rel="stylesheet">
<!--[if lt IE 9]>
<script src="js/html5.js"></script>
<![endif]-->
<script src="js/jquery.js"></script>
<script src="js/jquery.scrollTo-1.4.2-min.js"></script>
<script src="js/jquery.localscroll-1.2.7-min.js"></script>
<script charset="utf-8">
$(document).ready(function () {
    $("a[rel^='prettyPhoto']").prettyPhoto();
});
</script>
</head>
<body>
<div class="navbar-wrapper">
  <div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
        <h1 class="brand"><a href="#top" style="color:yellow;">SociRank!</a></h1>
        <nav class="pull-right nav-collapse collapse">
          <ul id="menu-main" class="nav">
            <li><a href="index.html">Home</a></li>
            <li><a href="adminlogin.jsp">Admin</a></li>
            <li><a href="userregister.jsp">SignUp</a></li>
            <li><a href="userlogin.jsp">SignIn</a></li>
          </ul>
        </nav>
      </div>
    </div>
  </div>
</div>
<section id="portfolio" class="single-page scrollblock" style="background-color: white;">
  <div class="container">  
      <h1 style="color: #0b333f;">Admin Login</h1>
      <form action="login">
            <center>
                <table width="345" border="1" bgcolor="#99CC00">                     
                    <tr><th>Enter your Username</th> 
                    <td><input type="text" name="name"/></td></tr> 
                    <tr><th>Enter your Password</th> 
                    <td><input type="password" name="pass"/></td></tr> 
                    <tr><th colspan="2"><input type="submit" value="SignIn"/></th></tr> 
                </table>
            </center>
        </form>    
  </div>
</section>
<section id="services" class="single-page scrollblock">
  <div class="container">
    <div class="align"></div>
  </div>
</section>
<div class="footer-wrapper">
  <div class="container">
    <footer> <small>&copy; 2018 Twitter Network. All rights reserved. </small> </footer>
  </div>
</div>
<script src="js/bootstrap.js"></script>
<script src="js/jquery.prettyPhoto.js"></script>
<script src="js/site.js"></script>
</body>
</html>