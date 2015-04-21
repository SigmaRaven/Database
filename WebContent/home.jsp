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
	<%
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT user_type FROM User_Credentials";

		try {
			conn = Helper.openDBConnection();
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
	%>
	<form method="post" action="login.jsp">
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
						<%
							while (rs.next()) {
									String usertype = rs.getString("user_type"); //create user_type dropdown list
						%>
						<option value=<%=usertype%>><%=usertype%></option>
						<%
							}
							} catch (SQLException sqe) {
								out.println("home" + sqe);
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="submit" /></td>
		</table>
	</form>
</body>
</html>