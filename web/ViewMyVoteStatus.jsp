<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                                  
                    <form name="form1" action="ViewMyVoteStatus.jsp" method="post">
                        <center>
                        <table cellspacing="10">
                            <tr>
                                <td>Enter Your Voting Transaction Id</td>
                                <td><input type="text" name="t1"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td><input type="submit" name="s1" value="Submit"/></td>
                            </tr>
                        </table>
                        </center>
                    </form>
                    <br>
                    <%
                        ResultSet rs;
                        if(request.getParameter("s1")!=null){
                            String trans_id=request.getParameter("t1");
                            ps=con.prepareStatement("select v1.nomineeid,v1.nomineename,v1.partyname,v1.constituency,v1.state from Voting v1, VotedStatus v2 where v2.transactionid=? and v2.voterid=? and v1.transactionid=v2.transactionid");
                            ps.setString(1, trans_id);
                            ps.setString(2, session.getAttribute("VoterId").toString());
                            rs=ps.executeQuery();
                            if(rs.next()){
                    %>
                    <center>
                    <table cellspacing="18">
                        <tr>
                            <th colspan="2" style="font-size: 18px;">Your Voting Status</th>
                        </tr>
                        <tr>
                            <th>Nominee Id</th>
                            <td><%=rs.getString(1)%></td>
                        </tr>
                        <tr>
                            <th>Nominee Name</th>
                            <td><%=rs.getString(2)%></td>
                        </tr>
                        <tr>
                            <th>Party Name</th>
                            <td><%=rs.getString(3)%></td>
                        </tr>
                        <tr>
                            <th>Constituency</th>
                            <td><%=rs.getString(4)%></td>
                        </tr>
                        <tr>
                            <th>State</th>
                            <td><%=rs.getString(5)%></td>
                        </tr>
                        <tr>
                            <th>Vote Status</th>
                            <td>Accepted & Counted</td>
                        </tr>
                    </table>
                    </center>
                    <%
                            }
                            else{
                                out.println("<h3 style='color:red;text-align:center;'>This is not your Transaction Id!!</h3><br><br><br><br><br><br><br><br><br><br><br><br><br><br>");
                            }
                        }
                    %>
                    <br><br><br><br><br><br><br></br>
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