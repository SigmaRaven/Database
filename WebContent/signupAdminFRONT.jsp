<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Admin Sign Up</title>
</head>
<body>
	<form method="post" action="signupAdminBACK.jsp">
		<center>
			<h2 style="color: green">New Admin Sign Up</h2>
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
				<td></td>
				<td><input type="submit" value="submit" /></td>
		</table>
	</form>
</body>
</html>