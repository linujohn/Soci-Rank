<%-- 
    Document   : getquery
   
--%>

<%@page import="java.sql.*"%>
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
            <li><a href="adminhome.jsp">Admin Home</a></li>
            <li><a href="getquery.jsp">Get Queries</a></li>
            <li><a href="evaluation.jsp">Evaluation</a></li>
            <li><a href="logout.jsp">Logout</a></li>
          </ul>
        </nav>
      </div>
    </div>
  </div>
</div>
<div id="top"></div>

<div class="scrollblock">
  <section id="feature">
    <div class="container">
      <div class="row">
        <div class="span12">
		<br><br>
		<center>
          <img src="img/admin.png" style="height:400px;">
		</center>
        </div>
      </div>
    </div>
  </section>
</div>
<section id="portfolio" class="single-page scrollblock" style="background-color: white;">
  <div class="container">  
        <%
        try{
        //Dis=no
        

//if(Fin.equals("yes")){
   // System.out.println(Fin);
    %>
  <center>
     <table id="pro_display_table" border="0" cellspacing="1px"  style="border: 4px solid #FB9217; width:auto;height: auto;">
                                 <tr>
    <th scope="row">&nbsp;</th>
    <td>&nbsp;</td>
  </tr>
         <tr>  
                                    <td align="center" style="color:#0D72BD;font-weight: bold;font-size: 17px;"><b><strong>&nbsp;&nbsp;Id</strong></b></td>
                                    <td align="center" style="color:#0D72BD;font-weight: bold;font-size: 17px;"><b><strong>&emsp;Twitter Id</strong></b></td>
                                    <td align="center" style="color:#0D72BD;font-weight: bold;font-size: 17px;"><b><strong>&nbsp;&nbsp;Query</strong></b></td>                                     
                                    <td align="center" style="color:#0D72BD;font-weight: bold;font-size: 17px;"><b><strong>Time</strong></b></td> 
                                    <td align="center" style="color:#0D72BD;font-weight: bold;font-size: 17px;"><b><strong>Process&emsp;</strong></b></td> 
         </tr>
         <tr>
    <th scope="row">&nbsp;</th>
    <td>&nbsp;</td>
  </tr>
<% 
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/socirank", "root", "");
                        String Query22="select * from qtweet ";
                        PreparedStatement ps22=con.prepareStatement(Query22);
                        ResultSet rs22=ps22.executeQuery();
                                      while(rs22.next())
                                      {
                                          
                                          
                                          %>
                                <tr>                                  
                                    <td align="center" style="color:#080606;font-weight: bold;">&nbsp;&nbsp;<%=rs22.getString("id")%></td>
                                    <td align="center" style="color:#080606;font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;<%=rs22.getString("tid")%></td>
                                    <td align="center" style="color:#080606;font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;<%=rs22.getString("content")%></td>
                                    <td align="center" style="color:#080606;font-weight: bold;">&nbsp;&nbsp;&nbsp;&nbsp;<%=rs22.getString("ptime")%>&emsp;</td>
                                    <td><a href="process.jsp?id=<%=rs22.getString("id")%>">Preprocessing</a>&emsp;</td>
                               
 <tr>
    <th scope="row">&nbsp;</th>
    <td>&nbsp;</td>
  </tr>
                                    <%}%>
              </table>
</center>
     <%//}
                                     
   }catch(Exception e){
   System.out.println(e);
   }
   %>    
         <br><br>
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