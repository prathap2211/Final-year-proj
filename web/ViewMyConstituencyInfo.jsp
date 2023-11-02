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
                        String state, constituency;
                        String nominee_id, nominee_name;
                    %>
                    
                    <table cellspacing="10">
                        <tr>
                            <th colspan="5" style="font-size: large;text-align: center;">View Constituency & Nominee Info</th>
                        </tr>
                        <tr>
                            <th>Nominee Id</th>
                            <th>Nominee Name</th>
                            <th>Party Name</th>
                            <th>Party Symbol</th>
                            <th>Full View</th>
                        </tr>
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
                        
                        ps=con.prepareStatement("select * from NomineeRegistration where state=? and constituency=? and status='Accepted'");
                        ps.setString(1, state);
                        ps.setString(2, constituency);
                        rs=ps.executeQuery();
                        while(rs.next()){
                            nominee_id=rs.getString(1);
                            nominee_name=rs.getString(2);
                    %>
                    <tr>
                        <td><%=nominee_id%></td>
                        <td><%=nominee_name%></td>
                        <td><%=rs.getString(17)%></td>
                        <td><img src="PartySymbols/<%=rs.getString(18)%>" style="height:50px;width:50px;"/></td>
                        <td><a href="ViewMyNomineeFullInfo.jsp?nominee_id=<%=nominee_id%>" style="color: blue;">Full View</a></td>
                    </tr>
                    
                    <%
                        }
                        rs.close();
                        ps.close();
                    %>
                    </table>
                    
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></br>
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