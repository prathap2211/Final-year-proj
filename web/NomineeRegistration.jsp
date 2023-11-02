<%@page import="java.text.*, java.util.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="db.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
    <head>
        <title>E-Voting</title>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link rel="stylesheet" href="images/Techmania.css" type="text/css" />
        <script>
            function fun1(state){
                if (window.ActiveXObject)
                    xhr = new ActiveXObject("Microsoft.XMLHttp");
                else
                    xhr = new XMLHttpRequest();

                xhr.onreadystatechange = op;
                xhr.open("GET", "getconstituency.jsp?state=" + state);
                xhr.send();

            }
            function op()
            {
                if (xhr.readyState == 4)
                {
                    //alert(xhr.responseText)
                    data = xhr.responseText;
                    //alert(data);
                    items = data.split(",");
                    content="";
                    for(i=0;i<items.length;i++){
                        content+="<option>"+items[i]+"</option>";
                    }
                    document.getElementById("constituency").innerHTML=content;
                }
            }
        </script>
    </head>
    <body>
        <%!
            String today;
            ResultSet rs;
            int nominee_id;
        %>
        <%
            today=new SimpleDateFormat("yyyy-MMM-dd").format(new java.util.Date());
            ps=con.prepareStatement("select ifnull(max(nominee_id),0)+1 from NomineeRegistration");
            rs=ps.executeQuery();
            if(rs.next())
                nominee_id=rs.getInt(1);
            rs.close();
            ps.close();
        %>
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
                    <form name="form1" action="NomineeRegProcess.jsp" method="post" enctype="Multipart/form-data">
                        <table cellspacing="10" align="center">
                            <tr>
                                <th colspan="2" style="font-size: 20px;">Nominee Registration Form</th>
                            </tr>
                            <tr>
                                <td>Nominee Id</td>
                                <td><input type="text" name="nominee_id" value="<%=nominee_id%>"/></td>
                            </tr>
                            <tr>
                                <td>Nominee Name</td>
                                <td><input type="text" name="nominee_name"/></td>
                            </tr>
                            <tr>
                                <td>Gender</td>
                                <td>
                                    <input type="radio" name="gender" value="Male"/>Male
                                    <input type="radio" name="gender" value="Female"/>Female
                                </td>
                            </tr>
                            <tr>
                                <td>Password</td>
                                <td><input type="password" name="pwd"/></td>
                            </tr>
                            <tr>
                                <td>Father Name</td>
                                <td><input type="text" name="father_name"/></td>
                            </tr>
                            <tr>
                                <td>Date of Birth</td>
                                <td><input type="date" name="dob"/></td>
                            </tr>
                            <tr>
                                <td>Age</td>
                                <td><input type="text" name="age"/></td>
                            </tr>
                            <tr>
                                <td>Address</td>
                                <td>
                                    <textarea name="address" style="width: 220px;height:75px"></textarea>
                                </td>
                            </tr>
                            <tr>
                                <td>State</td>
                                <td>
                                    <select name="state" onchange="fun1(this.value)">
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
                                <td>Constituency</td>
                                <td>
                                    <select id="constituency" name="constituency">       
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>Annual Income</td>
                                <td><input type="text" name="annual_income"/></td>
                            </tr>
                            <tr>
                                <td>Property Assets</td>
                                <td><input type="text" name="property_asset"/></td>
                            </tr>
                            <tr>
                                <td>Nomination Fee</td>
                                <td><input type="text" name="nomination_fee"/></td>
                            </tr>
                            <tr>
                                <td>Phone No</td>
                                <td><input type="text" name="phno"/></td>
                            </tr>
                            <tr>
                                <td>Aadhaar No</td>
                                <td><input type="text" name="aadhaar_no"/></td>
                            </tr>
                            <tr>
                                <td>Photo</td>
                                <td><input type="file" name="photo"/></td>
                            </tr>
                            <tr>
                                <td>Party Name</td>
                                <td><input type="text" name="party_name"/></td>
                            </tr>
                            <tr>
                                <td>Party Symbol</td>
                                <td><input type="file" name="symbol"/></td>
                            </tr>
                            <tr>
                                <td>Nomination Date</td>
                                <td><input type="text" name="nomination_date" /></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <input type="submit" name="s1" value="Submit"/>
                                    <input type="reset" name="s2" value="Clear"/>
                                </td>
                            </tr>
                        </table>
                    </form>
                    <h4>${param.msg}</h4>
                    
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