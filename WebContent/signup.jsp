<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Luckerdogs Sign Up</title>
</head>
<body>
	<%
	String userType = request.getParameter("user_type");
	if(userType.equals("Customer")) {
		response.sendRedirect("signupCustomerFRONT.jsp");
	}else if(userType.equals("Merchant")){
		response.sendRedirect("signupMerchantFRONT.jsp");
	}else if(userType.equals("Admin")){
		response.sendRedirect("signupAdminFRONT.jsp");
	}else{
		getServletContext().getRequestDispatcher("/signuphome.jsp").include(
				request, response);
	}
	
	%>
	<center>
		<p style="color: red">Error: please select a type of user.</p>
	</center>
	

</body>
</html>