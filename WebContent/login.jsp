<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>

	
	<form method="post" action="loginprocess.jsp">
		<center>
			<h2 style="color: green">Luckerdogs Login</h2>
		</center>
		<table border="1" align="center">
			<tr>
				<td>Enter Your Username:</td>
				<td><input type="text" name="username" /></td>
			</tr>
			<tr>
				<td>Enter Your Password:</td>
				<td><input type="password" name="password" /></td>
			</tr>
			<tr>
				<td>Select UserType</td>
				<td><select name="user_type">
						<option value="select">select</option>
						<option value="Customer">user</option>
						<option value="Merchant">merchant</option>
						<option value="Admin">admin</option>

				</select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="submit" /></td>
		</table>
	</form>
	<a href="welcome.jsp">Back to welcome page</a>
	
</body>
</html>