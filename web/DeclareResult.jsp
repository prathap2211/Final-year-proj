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
                    <form name="form1" action="DeclareResult.jsp" method="post">
                        <table cellspacing="15" align="center">
                            <tr>
                                <th colspan="2" style="font-size: 20px;">Election Result Calculation</th>
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
                                <td></td>
                                <td>
                                    <input type="submit" name="s1" value="Declare Result"/>
                                </td>
                            </tr>
                        </table>
                    </form>
                    <%!
                        PreparedStatement ps1, ps2, ps3;
                        ResultSet rs, rs1, rs2, rs3;
                        boolean flag=true;
                        String state;
                    %>
                    <%
                        if(request.getParameter("state")!=null){
                            state=request.getParameter("state");
                            ps3=con.prepareStatement("select * from electionresult where state=?");
                            ps3.setString(1, state);
                            rs3=ps3.executeQuery();
                            if(rs3.next()){
                                flag=false;
                            }
                            else{
                                ps=con.prepareStatement("select constituency from Constituencies where state=?");
                                ps.setString(1, state);
                                rs=ps.executeQuery();
                                while(rs.next()){
                                    String constituency=rs.getString(1);
                                    ps1=con.prepareStatement("select nominee_id,nominee_name,partyname from NomineeRegistration where state=? and constituency=? and status='Accepted'");
                                    ps1.setString(1, state);
                                    ps1.setString(2, constituency);
                                    rs1=ps1.executeQuery();
                                    while(rs1.next()){
                                        String nominee_id=rs1.getString(1);
                                        String nominee_name=rs1.getString(2);
                                        String partyName=rs1.getString(3);               
                                        int total=0;
                                    
                                        ps2=con.prepareStatement("select sum(polling) from Voting where nomineeid=?");
                                        ps2.setString(1, nominee_id);
                                        rs2=ps2.executeQuery();
                                        if(rs2.next())
                                            total=rs2.getInt(1);
                                        rs2.close();
                                        ps2.close();
                                    
                                    
                                        int sno=0;
                                        ps3=con.prepareStatement("select ifnull(max(sno),0)+1 from ElectionResult");
                                        rs3=ps3.executeQuery();
                                        if(rs3.next())
                                            sno=rs3.getInt(1);
                                        rs3.close();
                                        ps3.close();
                                    
                                        ps3=con.prepareStatement("insert into electionresult(sno,state,constituency,nominee_id,nominee_name,partyname,total_vote) values(?,?,?,?,?,?,?)");
                                        ps3.setInt(1, sno);
                                        ps3.setString(2, state);
                                        ps3.setString(3, constituency);
                                        ps3.setString(4, nominee_id);
                                        ps3.setString(5, nominee_name);
                                        ps3.setString(6, partyName);
                                        ps3.setInt(7, total);
                                        ps3.executeUpdate();
                                        ps3.close();
                                    }
                                    rs1.close();
                                    ps1.close();
                                }
                                rs.close();
                                ps.close();
                            }
                        }
                        if(request.getParameter("state")!=null){
                            if(flag)
                                out.println(state+" State's Election Result Stored!!");
                            else
                                out.println(state+" State's Election Result Already Declared!!");
                        }
                    %>
                    <br/><br/><br/>
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