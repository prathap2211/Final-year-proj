<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="db.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
            int fo_id;
            String fo_name,uid,pwd,state,constituency;
        %>
        <%
            fo_id=Integer.parseInt(request.getParameter("fo_id"));
            fo_name=request.getParameter("fo_name");
            uid=request.getParameter("username");
            pwd=request.getParameter("pwd");
            state=request.getParameter("state");
            constituency=request.getParameter("constituency");
            ps=con.prepareStatement("insert into FieldOfficer values(?,?,?,?,?,?)");
            ps.setInt(1, fo_id);
            ps.setString(2, fo_name);
            ps.setString(3, uid);
            ps.setString(4, pwd);
            ps.setString(5, state);
            ps.setString(6, constituency);
            ps.executeUpdate();
            ps.close();
            response.sendRedirect("FieldOfficerRegistration.jsp?msg=FO Info Registered.");
        %>
    </body>
</html>
