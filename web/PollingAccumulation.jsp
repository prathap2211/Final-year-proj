<%@page import="java.text.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="db.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
            ResultSet rs;
            String voter_id, nominee_id,trans_id, state, constituency, pollingDate;
            String nomineeName,partyName;
        %>
        <%
            pollingDate=new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
            nominee_id=request.getParameter("nominee_id");
            
            ps=con.prepareStatement("select ifnull(max(TransactionId),0)+1 from Voting");
            rs=ps.executeQuery();
            if(rs.next())
                trans_id=rs.getString(1);
            rs.close();
            ps.close();
            
            ps=con.prepareStatement("select state,constituency,nominee_name,partyname from NomineeRegistration where nominee_id=?");
            ps.setString(1, nominee_id);
            rs=ps.executeQuery();
            if(rs.next()){
                state=rs.getString(1);
                constituency=rs.getString(2);
                nomineeName=rs.getString(3);
                partyName=rs.getString(4);
            }
            rs.close();
            ps.close();
            
            ps=con.prepareStatement("insert into Voting values(?,?,?,?,?,?,?,?)");
            ps.setString(1, trans_id);
            ps.setString(2, nominee_id);
            ps.setString(3, nomineeName);
            ps.setString(4, partyName);
            ps.setString(5, constituency);
            ps.setString(6, state);
            ps.setInt(7, 1);
            ps.setString(8, pollingDate);
            ps.executeUpdate();
            ps.close();
            
            ps=con.prepareStatement("insert into VotedStatus values(?,?,?)");
            ps.setString(1, session.getAttribute("VoterId").toString());
            ps.setString(2, "1");
            ps.setString(3, trans_id);
            ps.executeUpdate();
            ps.close();
            response.sendRedirect("VoterLogin.jsp?msg=You Voted Successfully<br>Your Transaction Id: "+trans_id);
        %>
    </body>
</html>
