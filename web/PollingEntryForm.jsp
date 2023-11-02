<%@page import="java.util.*,java.text.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="db.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>E-Voting</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link rel="stylesheet" href="images/Techmania.css" type="text/css" />
        <style>
            th{
                text-align: left;
            }
        </style>
    </head>
    <body>
        <div id="wrap">
            <div id="header">
                <h1 id="logo-text">E-Voting<span class="gray">&nbsp;using Block Chain</span></h1>
                <h2 id="slogan">E-Voting</h2>
                <div id="header-tabs">
                    <ul>
                        <li><a href="ViewElectionDate.jsp"><span>View Election Date</span></a></li>
                        <li><a href="ViewMyConstituencyInfo.jsp"><span>View My Constituency Info</span></a></li>
                        <li><a href="PollingEntryForm.jsp"><span>Polling Form</span></a></li>
                        <li><a href="ViewResultByVoter.jsp"><span>View Result</span></a></li>
                        <li><a href="logout.jsp"><span>Logout</span></a></li>
                    </ul>
                </div>
            </div>
            <div id="content-wrap">
                <div id="main"> <a name="TemplateInfo"></a>
                    <h1>E-Voting</h1>
                    <%!
                        PreparedStatement ps1, ps2;
                        ResultSet rs1, rs2;
                        String electionDate, stime, etime;
                    %>
                    <%
                        ps2=con.prepareStatement("select electiondate,starttime,endtime from electiondate where state=(select state from VoterRegistration where voter_id=?)");
                        ps2.setString(1, session.getAttribute("VoterId").toString());
                        rs2=ps2.executeQuery();
                        if(rs2.next()){
                            electionDate=rs2.getString(1);
                            stime=rs2.getString(2);
                            etime=rs2.getString(3);
                        }
                        rs2.close();
                        ps2.close();
                        
                        SimpleDateFormat fmt=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
                        java.util.Date sdate=fmt.parse(electionDate+" "+stime);
                        java.util.Date edate=fmt.parse(electionDate+" "+etime);
                        
                        java.util.Date now=new java.util.Date();
                        
                        if(now.after(sdate) && now.before(edate)){
                        
                        ps1=con.prepareStatement("select * from VotedStatus where VoterId=?");
                        ps1.setString(1, session.getAttribute("VoterId").toString());
                        rs1=ps1.executeQuery();
                        if(rs1.next()){
                            out.println("<center><h3>"+session.getAttribute("VoterId")+"&nbsp;, You've already voted.<br><br>Again you could not vote!!</h3></center>");
                        }
                        else{
                    %>                    
                    <form name="form1" action="PollingEntryForm.jsp" method="post">
                        <table cellspacing="10">
                            <tr>
                                <td>Enter Your Wallet Code</td>
                                <td><input type="text" name="t1"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" name="s1" value="Submit"/></td>
                            </tr>
                        </table>
                    </form>
                    <%
                        if(request.getParameter("s1")!=null){
                            String walletcode=request.getParameter("t1");
                            ps=con.prepareStatement("select * from VoterList where voter_id=? and walletcode=?");
                            ps.setString(1, session.getAttribute("VoterId").toString());
                            ps.setString(2, walletcode);
                            ResultSet rs=ps.executeQuery();
                            if(rs.next()){
                                response.sendRedirect("PollingPage.jsp");
                            }
                            else{
                                out.println("Invalid Wallet Code/PIN No");
                            }
                            rs.close();
                            ps.close();
                        }
                        }
                        }
                        else{
                            if(now.before(sdate))
                                out.println("<center><h3>"+session.getAttribute("VoterId")+"&nbsp;, Still Election Date has not come. Please wait for election date!!</h3></center>");
                            
                            if(now.after(edate))
                                out.println("<center><h3>"+session.getAttribute("VoterId")+"&nbsp;, Election Date & Time was Over. Sorry you can't vote at now!!</h3></center>");
                        }
                    %>
                    
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></br>
                </div>
                <div id="sidebar" style="line-height: 35px">
                    <h1>Voter Links</h1>
                    <ul class="sidemenu">
                        <li><a href="ViewElectionDate.jsp">View Election Date</a></li>
                        <li><a href="ViewMyConstituencyInfo.jsp">View My Constituency Info</a></li>
                        <li><a href="PollingEntryForm.jsp">Polling Form</a></li>
                        <li><a href="ViewResultByVoter.jsp">View Result</a></li>
                        <li><a href="ViewMyInfo.jsp">View My Voter Info</a></li>
                        <li><a href="ViewMyVoteStatus.jsp">View My Vote Status</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        <div id="footer"> <span id="footer-left"> Valid: <a href="http://validator.w3.org/check?uri=referer">XHTML</a> | <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> </span> <span id="footer-right"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Contact Us</a> </span> </div>
    </div>
    </body>
</html>