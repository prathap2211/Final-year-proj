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
                        <li><a href="ElectionDate.jsp"><span>Election Date</span></a></li>
                        <li><a href="NomineeInfo.jsp"><span>Nominee Info</span></a></li>
                        <li><a href="VoterInfoByAdmin.jsp"><span>Voter Info</span></a></li>
                        <li><a href="FieldOfficerInfo.jsp"><span>Field Officer Info</span></a></li>
                        <li><a href="DeclareResult.jsp"><span>Declare Result</span></a></li>
                        <li><a href="ResetResult.jsp"><span>Reset Result</span></a></li>
                        <li><a href="logout.jsp"><span>Logout</span></a></li>
                    </ul>
                </div>
            </div>
            <div id="content-wrap">
                <div id="main"> <a name="TemplateInfo"></a>
                    <h1>E-Voting</h1>
                    <form name="form1" action="ElectionDate.jsp" method="post">
                        <table cellspacing="10" align="center">
                            <tr>
                                <th colspan="2" style="font-size: 20px;">Election Date Proclaim</th>
                            </tr>
                            <tr>
                                <td>State</td>
                                <td>
                                    <select name="state">
                                        <option>--Select State--</option>
                                        <option value="Tamilnadu">Tamilnadu</option>
                                        <option value="Kerala">Kerala</option>
                                        <option value="Andhra Pradesh">Andhra Pradesh</option>
                                        <option value="Karnataka">Karnataka</option>
                                        <option value="Maharashtra">Maharashtra</option>
                                        <option value="Gujarat">Gujarat</option>
                                        <option value="Orissa">Orissa</option>
                                        <option value="Delhi">Delhi</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Election Date</td>
                                <td><input type="date" name="edate"/></td>
                            </tr>
                            <tr>
                                <td>Start Time</td>
                                <td><input type="time" name="start_time"/></td>
                            </tr>
                            <tr>
                                <td>End Time</td>
                                <td><input type="time" name="end_time"/></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <input type="submit" name="s1" value="Submit"/>
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                        if(request.getParameter("s1")!=null){
                            String state=request.getParameter("state");
                            String edate=request.getParameter("edate");
                            String stime=request.getParameter("start_time");
                            String etime=request.getParameter("end_time");
                            ps=con.prepareStatement("insert into ElectionDate values(?,?,?,?)");
                            ps.setString(1, state);
                            ps.setString(2, edate);
                            ps.setString(3, stime);
                            ps.setString(4, etime);
                            ps.executeUpdate();
                            ps.close();
                            out.println("Election Date Info Stored!!");
                        }
                    %>
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br></br><br></br>
                </div>
                <div id="sidebar" style="line-height: 35px">
                    <h1>Admin Links</h1>
                    <ul class="sidemenu">
                        <li><a href="ElectionDate.jsp">Election Date</a></li>
                        <li><a href="FieldOfficerRegistration.jsp">Field Officer Registration</a></li>
                        <li><a href="NomineeInfo.jsp">Nominee Info</a></li>
                        <li><a href="VoterInfoByAdmin.jsp">Voter Info</a></li>
                        <li><a href="FieldOfficerInfo.jsp">Field Officer Info</a></li>
                        <li><a href="DeclareResult.jsp">Declare Result</a></li>
                        <li><a href="ViewResultByAdmin.jsp">View Election Result</a></li>
                        <li><a href="ResetResult.jsp">Reset Result</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
        <div id="footer"> <span id="footer-left"> Valid: <a href="http://validator.w3.org/check?uri=referer">XHTML</a> | <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> </span> <span id="footer-right"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Contact Us</a> </span> </div>
    </div>
    </body>
</html>