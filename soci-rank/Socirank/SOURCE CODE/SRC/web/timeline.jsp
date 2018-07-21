<%-- 
    Document   : timeline
   
--%>

<%@page import="twitter4j.Status"%>
<%@page import="java.util.List"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.conf.ConfigurationBuilder"%>
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
<%
    String loc = session.getAttribute("loc").toString();
    String follow = session.getAttribute("follow").toString();
    String friends = session.getAttribute("friends").toString();
    String fav = session.getAttribute("fav").toString();
    String aname = session.getAttribute("aname").toString();
    String aid = session.getAttribute("aid").toString();
    String url = session.getAttribute("url").toString();
    String ckey = session.getAttribute("ckey").toString();
    String csecret = session.getAttribute("csecret").toString();
    String atoken = session.getAttribute("atoken").toString();
    String atokensecret = session.getAttribute("atokensecret").toString();
%>
<div class="navbar-wrapper">
  <div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
      <div class="container"> <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </a>
        <h1 class="brand"><a href="#top" style="color:yellow;">SociRank!</a></h1>
        <nav class="pull-right nav-collapse collapse">
          <ul id="menu-main" class="nav">
            <li><a href="userhome.jsp">UserHome</a></li>
            <li><a href="timeline.jsp">Timeline</a></li>
            <li><a href="posttweet.jsp">Post Tweet</a></li>
            <li><a href="querytweet.jsp">Query Tweet</a></li>
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
            <center><h1 style="color:red;">Home TimeLine</h1></center>
            <%
    ConfigurationBuilder of;
    TwitterFactory tf;
    of = new ConfigurationBuilder();
            of.setDebugEnabled(true)
                    .setOAuthConsumerKey(ckey)
                    .setOAuthConsumerSecret(csecret)
                    .setOAuthAccessToken(atoken)
                    .setOAuthAccessTokenSecret(atokensecret);
    tf = new TwitterFactory(of.build()); 
             twitter4j.Twitter twitter = tf.getInstance();
            List<Status> statuses = twitter.getHomeTimeline();
            int ii=1;
            for (Status status : statuses) 
            {
                System.out.println(status.getUser().getName() + "" +
                        status.getText());
                %>
                <h2><%=ii%>) <%=status.getUser().getName()%></h2>
                <h3><%=status.getText()%></h3>
                <%       
                ii++;
            }   
            %>
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