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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.conf.ConfigurationBuilder;

/**
 *
 * @author DLK 1
 */
public class ureg extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    ConfigurationBuilder of;
    TwitterFactory tf;
    String tid,name,pass,mobile,email,place,ckey,csecret,atoken,atokensecret;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter(); 
        try {
            tid=request.getParameter("tid");
            name=request.getParameter("name");
            pass=request.getParameter("pass");
            mobile=request.getParameter("mobile");
            email=request.getParameter("email");
            place=request.getParameter("place");
            ckey=request.getParameter("ckey");
            csecret=request.getParameter("csecret");
            atoken=request.getParameter("atoken");
            atokensecret=request.getParameter("atokensecret");          
            
            of = new ConfigurationBuilder();
            of.setDebugEnabled(true)
                    .setOAuthConsumerKey(ckey)
                    .setOAuthConsumerSecret(csecret)
                    .setOAuthAccessToken(atoken)
                    .setOAuthAccessTokenSecret(atokensecret);
            tf = new TwitterFactory(of.build()); 
            System.out.println("try block");
            twitter4j.Twitter twitter = tf.getInstance();
            User user = twitter.showUser(twitter.getId());
            System.out.println("Location : "+user.getLocation());
            System.out.println("Followers : "+user.getFollowersCount());
            System.out.println("Friends : "+user.getFriendsCount());
            System.out.println("Favourites : "+user.getFavouritesCount());
            System.out.println("Twitter Name : "+user.getName());
            System.out.println("Twitter Id Name : "+user.getScreenName());
            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/socirank", "root", "");
            PreparedStatement ps=con.prepareStatement("insert into reg (tid,name,pass,mobile,email,place,ckey,csecret,atoken,atokensecret) values ('"+tid+"','"+name+"','"+pass+"','"+mobile+"','"+email+"','"+place+"','"+ckey+"','"+csecret+"','"+atoken+"','"+atokensecret+"') ");
            ps.executeUpdate();                
            out.println("<script>"
                        +"alert('Registration Process Completed')"
                        +"</script>");            
            RequestDispatcher rd = request.getRequestDispatcher("userlogin.jsp");
            rd.include(request, response);      
         }
        catch (Exception ex) 
        {
            System.out.println("catch block");
            //System.out.println(ex);
             out.println("<script>"
                        +"alert('Check Your Twitter Credentials Details')"
                        +"</script>");              
            RequestDispatcher rd = request.getRequestDispatcher("userregister.jsp");
            rd.include(request, response); 
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
