/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import twitter4j.Status;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class posttweet extends HttpServlet 
{
    String tweet="";
    ConfigurationBuilder of;
    TwitterFactory tf;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter(); 
        {
            HttpSession session = request.getSession();
            tweet=request.getParameter("tweet");
            String ckey = session.getAttribute("ckey").toString();
    String csecret = session.getAttribute("csecret").toString();
    String atoken = session.getAttribute("atoken").toString();
    String atokensecret = session.getAttribute("atokensecret").toString();
    String tid = session.getAttribute("aid").toString();
            try {
                of = new ConfigurationBuilder();
            of.setDebugEnabled(true)
                    .setOAuthConsumerKey(ckey)
                    .setOAuthConsumerSecret(csecret)
                    .setOAuthAccessToken(atoken)
                    .setOAuthAccessTokenSecret(atokensecret);
    tf = new TwitterFactory(of.build());   
    // The factory instance is re-useable and thread safe.  
    Date ss = new Date();
    String ptime=ss.toString();
    twitter4j.Twitter twitter = tf.getInstance();
    Status status = twitter.updateStatus(tweet);
    System.out.println("Successfully updated the status to [" + status.getText() + "].");
    Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/socirank", "root", "");
            PreparedStatement ps=con.prepareStatement("insert into ptweet (tid,content,ptime) values ('"+tid+"','"+tweet+"','"+ptime+"') ");
            ps.executeUpdate();         
            out.println("<script>"
                        +"alert('Your Tweet Posted Successfully...')"
                        +"</script>");     
            RequestDispatcher rd = request.getRequestDispatcher("userhome.jsp");
            rd.include(request, response);      
        } catch (Exception ex) 
        {
            System.out.println(ex);
            out.println("<script>"
                        +"alert('Some Error Occured...')"
                        +"</script>");     
            RequestDispatcher rd = request.getRequestDispatcher("userhome.jsp");
            rd.include(request, response);      
        }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
