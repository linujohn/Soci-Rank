/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.ImageIcon;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.conf.ConfigurationBuilder;
 
public class login extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    String name="",pass="";
    String ckey="",csecret="",atoken="",atokensecret="";
     ConfigurationBuilder of;
    TwitterFactory tf;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException 
    {
        try {
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();            
            name=request.getParameter("name");
            pass=request.getParameter("pass");            
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/socirank", "root", "");
            PreparedStatement ps=con.prepareStatement("select * from reg where name='"+name+"' and pass='"+pass+"' ");
            ResultSet rs = ps.executeQuery();
            if(rs.next())
            {
            ckey=rs.getString("ckey");
            csecret=rs.getString("csecret");
            atoken=rs.getString("atoken");
            atokensecret=rs.getString("atokensecret");
            of = new ConfigurationBuilder();
            of.setDebugEnabled(true)
                    .setOAuthConsumerKey(ckey)
                    .setOAuthConsumerSecret(csecret)
                    .setOAuthAccessToken(atoken)
                    .setOAuthAccessTokenSecret(atokensecret);
            tf = new TwitterFactory(of.build()); 
            twitter4j.Twitter twitter = tf.getInstance();
            User user = twitter.showUser(twitter.getId());
            String loc=user.getLocation();
            int follow = user.getFollowersCount();
            int friends = user.getFriendsCount();
            int fav = user.getFavouritesCount();
            String aname = user.getName();
            String aid = user.getScreenName();
            String url1 = user.getProfileImageURL(); 
            String url = url1.replace("_normal.jpg", "_400x400.jpg");
            HttpSession session = request.getSession();
            session.setAttribute("name", name);
            session.setAttribute("ckey", ckey);
            session.setAttribute("csecret", csecret);
            session.setAttribute("atoken", atoken);
            session.setAttribute("atokensecret", atokensecret);
            session.setAttribute("loc", loc);
            session.setAttribute("follow", follow);
            session.setAttribute("friends", friends);
            session.setAttribute("fav", fav);
            session.setAttribute("aname", aname);
            session.setAttribute("aid", aid);
            session.setAttribute("url", url);
            out.println("<script>"
                        +"alert('Welcome "+name+" ')"
                        +"</script>");     
            RequestDispatcher rd = request.getRequestDispatcher("userhome.jsp");
            rd.include(request, response);      
            }
            else if(name.equals("admin")&&pass.equals("admin"))
            {
            out.println("<script>"
                        +"alert('Welcome Admin')"
                        +"</script>");                 
            RequestDispatcher rd = request.getRequestDispatcher("adminhome.jsp");
            rd.include(request, response);   
            }
            else
            {
            out.println("<script>"
                        +"alert('Invalid Username and Password')"
                        +"</script>");             
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.include(request, response);   
            }
        } catch (Exception ex) 
        {
            Logger.getLogger(login.class.getName()).log(Level.SEVERE, null, ex);
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
