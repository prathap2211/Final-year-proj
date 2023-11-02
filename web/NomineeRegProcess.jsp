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
            
            String nominee_id, nominee_name, gender, password, fathername, dob, address, state, constituency, phno, aadhaar_no, partyName, nominationDate;
            
            int age;
            
            float annual_income, asset, nomination_fee;

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

            path=application.getRealPath("NomineePhotos")+"\\"+photo;//To get physical path of corresponding virtual path.            
            
            fout=new FileOutputStream(path);
            fout.write(buffer,startPos,(endPos-startPos));
            fout.close();
            
            
            
            //for saving the file Party Symbol
            
            saveFile = content.substring(content.indexOf("filename=\"",content.indexOf("filename=\"")+10) + 10); 
            saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
            saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
            partySymbol=saveFile;
            
            //for getting boundary ie ----Wxynfg8956
            lastIndex = contentType.lastIndexOf("=");
            boundary = contentType.substring(lastIndex + 1, contentType.length());

            //extracting the index of file
            pos = content.indexOf("filename=\"",content.indexOf("filename=\"")+10);
            pos = content.indexOf("\n", pos) + 1;
            pos = content.indexOf("\n", pos) + 1;
            pos = content.indexOf("\n", pos) + 1;//start index of the file content        
            
            boundaryLocation = content.indexOf(boundary, pos) - 4;//end index of the file content
        
            startPos = pos;        
            endPos = boundaryLocation;
            
            path=application.getRealPath("PartySymbols")+"\\"+partySymbol;//To get physical path of corresponding virtual path.            
            
            fout=new FileOutputStream(path);
            fout.write(buffer,startPos,(endPos-startPos));
            fout.close();

            
            //Start of Code for getting parameter values requested by client
            nominee_id=getParameterValue(content, "nominee_id");   
            nominee_name=getParameterValue(content, "nominee_name");
            gender=getParameterValue(content, "gender");
            password=getParameterValue(content, "pwd");
            fathername=getParameterValue(content, "father_name");
            
            dob=getParameterValue(content, "dob");
            //System.out.println(dob);
            //java.util.Date dob2 = new SimpleDateFormat("dd-MMM-yyyy").parse(dob);
            //dob=new SimpleDateFormat("yyyy-MM-dd").format(dob2);
            
            age=Integer.parseInt(getParameterValue(content, "age"));
            address=getParameterValue(content, "address");
            state=getParameterValue(content, "state");
            constituency=getParameterValue(content, "constituency");
            annual_income=Float.parseFloat(getParameterValue(content, "annual_income"));
            asset=Float.parseFloat(getParameterValue(content, "property_asset"));
            nomination_fee=Float.parseFloat(getParameterValue(content, "nomination_fee"));
            phno=getParameterValue(content, "phno");
            aadhaar_no=getParameterValue(content, "aadhaar_no");
            partyName=getParameterValue(content, "party_name");
            nominationDate=getParameterValue(content, "nomination_date");
            //End of Code for getting parameter values requested by client
            
            ps=con.prepareStatement("insert into NomineeRegistration values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setString(1, nominee_id);
            ps.setString(2, nominee_name);
            ps.setString(3, gender);
            ps.setString(4, password);
            ps.setString(5, fathername);
            ps.setString(6, dob);
            ps.setInt(7, age);
            ps.setString(8, address);
            ps.setString(9, state);
            ps.setString(10, constituency);
            ps.setFloat(11, annual_income);
            ps.setFloat(12, asset);
            ps.setFloat(13, nomination_fee);
            ps.setString(14, phno);
            ps.setString(15, aadhaar_no);
            ps.setString(16, photo);
            ps.setString(17, partyName);
            ps.setString(18, partySymbol);
            ps.setString(19, nominationDate);
            ps.setString(20, "Pending");
            ps.setString(21, "");
            ps.executeUpdate();
            ps.close();
            response.sendRedirect("NomineeRegistration.jsp?msg=Nominee Info Registered!!");
            
        %>
    </body>
</html>
