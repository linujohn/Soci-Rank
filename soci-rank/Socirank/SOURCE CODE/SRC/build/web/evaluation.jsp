<%-- 
    Document   : evaluation
     
--%>
<%@page import="org.jfree.chart.entity.StandardEntityCollection"%>
<%@page import="java.awt.Color"%>
<%@page import="java.awt.BasicStroke"%>
<%@page import="org.jfree.chart.ChartRenderingInfo"%>
<%@page import="org.jfree.data.jdbc.JDBCPieDataset"%>
<%@page import="java.io.OutputStream"%>
<%@page import="org.jfree.chart.plot.PlotOrientation"%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.ChartUtilities"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="org.jfree.data.category.DefaultCategoryDataset"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
    OutputStream out1=response.getOutputStream();
    Connection connection = null;
try 
{
Class.forName("com.mysql.jdbc.Driver").newInstance();

connection=
DriverManager.getConnection("jdbc:mysql://localhost:3306/socirank","root","");
 JDBCPieDataset dataset = new JDBCPieDataset(connection);

    dataset.executeQuery("SELECT tname,nodew FROM news where NOT term='0' ORDER BY term DESC limit 10");
JFreeChart chart = ChartFactory.createPieChart
         ("Top 10 Prevalent News", dataset, true, true, false);
chart.setBorderPaint(Color.BLUE);
chart.setBorderStroke(new BasicStroke(10.0f));
chart.setBorderVisible(true);
if (chart != null) {
int width = 500;
int height = 350;
final ChartRenderingInfo info = new ChartRenderingInfo
                               (new StandardEntityCollection());
response.setContentType("image/png");

ChartUtilities.writeChartAsPNG(out1, chart, width, height,info);
}
}
catch (Exception e) 
{
e.printStackTrace();
}


%>