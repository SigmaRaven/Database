<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="nav.css">
<link rel="stylesheet" type="text/css" href="table.css">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
</head>

<body>
	<br>
	<%
		if (session.getAttribute("username") != null
				&& session.getAttribute("user_type").equals("Admin")
				&& (Integer) session.getAttribute("privilege") > 1) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="userlist.jsp">User List</a></li>
		<li><a href="authorize.jsp">Authorize</a></li>
		<li><a href="permissions.jsp">Permissions</a></li>
		<li><a href="pendingdisputes.jsp">Disputes</a>
		<li><a href="logout.jsp">Logout</a></li>

	</ul>
	<h1>Merchants Pending</h1>
	<%
		} else {
			response.sendRedirect("welcome.jsp");
		}
	%>
	<br>
	<%
		Connection conn = Helper.openDBConnection();
		PreparedStatement ps = null;
		String sql_update;
		if (request.getParameter("username") != null) {
			sql_update = "UPDATE Merchant SET authorized = 1, authorizer = \'"
					+ session.getAttribute("username")
					+ "\' WHERE username = \'"
					+ request.getParameter("username") + "\'";
			ps = conn.prepareStatement(sql_update);
			ps.executeUpdate(sql_update);
		}
	%>
	<form method="post" action="authorize.jsp">
		<table>
			<tr>
				<th>Merchant Username</th>
				<th>Merchant Company</th>
				<th>Authorize</th>
			</tr>
			<%
				PreparedStatement ps_getItemAttr = null;
				ResultSet rs_getItemAttr = null;

				String query = "SELECT * FROM Merchant WHERE Merchant.authorized = 0";

				Statement stmt = conn.createStatement();
				ResultSet rsc = stmt.executeQuery(query);

				while (rsc.next()) {
			%>
			<tr>
				<td>
					<%
						String username = rsc.getString("username");
							out.println(username);
					%>
				</td>
				<td>
					<%
						String company = rsc.getString("company");
							out.println(company);
					%>
				</td>
				<td><input type="submit" value=<%=username%> name="username" /></td>
			</tr>
			<%
				}
			%>
		</table>
	</form>
	<br>


</body>
</html>
