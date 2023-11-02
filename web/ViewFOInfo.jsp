<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="db.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>E-Voting</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link rel="stylesheet" href="images/Techmania.css" type="text/css" />
    </head>
    <body>
        <div id="wrap">
            <div id="header">
                <h1 id="logo-text">E-Voting<span class="gray">&nbsp;using Block Chain</span></h1>
                <h2 id="slogan">E-Voting</h2>
                <div id="header-tabs">
                    <ul>
                        <li><a href="ViewFOInfo.jsp"><span>View My Nominee Info</span></a></li>
                        <li><a href="VoterInfo.jsp"><span>View Voter Info</span></a></li>
                        <li><a href="ViewSelectedVoters.jsp"><span>View Selected Voters</span></a></li>
                        <li><a href="logout.jsp"><span>Logout</span></a></li>
                    </ul>
                </div>
            </div>
            <div id="content-wrap">
                <div id="main"> <a name="TemplateInfo"></a>
                    <h1>E-Voting</h1>
                    <%!
                        ResultSet rs;
                    %>
                    <%
                        ps=con.prepareStatement("select * from FieldOfficer where userid=?");
                        ps.setString(1, session.getAttribute("FieldOfficerId").toString());
                        rs=ps.executeQuery();
                        if(rs.next()){
                        
                    %>
                    <center>
                    <table cellspacing="10">
                        <tr>
                            <th colspan="2" style="font-size: x-large;">Field Officer Info</th>
                        </tr>
                        <tr>
                            <th style="text-align: left;">Field Officer Id</th>
                            <td><%=rs.getString(1)%></td>
                        </tr>
                        <tr>
                            <th style="text-align: left;">Field Officer Name</th>
                            <td><%=rs.getString(2)%></td>
                        </tr>
                        <tr>
                            <th style="text-align: left;">State(In Charge )</th>
                            <td><%=rs.getString(5)%></td>
                        </tr>
                        <tr>
                            <th style="text-align: left;">Constituency(In Charge )</th>
                            <td><%=rs.getString(6)%></td>
                        </tr>
                    </table>
                    </center>
                    <%
                        }
                        rs.close();
                        ps.close();
                    %>
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br></br>
                </div>
                <div id="sidebar" style="line-height: 35px">
                    <h1>Field Officer Links</h1>
                    <ul class="sidemenu">
                        <li><a href="ViewFOInfo.jsp">View FO Info</a></li>
                        <li><a href="VoterInfo.jsp">View Voter Info</a></li>
                        <li><a href="ViewSelectedVoters.jsp">View Selected Voters</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        <div id="footer"> <span id="footer-left"> Valid: <a href="http://validator.w3.org/check?uri=referer">XHTML</a> | <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> </span> <span id="footer-right"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Contact Us</a> </span> </div>
    </div>
    </body>
</html>