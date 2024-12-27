<%@page import="App.Login"%>
<jsp:useBean id="obj" class="App.User" scope="request"/>
<jsp:setProperty name="obj" property="*"/>

<%
    boolean status=Login.validate(obj);
    if(status) {
    session.setAttribute("session","True");
    %>
    <jsp:forward page="beranda.jsp"/>
    <%
    }else{
    out.print("<center><b>Maaf username dan password yang anda masukkan salah!<b></center>");
    %>
    <jsp:include page="index.jsp"></jsp:include>
    <%
    }


%>