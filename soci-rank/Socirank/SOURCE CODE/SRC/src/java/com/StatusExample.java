package com;


import java.io.File;
import java.io.FileInputStream;
import java.net.URL;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import static javax.servlet.SessionTrackingMode.URL;
import javax.swing.ImageIcon;
import twitter4j.DirectMessage;
import twitter4j.IDs;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.User;
import twitter4j.api.FriendsFollowersResources;
import twitter4j.auth.AccessToken;
import twitter4j.conf.ConfigurationBuilder;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author DLK 1
 */
public class StatusExample 
{
    ConfigurationBuilder of;
    TwitterFactory tf;
    public StatusExample()
    {
    of = new ConfigurationBuilder();
            of.setDebugEnabled(true)
                    .setOAuthConsumerKey("xVhKDw71OQ9Xfc9SJ4j99nMvH")
                    .setOAuthConsumerSecret("1uQV59R6VIraj6y1vFNwJYpruyWWnJyKaroQbPVx4SWHKqjmHh")
                    .setOAuthAccessToken("715233526774280192-PpYposv0g2pTVU6XkpvF1Takbg9pIxx")
                    .setOAuthAccessTokenSecret("O1QmIydkIw2x8HYoqjnKnplH6wisU4qS9dsUpHJNv5Ky9");
    tf = new TwitterFactory(of.build());       
    }
    public void posttweet()
    {
    try {
    // The factory instance is re-useable and thread safe.    
    twitter4j.Twitter twitter = tf.getInstance();
    Status status = twitter.updateStatus("");
    System.out.println("Successfully updated the status to [" + status.getText() + "].");
        } catch (TwitterException ex) {
            Logger.getLogger(StatusExample.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void gettimeline()
    {
    try {
            System.out.println("Get home timeline");
            System.out.println("--------------------------------------");
            twitter4j.Twitter twitter = tf.getInstance();
            List<Status> statuses = twitter.getHomeTimeline();
            for (Status status : statuses) {
                System.out.println(status.getUser().getName() + "-------" +
                        status.getText());
            }   } catch (TwitterException ex) {
            Logger.getLogger(StatusExample.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void search()
    {
        try {
            // The factory instance is re-useable and thread safe.
            twitter4j.Twitter twitter = tf.getInstance();
            Query query = new Query("BJP Modi");
            QueryResult result = twitter.search(query);
            for (Status status : result.getTweets()) {
                System.out.println("@" + status.getUser().getScreenName() + "------------" + status.getText());
            }   } catch (TwitterException ex) {
            Logger.getLogger(StatusExample.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void follow()
    {
    twitter4j.Twitter twitter = tf.getInstance();
    String twitterScreenName;
    try 
    {
        twitterScreenName = twitter.getScreenName();
        IDs followerIDs = twitter.getFollowersIDs(twitterScreenName, -1);
        long[] ids = followerIDs.getIDs();
        System.out.println("Followers count : "+ids.length);        
    }
    catch(Exception ex)
    {
        System.out.println(ex);
    }
    }
    
    private void getDetails() 
    {
        try {
            twitter4j.Twitter twitter = tf.getInstance();
            User user = twitter.showUser("");
            if (user.getStatus() != null) 
            {
                System.out.println("@" + user.getScreenName() + " - " + user.getDescription());
                System.out.println(user.getLocation());
            } else 
            {
                System.out.println("@" + user.getScreenName());
            }
        } catch (Exception ex) {
            Logger.getLogger(StatusExample.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public void profilepic()
    {
        try 
        {
            twitter4j.Twitter twitter = tf.getInstance();
            User user = twitter.showUser(twitter.getId());
            System.out.println("Location : "+user.getLocation());
            System.out.println("Followers : "+user.getFollowersCount());
            System.out.println("Friends : "+user.getFriendsCount());
            System.out.println("Favourites : "+user.getFavouritesCount());
            System.out.println("Twitter Name : "+user.getName());
            System.out.println("Twitter Id Name : "+user.getScreenName());
            String url = user.getProfileImageURL();
            ImageIcon img = new ImageIcon(url);
            System.out.println(img);               
        } 
        catch (Exception ex) 
        {
            System.out.println(ex);
        } 
    }
    public void lasttweet()
    {
   try {
       twitter4j.Twitter twitter = tf.getInstance();
       List<Status> statusList = null;
       User user = twitter.showUser(twitter.getId());
       statusList = twitter.getUserTimeline(user.getScreenName());
            System.out.println(statusList.get(0).getText());  
//       for (Status status : statusList) {
//           System.out.println(status.toString());
//       }
   } catch (Exception ex) {
            System.out.println(ex);
    }   
    }
    public void sendmessage()
    {
        try {
            twitter4j.Twitter twitter = tf.getInstance();
            DirectMessage directMessage = twitter.sendDirectMessage("", "");
        } catch (TwitterException ex) {
            Logger.getLogger(StatusExample.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public static void main(String[] args) 
    {
        StatusExample ex = new StatusExample();        
       // ex.posttweet();   // post status
        // ex.gettimeline();   // get home timeline
        // ex.search();    // search tweet
        // ex.follow();    // follow tweet
        // ex.getDetails(); // get profile details
        // ex.profilepic();  // get profile pictures
        // ex.lasttweet();   // get last tweet
        ex.sendmessage();
    }
}
