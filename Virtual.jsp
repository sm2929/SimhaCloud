<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.*"%>
<%@ include file="connect.jsp"%>
<%@page
	import="java.util.*,java.security.Key,java.util.Random,javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec,org.bouncycastle.util.encoders.Base64"%>
<%@ page
	import="java.sql.*,java.util.Random,java.io.PrintStream,java.io.FileOutputStream,java.io.FileInputStream,java.security.DigestInputStream,java.math.BigInteger,java.security.MessageDigest,java.io.BufferedInputStream"%>
<%@ page
	import="java.security.Key,java.security.KeyPair,java.security.KeyPairGenerator,javax.crypto.Cipher"%>
<%@page
	import="java.util.*,java.text.SimpleDateFormat,java.util.Date,java.io.FileInputStream,java.io.FileOutputStream,java.io.PrintStream"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>SHEDS: A Simple and Secure Cost Efficient Data Storage in Heterogeneous Multiple Cloud </title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/coin-slider.css" />
<script type="text/javascript" src="js/cufon-yui.js"></script>
<script type="text/javascript" src="js/droid_sans_400-droid_sans_700.font.js"></script>
<script type="text/javascript" src="js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript" src="js/coin-slider.min.js"></script>
<style type="text/css">
<!--
.style1 {color: #FF6666}
.style2 {color: #0000FF}
.style3 {color: #00FF00}
-->
</style>
</head>
<body>
<div class="main">
  <div class="header">
    <div class="header_resize">
      <div class="logo">
   <h1><a href="index.html">SHEDS</span> <small>A Simple and Secure Cost Efficient Data Storage in Heterogeneous Multiple Cloud </small></a></h1>
      </div>
      <div class="clr"></div>
      <div class="menu_nav">
        <ul>
          <li ><a href="index.html"><span>Home Page</span></a></li>
          <li class="active"><a href="DataOwner.html"><span>Data Owner </span></a></li>
          <li><a href="ProxyServer.html"><span>Proxy Server</span></a></li>
          <li><a href="CloudServer.html"><span>CloudServer</span></a></li>
          <li><a href="EndUser.html"><span>EndUser</span></a></li>
        </ul>
      </div>
      <div class="clr"></div>
      <div class="slider">
        <div id="coin-slider"> <a href="#"><img src="images/slide1.jpg" width="960" height="313" alt="" /> </a> <a href="#"><img src="images/slide2.jpg" width="960" height="313" alt="" /> </a> <a href="#"><img src="images/slide3.jpg" width="960" height="313" alt="" /> </a> </div>
        <div class="clr"></div>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="content">
    <div class="content_resize">
      <div class="mainbar">
        <div class="article">
        <h1>VM Allocation Details</h1>
        <%
        	try {
        		String cn = request.getParameter("cloudn");
        		String vm = request.getParameter("vm");
        		String vmm = request.getParameter("vmm");//ch
        		String price = "";
        		int threshold=0;
        		//	Rackspace
        		// Amazon S3
        		//	Windows Azure
        		//	Aliyun OSS
        		String tbl = "";
        		String oname=(String)application.getAttribute("onname");
                %>
     		   <h2>1   <%=cn %></h2>
     		   <%
        		if (cn.equalsIgnoreCase("Rackspace")) {
        			tbl = "charm_rvmcost";
        		} else if (cn.equalsIgnoreCase("Amazon S3")) {
        			tbl = "charm_avmcost";
        		} else if (cn.equalsIgnoreCase("Windows Azure")) {
        			tbl = "charm_wvmcost";
        		} else if (cn.equalsIgnoreCase("Aliyun OSS")) {
        			tbl = "charm_aovmcost";
        		}
     		  %>
    		   <h2>1   <%=tbl %></h2>
    		   <%
        		String query9 = "SELECT * FROM " + tbl + " where memory='"+vmm+"'";

        		Statement st15 = connection.createStatement();
        		ResultSet rs15 = st15.executeQuery(query9);

        		Date date1 = null, date2 = null;
        		Date nowor = null;

        		while (rs15.next()) {

        			String d1 = rs15.getString(2);
        			String d2 = rs15.getString(3);
        			String clouname = rs15.getString(4);

        			if (clouname.equalsIgnoreCase(cn)
        					&& d1.equalsIgnoreCase(vmm)) {
        				int v = vmm.length();
        				if (v > 0 && v <=20000 ) {
        					threshold = 500;
        				}else
        				if (v > 20001 && v <=40000 ) {
        					threshold = 1000;
        				}else
          				if (v > 40001 && v <=60000 ) {
        					threshold = 1500;
        				}else
          				if (v > 60001 && v <=80000 ) {
        					threshold = 2000;
        				}else
          				if (v > 80001 && v <=100000 ) {
        					threshold = 2500;
        				}
          				
          				
        				price = d2;

        				SimpleDateFormat sdfDate = new SimpleDateFormat(
        						"dd/MM/yyyy");
        				SimpleDateFormat sdfTime = new SimpleDateFormat(
        						"HH:mm:ss");

        				Date now = new Date();

        				String strDate = sdfDate.format(now);
        				String strTime = sdfTime.format(now);
        				String dt = strDate + "   " + strTime;
						int a=0;
        				String strQuery4 = "insert into charm_memcons(ownername,cloudname,vmused,remvm,dt) values('"+oname+"','"
						+ cn
						+ "','"
						+ a
						+ "','"
						+ vmm
						+ "','" + dt + "')";
				connection.createStatement().executeUpdate(
						strQuery4);
						

        				if (cn.equalsIgnoreCase("Rackspace")) {

        					String strQuery25 = "insert into charm_RackspaceVm(ownername,cloudname,vm,vmmem,cost,dt) values('"+oname+"','"
        							+ cn
        							+ "','"
        							+ vm
        							+ "','"
        							+ vmm
        							+ "','"
        							+ price + "','" + dt + "')";
        					connection.createStatement().executeUpdate(
        							strQuery25);
									
									String strQueryT = "insert into charm_RackspaceTresh(ownername,cloudname,vm,vmmem,cost,threshold,dt) values('"+oname+"','"
        							+ cn
        							+ "','"
        							+ vm
        							+ "','"
        							+ vmm
        							+ "','"
        							+ price + "','"+threshold+"','" + dt + "')";
        					connection.createStatement().executeUpdate(
        							strQueryT);
									
									
        %><h3>Created Virtal Machine <%=vm%> of <%=vmm%> in <%=cn%> for Rs.<%=price%> <%=threshold %></h3>
<%
	}
				if (cn.equalsIgnoreCase("Amazon S3")) {

					String strQuery25 = "insert into charm_AmazonS3Vm(ownername,cloudname,vm,vmmem,cost,dt) values('"+oname+"','"
							+ cn
							+ "','"
							+ vm
							+ "','"
							+ vmm
							+ "','"
							+ price + "','" + dt + "')";
					connection.createStatement().executeUpdate(
							strQuery25);
									String strQueryT = "insert into charm_AmazonS3Tresh(ownername,cloudname,vm,vmmem,cost,threshold,dt) values('"+oname+"','"
        							+ cn
        							+ "','"
        							+ vm
        							+ "','"
        							+ vmm
        							+ "','"
        							+ price + "','"+threshold+"','" + dt + "')";
        					connection.createStatement().executeUpdate(
        							strQueryT);
							
							
%><h3>Created Virtal Machine <%=vm%> of <%=vmm%> in <%=cn%> for Rs.<%=price%> <%=threshold %></h3>
<%
	//connection.prepareStatement("insert into selcsp_enduser(name,pass,email,mobile,addr,dob,location,cloudname,servicetime,imagess) values(?,?,?,?,?,?,?,?,?,?)");
				}

				if (cn.equalsIgnoreCase("Windows Azure")) {

					String strQuery25 = "insert into charm_WindowsAzureVm(ownername,cloudname,vm,vmmem,cost,dt) values('"+oname+"','"
							+ cn
							+ "','"
							+ vm
							+ "','"
							+ vmm
							+ "','"
							+ price + "','" + dt + "')";
					connection.createStatement().executeUpdate(
							strQuery25);
									String strQueryT = "insert into charm_WindowsAzureTresh(ownername,cloudname,vm,vmmem,cost,threshold,dt) values('"+oname+"','"
        							+ cn
        							+ "','"
        							+ vm
        							+ "','"
        							+ vmm
        							+ "','"
        							+ price + "','"+threshold+"','" + dt + "')";
        					connection.createStatement().executeUpdate(
        							strQueryT);
%><h3>Created Virtal Machine <%=vm%> of <%=vmm%> in <%=cn%> for Rs.<%=price%></h3>
<%
	}//

				if (cn.equalsIgnoreCase("Aliyun OSS")) {

					String strQuery25 = "insert into charm_AliyunOSSVm(ownername,cloudname,vm,vmmem,cost,dt) values('"+oname+"','"
							+ cn
							+ "','"
							+ vm
							+ "','"
							+ vmm
							+ "','"
							+ price + "','" + dt + "')";
					connection.createStatement().executeUpdate(
							strQuery25);
									String strQueryT = "insert into charm_AliyunOSSTresh(ownername,cloudname,vm,vmmem,cost,threshold,dt) values('"+oname+"','"
        							+ cn
        							+ "','"
        							+ vm
        							+ "','"
        							+ vmm
        							+ "','"
        							+ price + "','"+threshold+"','" + dt + "')";
        					connection.createStatement().executeUpdate(
        							strQueryT);
%><h3>Created Virtal Machine <%=vm%> of <%=vmm%> in <%=cn%> for Rs.<%=price%> <%=threshold %></h3>
<%
	}//

			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
%>

        </div>
      </div>
      <div class="sidebar">
        <div class="searchform">
          <form id="formsearch" name="formsearch" method="post" action="#">
            <span>
            <input name="editbox_search" class="editbox_search" id="editbox_search" maxlength="80" value="Search our ste:" type="text" />
            </span>
            <input name="button_search" src="images/search.gif" class="button_search" type="image" />
          </form>
        </div>
        <div class="clr"></div>
        <div class="gadget">
           <h2 class="star"><span>Owner Menu</span></h2>
           <div class="clr"></div>
         <ul class="sb_menu">
           <li><a href="GetCloudCost.jsp">Find Cost and Memory</a></li>
           <li><a href="PurchaseVm.jsp">Purchase VM</a></li>
            <li><a href="Vmdetails.jsp">My VM Details</a></li>
            <li><a href="Upload.jsp">Upload</a></li>
            <li><a href="Verify.jsp">Verify</a></li>
			<li><a href="Migrate.jsp">Migrate</a></li>
			<li><a href="VReq.jsp">View Request</a></li>
            <li><a href="ViewOwnerDetails.jsp">View Owner Files </a></li>
  
            <li><a href="index.html">Log Out</a></li>

          </ul>
        </div>
        <div class="gadget">
          <h2 class="star"><span>SHEDS Menu </span></h2>
          <div class="clr"></div>
          <ul class="ex_menu">
            <li><a href="http://www.dreamtemplate.com/">Pricing Models of Mainstream Clouds</a><br />
            </li>
            <li><a href="http://www.templatesold.com/">Erasure coding</a></li>
            <li><a href="http://www.imhosted.com/">Combining Replication and Erasure Coding</a><br />
            </li>
            <li><a href="http://www.megastockphotos.com/">Comparison of Data Hosting Modes</a><br />
            </li>
           
          </ul>
        </div>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="fbg">
    <div class="fbg_resize">
      <div class="col c1">
        <h2><span>Image</span> Gallery</h2>
        <a href="#"><img src="images/gal1.jpg" width="75" height="75" alt="" class="gal" /></a> <a href="#"><img src="images/gal2.jpg" width="75" height="75" alt="" class="gal" /></a> <a href="#"><img src="images/gal3.jpg" width="75" height="75" alt="" class="gal" /></a> <a href="#"><img src="images/gal4.jpg" width="75" height="75" alt="" class="gal" /></a> <a href="#"><img src="images/gal5.jpg" width="75" height="75" alt="" class="gal" /></a> <a href="#"><img src="images/gal6.jpg" width="75" height="75" alt="" class="gal" /></a> </div>
      <div class="col c2">
        <h2><span>Multi-cloud data hosting</span></h2>
        <p align="justify">Multi-cloud data hosting received wide ttention from researchers, customers, and . The basic principle of multi-cloud (data hosting) is distribute data across multiple clouds to gain enhanced redundancy and prevent the vendor lock-in risk, as shownThe potential prevalence of multi-cloud is illustrated in three<br />
          folds. First, there have been a few researches conducted on multi-cloud. DepSky guarantees data availability and security  on multiple clouds.</p>
      </div>
      <div class="col c3">
        <h2><span>Vendor lock-in risk</span></h2>
        <p>Facing numerous cloud vendors as well 
          as their heterogenous performances/policies, customers may 
          be perplexed with which cloud(s) are suitable for storing their 
        data and what hosting strategy is cheaper.</p>
        <p>The general status
          quo is that customers usually put their data into a single cloud 
        and then simply trust to luck.</p>
      </div>
      <div class="clr"></div>
    </div>
  </div>
  <div class="footer">
    <div class="footer_resize">
      <p class="lf"></p>
      <p class="rf"></p>
      <div style="clear:both;"></div>
    </div>
  </div>
</div>
<div align=center></div></body>
</html>
