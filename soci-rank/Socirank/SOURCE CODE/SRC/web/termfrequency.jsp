<%-- 
    Document   : termfrequency
    
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
            <center><h1 style="color:red;">Key Term Construction</h1></center><br>
            
            <%  
            String conts="";
            while(rs.next())
            {
              conts=rs.getString("news");
                        String word[]=conts.split(" ");
                        String qur[]=content.split(" ");
                        int cou=0; int high=0;
                        for(int i=0;i<qur.length;i++)
                        {
                            int dummy=0;
                            for(int j=0;j<word.length;j++)
                            {
				if(qur[i].equalsIgnoreCase(word[j]))
				{
                                    high++;
                                    if(dummy==0)
                                    {
                                        dummy++;
                                        cou++;
                                    }
				}
                            }
                        }
                        double dd = (Math.log(high)+1);
                        
                           PreparedStatement insert1=con.prepareStatement("update news set term='"+high+"',tf='"+dd+"' where news='"+conts+"' ");
                           insert1.executeUpdate();                            
                        float betw=high/2;
                        double nodew=dd/2;
                           if(cou>=qur.length)
                        {
                            PreparedStatement yy1=con.prepareStatement("update news set termsimi='"+high+"',outlierdet='"+dd+"',betw='"+betw+"',nodew='"+nodew+"' where news='"+conts+"' ");
                           yy1.executeUpdate(); 
                        }
                           
            }
            String conts1="";
            while(rs1.next())
            {
              conts1=rs1.getString("tweets");
                        String word[]=conts1.split(" ");
                        String qur[]=content.split(" ");
                        int cou=0; int high=0;
                        for(int i=0;i<qur.length;i++)
                        {
                            int dummy=0;
                            for(int j=0;j<word.length;j++)
                            {
				if(qur[i].equalsIgnoreCase(word[j]))
				{
                                    high++;
                                    if(dummy==0)
                                    {
                                        dummy++;
                                        cou++;
                                    }
				}
                            }
                        }
                        double dd = (Math.log(high)+1);
                        PreparedStatement insert=con.prepareStatement("update tweets set term='"+high+"',tf='"+dd+"' where tweets='"+conts1+"' ");
                        insert.executeUpdate(); 
                        float betw=high/2;
                        double nodew=dd/2;
                        if(cou>=qur.length)
                        {
                           PreparedStatement xx=con.prepareStatement("update tweets set termsimi='"+high+"',outlierdet='"+dd+"',betw='"+betw+"',nodew='"+nodew+"' where tweets='"+conts1+"' ");
                           xx.executeUpdate();
                        }  
            }
             
            %>
            
            <center><h2 style="color:black;">Term Frequency For Tweets</h2></center><br>
            <table id="pro_display_table" border="0" cellspacing="1px"  style="border: 4px solid #FB9217; width:auto;height: auto;">
            <tr align="center" style="font-weight: bold;font-size: 17px;">
                <th>Id</th>
                <th>Tweet</th>
                <th>Term Frequency</th>
           </tr>
           <%
           PreparedStatement psoo = con.prepareStatement("select * from tweets where content='"+content+"' ");
           ResultSet rsss = psoo.executeQuery();
           while(rsss.next())
           {
           %>
           <tr style="color:#080606;font-weight: bold;">
                <td><%=rsss.getString("id")%>.</td>
                <td><%=rsss.getString("tweets")%></td>
                <td style="text-align: center;"><%=rsss.getString("term")%></td>
            </tr>
            <%
           }
            %>
            </table>
            <br>
            <center><h2 style="color:black;">Term Frequency For News</h2></center><br>
            
            <table id="pro_display_table" border="0" cellspacing="1px"  style="border: 4px solid #FB9217; width:auto;height: auto;">
            <tr align="center" style="font-weight: bold;font-size: 17px;">
                <th>Id</th>
                <th>Tweet</th>
                <th>Term Frequency</th>
           </tr>
           <%
           PreparedStatement psoo1 = con.prepareStatement("select * from news where content='"+content+"' ");
           ResultSet rsss1 = psoo1.executeQuery();
           while(rsss1.next())
           {
           %>
           <tr style="color:#080606;font-weight: bold;">
                <td><%=rsss1.getString("id")%>.</td>
                <td><%=rsss1.getString("news")%></td>
                <td style="text-align: center;"><%=rsss1.getString("term")%></td>
            </tr>
            <%
           }
            %>
            </table>
            
            <br>
            <center>
            <ul id="menu-main" class="nav" style="width: 300px;">
                <li><a href="relevant.jsp?content=<%=content%>">Relevant Key Term Identification</a></li>
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