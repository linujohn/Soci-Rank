<%-- 
    Document   : send
   
--%>

<%@page import="java.sql.*"%>
<%@page import="twitter4j.TwitterException"%>
<%@page import="twitter4j.DirectMessage"%>
<%@page import="twitter4j.TwitterFactory"%>
<%@page import="twitter4j.conf.ConfigurationBuilder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
try
{
    String tid="";
    String message="";
String content = request.getParameter("content");
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/socirank", "root", "");
PreparedStatement pso = con.prepareStatement("select * from qtweet where content='"+content+"' ");
ResultSet rs = pso.executeQuery();  
if(rs.next())
{
   tid=rs.getString("tid"); 
}
System.out.println(" Tid : "+tid);
String news="";
String tweets="";
ConfigurationBuilder of;
    TwitterFactory tf;
    of = new ConfigurationBuilder();
            of.setDebugEnabled(true)
                    .setOAuthConsumerKey("MEkL6judbkkI8YttGfm0vi7Dw")
                    .setOAuthConsumerSecret("eVQyrUebvqoR9BgP8EYArqL5O0AACzJE4TkonWOImoKSRgcVLx")
                    .setOAuthAccessToken("719865368106385408-Jn0yeLr7ysUBhPg4zVLNm33bo9m3VtZ")
                    .setOAuthAccessTokenSecret("ZXD8O4Hv2M1Gf5nLGJ8zLFTsi08mPJCg1iyxjRAatcewU");
    tf = new TwitterFactory(of.build());  
    twitter4j.Twitter twitter = tf.getInstance();
    PreparedStatement psoo1 = con.prepareStatement("select * from news where content='"+content+"' and not nodew='0' GROUP BY news ORDER BY term DESC limit 5  ");
           ResultSet rsss1 = psoo1.executeQuery();
           message="News Data's After Mining Process ";
           DirectMessage directMessage = twitter.sendDirectMessage(tid, message);
           while(rsss1.next())
           {
               news=rsss1.getString("news");
           twitter.sendDirectMessage(tid, news);
           }
           String message1="Tweets Data's After Mining Process ";
           twitter.sendDirectMessage(tid, message1);
           PreparedStatement psoo = con.prepareStatement("select * from tweets where content='"+content+"' and not nodew='0' GROUP BY tweets ORDER BY term DESC limit 5 ");
           ResultSet rsss = psoo.executeQuery();
           while(rsss.next())
           {
               tweets=rsss.getString("tweets");
           twitter.sendDirectMessage(tid,tweets);   
           }
            out.println("<script>"
                        +"alert('Send Successfully..')"
                        +"</script>");                 
            RequestDispatcher rd = request.getRequestDispatcher("adminhome.jsp");
            rd.include(request, response);
            }
            catch(Exception ex)
            {
                System.out.println(ex);
                  out.println("<script>"
                        +"alert('Some Error Occured.')"
                        +"</script>");                 
            RequestDispatcher rd = request.getRequestDispatcher("adminhome.jsp");
            rd.include(request, response);   
            }
        
%>