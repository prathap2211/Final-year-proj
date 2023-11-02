<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                        <li id="current"><a href="index.jsp"><span>Home</span></a></li>
                        <li><a href="AdminLogin.jsp"><span>Admin</span></a></li>
                        <li><a href="FieldOfficer.jsp"><span>Field Officer</span></a></li>
                        <li><a href="NomineeLogin.jsp"><span>Nominee</span></a></li>
                        <li><a href="VoterLogin.jsp"><span>Voter</span></a></li>
                        <li><a href="Contact.jsp"><span>Contact Us</span></a></li>
                        <li><a href="About.jsp"><span>About Us</span></a></li>
                    </ul>
                </div>
            </div>
            <div id="content-wrap">
                <div id="main"> <a name="TemplateInfo"></a>
                    <h1>E-Voting</h1>
                    <form name="form1" action="AdminLogin.jsp" method="POST">
                        <table cellspacing="10" align="center">
                            <tr>
                                <th colspan="2" style="font-size: 20px;">Admin Login</th>
                            </tr>
                            <tr>
                                <td>User Id</td>
                                <td><input type="text" name="t1" value="" required /></td>
                            </tr>
                            <tr>
                                <td>Password</td>
                                <td><input type="password" name="t2" value="" required /></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <input type="submit" value="Submit" name="s1" />
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%
                        if (request.getParameter("t1") != null) {
                            String uid = request.getParameter("t1");
                            String pwd = request.getParameter("t2");
                            
                            if (uid.equals("Admin") && pwd.equals("Admin")) {
                                response.sendRedirect("AdminHome.jsp");
                            }
                            else {
                                out.println("<span style='color:red;'>Unauthorized login</span>");
                            }
                        }
                    %>
                    <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br></br>
                </div>
                <div id="sidebar" style="line-height: 35px">
                    <h1>Sidebar Menu</h1>
                    <ul class="sidemenu">
                        <li><a href="index.jsp">Home</a></li>
                        <li><a href="AdminLogin.jsp">Admin</a></li>
                        <li><a href="FieldOfficer.jsp">Field Officer</a></li>
                        <li><a href="NomineeRegistration.jsp">Nominee Registration</a></li>
                        <li><a href="NomineeLogin.jsp">Nominee</a></li>
                        <li><a href="VoterLogin.jsp">Voter</a></li>
                        <li><a href="Contact.jsp">Contact Us</a></li>
                        <li><a href="About.jsp">About Us</a></li>
                    </ul>
                </div>
            </div>
        <div id="footer"> <span id="footer-left"> Valid: <a href="http://validator.w3.org/check?uri=referer">XHTML</a> | <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> </span> <span id="footer-right"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Contact Us</a> </span> </div>
    </div>
    </body>
</html>