<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String state;
%>
<%
    state = request.getParameter("state");
    if(state.equals("Tamilnadu"))
        out.println("Madurai,Theni,Coimbatore,Dindigul,Chennai,Trichy,Sivagangai,Ramnad,Salem");
    if(state.equals("Andhra Pradesh"))
        out.println("Hyderabad,Nellur,Kundur,KaakkiNada");
    if(state.equals("Kerala"))
        out.println("Kochin,Trivandrum,Vayanadu,Pambai");
    /*
    ps = con.prepareStatement("select name,amount from bank where accno=?");
    ps.setInt(1, accno);
    rs = ps.executeQuery();
    if (rs.next()) {
        out.print(rs.getString(1) + "," + rs.getFloat(2));
    }
    rs.close();
    ps.close();
    */
%>
