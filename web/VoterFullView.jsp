<%@page import="javax.crypto.*,javax.crypto.spec.SecretKeySpec,sun.misc.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.text.*,java.security.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
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
                        <li><a href="ViewFOInfo.jsp"><span>View My Nominee Info</span></a></li>
                        <li><a href="VoterInfo.jsp"><span>View Voter Info</span></a></li>
                        <li><a href="logout.jsp"><span>Logout</span></a></li>
                    </ul>
                </div>
            </div>
            <div id="content-wrap">
                <div id="main"> <a name="TemplateInfo"></a>
                    <h1>E-Voting</h1>
                    <%!
                        ResultSet rs;
                        int voter_id;
                        String mailid;
                        
                        public String generateSecretKey() {
                            SecureRandom r = new SecureRandom();
                            String s1 = "";
                            int n = r.nextInt();
                            s1 = Integer.toHexString(n);
                            return s1;
                        }

                    %>
                    <%
                        if(request.getParameter("voter_id")!=null){
                            voter_id=Integer.parseInt(request.getParameter("voter_id"));
                            session.setAttribute("VoterId", voter_id);
                        }
                        else{
                            voter_id=Integer.parseInt(session.getAttribute("VoterId").toString());
                        }
                        ps=con.prepareStatement("select * from VoterRegistration where voter_id=?");
                        ps.setInt(1, voter_id);
                        rs=ps.executeQuery();
                        if(rs.next()){
                            mailid=rs.getString(9);
                            session.setAttribute("MailId", mailid);
                    %>
                    <center>
                    <form name="form1" action="VoterFullView.jsp" method="post">
                    <table cellspacing="10">
                        <tr>
                            <th colspan="2" style="font-size: x-large;">View Voter Full Info</th>
                        </tr>
                        <tr>
                            <td>Voter Id</td>
                            <td><%=voter_id%></td>
                        </tr>
                        <tr>
                            <th>Voter Name</th>
                            <td><%=rs.getString(2)%></td>
                        </tr>
                        <tr>
                            <th>Gender</th>
                            <td><%=rs.getString(3)%></td>
                        </tr>
                        <tr>
                            <th>Father Name</th>
                            <td><%=rs.getString(5)%></td>
                        </tr>
                        <tr>
                            <th>D.O.B</th>
                            <td><%=rs.getString(6)%></td>
                        </tr>
                        <tr>
                            <th>Age</th>
                            <td><%=rs.getString(7)%></td>
                        </tr>
                        <tr>
                            <th>Address</th>
                            <td><%=rs.getString(8)%></td>
                        </tr>
                        <tr>
                            <th>Mail Id</th>
                            <td><%=mailid%></td>
                        </tr>
                        <tr>
                            <th>State</th>
                            <td><%=rs.getString(10)%></td>
                        </tr>
                        <tr>
                            <th>Constituency</th>
                            <td><%=rs.getString(11)%></td>
                        </tr>
                        <tr>
                            <th>Aadhaar No</th>
                            <td><%=rs.getString(12)%></td>
                        </tr>
                        <tr>
                            <th>Photo</th>
                            <td><img src="VoterPhotos/<%=rs.getString(13)%>" style="height:50px;width:50px;"/></td>
                        </tr>
                        <tr>
                            <th>Registered Date</th>
                            <td><%=rs.getString(14)%></td>
                        </tr>
                        <tr>
                            <th>Approval Status</th>
                            <td>
                                <input type="radio" name="acc_status" value="Accepted"/>Accept
                                <input type="radio" name="acc_status" value="Rejected"/>Reject
                            </td>
                        </tr>
                        <tr>
                            <th>Reason</th>
                            <td>
                                <textarea name="reason" style="width: 220px;height:75px"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" name="s1" value="Update"/></td>
                        </tr>
                    </table>
                    </form>
                    </center>
                    <%
                        }
                        rs.close();
                        ps.close();
                    %>
                    <%
                        if(request.getParameter("s1")!=null){
                            ps=con.prepareStatement("update VoterRegistration set status=?, reason=? where voter_id=?");
                            ps.setString(1, request.getParameter("acc_status"));
                            ps.setString(2, request.getParameter("reason"));
                            ps.setString(3, session.getAttribute("VoterId").toString());
                            ps.executeUpdate();
                            ps.close();
                                                        
                            
                            if(request.getParameter("acc_status").equals("Accepted")){
                                String walletcode=generateSecretKey();
                                mailid=session.getAttribute("MailId").toString();
                                ps=con.prepareStatement("select * from VoterList where voter_id=?");
                                ps.setString(1, session.getAttribute("VoterId").toString());
                                rs=ps.executeQuery();
                                if(rs.next()){
                                    rs.close();
                                    ps.close();
                                    ps=con.prepareStatement("update VoterList set walletcode=? where voter_id=?");
                                    ps.setString(1, walletcode);
                                    ps.setString(2, session.getAttribute("VoterId").toString());
                                    ps.executeUpdate();
                                    ps.close();
                                
                                }
                                else{
                                    ps=con.prepareStatement("insert into VoterList values(?,?)");
                                    ps.setString(1, session.getAttribute("VoterId").toString());
                                    ps.setString(2, walletcode);
                                    ps.executeUpdate();
                                    ps.close();
                                }
                                
                                
                                //Code Started for sending key to Mail ID
                                String data="Your Election Wallet Code is: "+walletcode;
                                boolean sessionDebug = true;
                                String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
                                String host = "smtp.gmail.com";
                                String from = "evotingsystem2604@gmail.com";
                                String user = from;
                                String pwd = "evoting@26";
                                String to = mailid;
                                String subject = "secret key";
                                String body = data;
                                Properties props = System.getProperties();

                                props.put("mail.host", host);
                                props.put("mail.transport.protocol", "smtp");
                                props.put("mail.smtp.auth", "true");
                                props.put("mail.smtp.", "true");
                                props.put("mail.smtp.port", "465");
                                props.put("mail.smtp.socketFactory.fallback", "false");
                                props.put("mail.smtp.socketFactory.class", SSL_FACTORY);

                                Session mailSession = Session.getDefaultInstance(props, null);
                                mailSession.setDebug(sessionDebug);
                                Message msg = new MimeMessage(mailSession);
                                msg.setFrom(new InternetAddress(from));
                                InternetAddress[] address = {new InternetAddress(to)};
                                msg.setRecipients(Message.RecipientType.TO, address);
                                msg.setSubject(subject);
                                msg.setContent(body, "text/html");
                                Transport transport = mailSession.getTransport("smtp");
                                transport.connect(host, user, pwd);
                                transport.sendMessage(msg, msg.getAllRecipients());
                                out.println("message successfully sent");
                                //Code Finished for sending key to Mail Id
                                
                                
                            }
                            out.println("Voter Info Updated!!");
                        }
                    %>
                    <br><br><br></br>
                </div>
                <div id="sidebar" style="line-height: 35px">
                    <h1>Field Officer Links</h1>
                    <ul class="sidemenu">
                        <li><a href="ViewFOInfo.jsp">View FO Info</a></li>
                        <li><a href="VoterInfo.jsp">View Voter Info</a></li>
                        <li><a href="logout.jsp">Logout</a></li>
                    </ul>
                </div>
            </div>
             <div id="footer"> <span id="footer-left"> Valid: <a href="http://validator.w3.org/check?uri=referer">XHTML</a> | <a href="http://jigsaw.w3.org/css-validator/check/referer">CSS</a> </span> <span id="footer-right"> <a href="#">Home</a> | <a href="#">About Us</a> | <a href="#">Contact Us</a> </span> </div>
    </div>
    </body>
</html>