<%-- 
    Document   : keyterm
     
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="com.Stopwords"%>
<%@page import="java.sql.*"%>
<%@page import="com.tweets"%>
<%@page import="java.util.List"%>
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
<style>

tr:nth-child(even){background-color: #f2f2f2}

th {
    background-color: yellow;
    color: black;
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
<%
    String content = request.getParameter("content");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/socirank", "root", "");
    String Query="select * from news where content='"+content+"' ";
    PreparedStatement ps=con.prepareStatement(Query);
    ResultSet rs=ps.executeQuery();
    String Query1="select * from tweets where content='"+content+"' ";
    PreparedStatement ps1=con.prepareStatement(Query1);
    ResultSet rs1=ps1.executeQuery();
%>
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
  <section style="background-color: skyblue;">
    <div class="container">
      <div class="row">
        <div class="span12">
            <center><h1 style="color:red;">Key Term Graph Construction</h1></center><br>
            <center><h2 style="color:black;">Stop Words Removal Process for Tweets</h2></center><br>
            
           
            <%  
    String data="";
            int k=1;
            while(rs.next())
            {
            data=rs.getString("news");
            Stopwords ss=new Stopwords();
            LinkedList<String>stop=new LinkedList<String>();
            stop.clear();
            stop = ss.words(data);   
            String result1=""; 
            for(String zob : stop)
            {
                result1+=zob+" ";
            }
            result1 = result1.replaceAll("[,]"," "); 
            
            PreparedStatement pso = con.prepareStatement("update news set sto='"+result1+"' where news='"+data+"' and content='"+content+"' ");
            pso.executeUpdate();   
            }
            String data1="";
            int k1=1;
            while(rs1.next())
            {
            data1=rs1.getString("tweets");
            Stopwords ss1=new Stopwords();
            LinkedList<String>stop1=new LinkedList<String>();
            stop1.clear();
            stop1 = ss1.words(data1);   
            String result2=""; 
            for(String zob1 : stop1)
            {
                result2+=zob1+" ";
            }
            result2 = result2.replaceAll("[,]"," "); 
            
            PreparedStatement pso1 = con.prepareStatement("update tweets set sto='"+result2+"' where tweets='"+data1+"' and content='"+content+"' ");
            pso1.executeUpdate();   
            
            }
            %>
            
            <table id="pro_display_table" border="0" cellspacing="1px"  style="border: 4px solid #FB9217; width:auto;height: auto;">
            <tr align="center" style="font-weight: bold;font-size: 17px;">
                <th>Id</th>
                <th>Tweet</th>
           </tr>
           <%
           PreparedStatement psoo = con.prepareStatement("select * from tweets where content='"+content+"' ");
           ResultSet rsss = psoo.executeQuery();
           while(rsss.next())
           {
           %>
           <tr style="color:#080606;font-weight: bold;">
                <td><%=rsss.getString("id")%>.</td>
                <td><%=rsss.getString("sto")%></td>
            </tr>
            <%
           }
            %>
            </table>
            <br>
            <center><h2 style="color:black;">Stop Words Removal Process for News</h2></center><br>
            
            <table id="pro_display_table" border="0" cellspacing="1px"  style="border: 4px solid #FB9217; width:auto;height: auto;">
            <tr align="center" style="font-weight: bold;font-size: 17px;">
                <th>Id</th>
                <th>Tweet</th>
           </tr>
           <%
           PreparedStatement psoo1 = con.prepareStatement("select * from news where content='"+content+"' ");
           ResultSet rsss1 = psoo1.executeQuery();
           while(rsss1.next())
           {
           %>
           <tr style="color:#080606;font-weight: bold;">
                <td><%=rsss1.getString("id")%>.</td>
                <td><%=rsss1.getString("sto")%></td>
            </tr>
            <%
           }
            %>
            </table>
            <br>
            <center>
            <ul id="menu-main" class="nav" style="width: 200px;">
                <li><a href="termfrequency.jsp?content=<%=content%>">Term Frequency</a></li>
            </ul>
            </center>
            <br><br>
        </div>
      </div>
    </div>
  </section>
</div>
<section id="portfolio" class="single-page scrollblock" style="background-color: white;">
  <div class="container">  
      
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