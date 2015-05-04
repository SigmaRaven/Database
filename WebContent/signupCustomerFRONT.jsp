<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New User Sign Up</title>
</head>
<body>
	<form method="post" action="signupCustomerBACK.jsp">
		<center>
			<h2 style="color: green">New User Sign Up</h2>
		</center>
		<table border="1" align="center">
			<tr>
				<td>Enter Your Desired Username:</td>
				<td><input type="text" maxlength="10" name="username" /></td>
			</tr>
			<tr>
				<td>Enter Your Desired Password:</td>
				<td><input type="password" maxlength="10" name="password" /></td>
			</tr>
			<tr>
				<td>Name:</td>
				<td><input type="text" maxlength="45" name="name" /></td>
			</tr>
			<tr>
				<td>Shipping Address:</td>
				<td><input type="text" maxlength="45" name="shipping address" /></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="submit" /></td>
		</table>
	</form>
	<br>
	<a href="welcome.jsp">Back to welcome page</a>
</body>
</html>