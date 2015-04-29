<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="nav.css">
<title>Home</title>
</head>
<body>
	<br>
	<%
		if (session.getAttribute("username") != null
				&& session.getAttribute("user_type").equals("Admin")
				&& (Integer) session.getAttribute("privilege") > 0) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="userlist.jsp">User List</a></li>
		<li><a href="authorize.jsp">Authorizations</a></li>
		<li><a href="permissions.jsp">Permissions</a></li>
		<li><a href="logout.jsp">Logout</a></li>

	</ul>
	<%
		}
		Connection conn = Helper.openDBConnection();
		PreparedStatement ps = null;
		String sql_update="";
		if (request.getParameter("username") != null
				&& request.getParameter("privilege") != null) {
			sql_update = "UPDATE Admin SET privilege = "
					+ request.getParameter("privilege")
					+ " WHERE username = \'"
					+ request.getParameter("username") + "\'";
			ps = conn.prepareStatement(sql_update);
			ps.executeUpdate(sql_update);
		}
		String sql = "SELECT Admin.username FROM Admin WHERE Admin.privilege < "
				+ session.getAttribute("privilege") + ";";
		ps = Helper.openDBConnection().prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
	%>
	<form method="post" action="permissions.jsp">
		<center>
			<h2 style="color: green">Alter Permissions</h2>
		</center>
		<table border="1" align="center">
			<tr>
				<td>Admin Username</td>
				<td><select name="username">
						<%
							while (rs.next()) {
						%>
						<option value=<%=rs.getString("username")%>><%=rs.getString("username")%></option>
						<%
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td>New Privilege</td>
				<td><select name="privilege">
						<%
							int i = 0;
							while (i < (Integer) session.getAttribute("privilege")) {
						%>
						<option value=<%=i%>><%=i%></option>
						<%
							++i;
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" value="update" /></td>
		</table>
	</form>
	<br>
	Permission 1: Removing regular users
	Permission 2: Authorizing merchants
	Permission 3: Resolving disputes
</body>
</html>