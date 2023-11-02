<%@page import="java.security.SecureRandom"%>
<%@page import="java.util.*,java.text.*" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.security.*,javax.crypto.*,javax.crypto.spec.SecretKeySpec,sun.misc.*"%>
<%@page import="java.io.*"%>
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
            InputStream in;
            ByteArrayOutputStream bout;
            FileOutputStream fout;
            byte[] buffer;
            String contentType, content;
            int c;
            
            String fileId, user, subject, fileName, fileCategory, uploadedDate, fileKey, publicFileKey;
            
            String photo, partySymbol, path;
            float price;
            
            String voter_id, voter_name, gender, password, fathername, dob, address, emailid, state, constituency, aadhaar_no, registrationDate;
            
            int age;
            
            public String getParameterValue(String content, String paramName) {
                String paramValue = "";
                int startIndex = content.indexOf(paramName) + paramName.length() + 3;
                int endIndex = content.indexOf("--", startIndex);
                paramValue = content.substring(startIndex, endIndex).trim();
                return paramValue;
            }
        %>
        
        <%
            contentType = request.getContentType();
            in = request.getInputStream();
            bout = new ByteArrayOutputStream();

            while ((c = in.read()) != -1)
            {
                bout.write(c);
            }
            buffer = bout.toByteArray();
            content = new String(buffer);
            bout.close();


            // Start of Code for getting Nominee Photo            
            String saveFile = content.substring(content.indexOf("filename=\"") + 10);
            saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));            
            photo = saveFile;     //this is uploaded file name  
            // End of Code for getting the uploaded file name

            int lastIndex = contentType.lastIndexOf("=");
            String boundary = contentType.substring(lastIndex + 1, contentType.length());
            int pos;
            
            // Start of Code for extracting the index of content
            pos = content.indexOf("filename=\"");
            pos = content.indexOf("\n", pos) + 1;
            pos = content.indexOf("\n", pos) + 1;
            pos = content.indexOf("\n", pos) + 1;

            int boundaryLocation = content.indexOf(boundary, pos) - 4;
            int startPos = pos;
            int endPos = boundaryLocation;
            //End of Code for extracting the index of content

            path=application.getRealPath("VoterPhotos")+"\\"+photo;//To get physical path of corresponding virtual path.            
            
            fout=new FileOutputStream(path);
            fout.write(buffer,startPos,(endPos-startPos));
            fout.close();
            
            
            
            //Start of Code for getting parameter values requested by client
            voter_id=getParameterValue(content, "voter_id");   
            voter_name=getParameterValue(content, "voter_name");
            gender=getParameterValue(content, "gender");
            password=getParameterValue(content, "pwd");
            fathername=getParameterValue(content, "father_name");
            
            dob=getParameterValue(content, "dob");
            
            age=Integer.parseInt(getParameterValue(content, "age"));
            address=getParameterValue(content, "address");
            emailid=getParameterValue(content, "mailid");
            state=getParameterValue(content, "state");
            constituency=getParameterValue(content, "constituency");
            
            aadhaar_no=getParameterValue(content, "aadhaar_no");
            registrationDate=getParameterValue(content, "registration_date");
            //End of Code for getting parameter values requested by client
            
            ps=con.prepareStatement("insert into VoterRegistration values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, voter_id);
            ps.setString(2, voter_name);
            ps.setString(3, gender);
            ps.setString(4, password);
            ps.setString(5, fathername);
            ps.setString(6, dob);
            ps.setInt(7, age);
            ps.setString(8, address);
            ps.setString(9, emailid);
            ps.setString(10, state);
            ps.setString(11, constituency);
            ps.setString(12, aadhaar_no);
            ps.setString(13, photo);
            ps.setString(14, registrationDate);
            ps.setString(15, "Pending");
            ps.setString(16, "");
            ps.executeUpdate();
            ps.close();
            response.sendRedirect("VoterRegistration.jsp?msg=Voter Info Registered!!");
            
        %>
    </body>
</html>
