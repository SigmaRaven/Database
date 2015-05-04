<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Merchant Sign Up</title>
</head>
<body>
	<form method="post" action="signupMerchantBACK.jsp">
		<center>
			<h2 style="color: green">New Merchant Sign Up</h2>
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
				<td>Company:</td>
				<td><input type="text" maxlength="45" name="company" /></td>
			</tr>
			<tr>
				<td>Credentials:</td>
				<td><input type="text" maxlength="45" name="credentials" /></td>
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