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
                    <%!
                        ResultSet rs;
                        String state, constituency, nominee_id;
                    %>                    
                    <%
                        ps=con.prepareStatement("select * from VoterRegistration where voter_id=?");
                        ps.setString(1, session.getAttribute("VoterId").toString());
                        rs=ps.executeQuery();
                        if(rs.next()){
                            state=rs.getString(10);
                            constituency=rs.getString(11);
                        }
                        rs.close();
                        ps.close();
                    %>
                    <center>
                        <table cellspacing="5" width="50%">
                        <tr>
                            <th colspan="2" style="font-size: large">VOTER'S POLLING PAGE</th>
                        </tr>
                        <tr>
                            <th>State</th>
                            <td><%=state%></td>
                        </tr>
                        <tr>
                            <th>Constituency</th>
                            <td><%=constituency%></td>
                        </tr>
                    </table>
                    </center>
                        <hr style="height: 3px;" color="black">
                    <table cellspacing="10" width="100%">    
                        <tr>
                            <th>NOMINEE ID</th>
                            <th>NOMINEE NAME</th>
                            <th>PARTY NAME</th>
                            <th>PARTY SYMBOL</th>
                            <th>VOTE ENTRY</th>
                        </tr>
                    <%
                        ps=con.prepareStatement("select * from NomineeRegistration where state=? and constituency=? and status='Accepted'");
                        ps.setString(1, state);
                        ps.setString(2, constituency);
                        rs=ps.executeQuery();
                        while(rs.next()){                     
                            nominee_id=rs.getString(1);
                    %>
                    
                    <tr>
                        <td><%=nominee_id%></td>
                        <td><%=rs.getString(2)%></td>
                        <td><%=rs.getString(17)%></td>
                        <td><img src="PartySymbols/<%=rs.getString(18)%>" style="height:50px; width:60px;"/></td>
                        <td><a href="PollingAccumulation.jsp?nominee_id=<%=nominee_id%>" style="color: blue;font-weight: bold;font-size: 18px;">Vote</a></td>
                    </tr>                    
                    <%
                        }
                    %>
                    </table>
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></br>
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