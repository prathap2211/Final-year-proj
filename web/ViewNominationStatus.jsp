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
                        <li><a href="ViewMyNomineeInfo.jsp"><span>View My Nominee Info</span></a></li>
                        <li><a href="ViewNominationStatus.jsp"><span>View Nomination Status</span></a></li>
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
                        ps=con.prepareStatement("select * from NomineeRegistration where nominee_id=?");
                        ps.setString(1, session.getAttribute("NomineeId").toString());
                        rs=ps.executeQuery();
                        if(rs.next()){
                    %>
                    <center>
                    <table cellspacing="15">
                        <tr>
                            <th colspan="2">Nominee Status</th>
                        </tr>
                        <tr>
                            <td>Nominee Id</td>
                            <td><%=rs.getString(1)%></td>
                        </tr>
                        <tr>
                            <td>Nominee Name</td>
                            <td><%=rs.getString(2)%></td>
                        </tr>
                        <tr>
                            <td>State</td>
                            <td><%=rs.getString(9)%></td>
                        </tr>
                        <tr>
                            <td>Constituency</td>
                            <td><%=rs.getString(10)%></td>
                        </tr>
                        <tr>
                            <td>Party Name</td>
                            <td><%=rs.getString(17)%></td>
                        </tr>
                        <tr>
                            <td>Nomination Date</td>
                            <td><%=rs.getString(19)%></td>
                        </tr>
                        <tr>
                            <td>Nomination Status</td>
                            <td><%=rs.getString(20)%></td>
                        </tr>
                        <tr>
                            <td>Reason</td>
                            <td><%=rs.getString(21)%></td>
                        </tr>
                    </table>
                    </center>
                    <%
                        }
                        rs.close();
                        ps.close();
                    %>
                    <br><br><br><br><br><br></br>
                </div>
                <div id="sidebar" style="line-height: 35px">
                    <h1>Voter Links</h1>
                    <ul class="sidemenu">
                        <li><a href="ViewMyNomineeInfo.jsp">View My Nominee Info</a></li>
                        <li><a href="ViewNominationStatus.jsp">View Nomination Status</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
            <div id="footer"> <span id="footer-left"> Valid: <a href="http://validator.w3.org/check?uri=referer">XHTML</a> | <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> </span> <span id="footer-right"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Contact Us</a> </span> </div>
    </div>
    </body>
</html>