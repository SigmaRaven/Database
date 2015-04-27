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
				&& session.getAttribute("user_type").equals("Admin") && (Integer)session.getAttribute("privilege") > 0) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="userlist.jsp">User List</a></li>
		<li><a href="welcome.jsp">Authorizations</a></li>
		<li><a href="logout.jsp">Logout</a></li>

	</ul>
	<h1>User List</h1>
	<%
		} else {
			response.sendRedirect("welcome.jsp");
		}
	%>
	<br>
	<%
		Connection conn = Helper.openDBConnection();
		PreparedStatement ps = null;
		String sql_delete;
		if (request.getParameter("usernamec") != null) {
			sql_delete = "DELETE FROM Customer WHERE username = \'"
					+ request.getParameter("usernamec") + "\'";
			ps = conn.prepareStatement(sql_delete);
			ps.executeUpdate(sql_delete);
		} else if (request.getParameter("usernamem") != null) {
			sql_delete = "DELETE FROM Merchant WHERE username = \'"
					+ request.getParameter("usernamem") + "\'";
			ps = conn.prepareStatement(sql_delete);

			ps.executeUpdate(sql_delete);
		} else if (request.getParameter("usernamea") != null) {
			sql_delete = "DELETE FROM Admin WHERE username = \'"
					+ request.getParameter("usernamea") + "\'";
			ps = conn.prepareStatement(sql_delete);

			ps.executeUpdate(sql_delete);
		}
	%>
	<form method="post" action="userlist.jsp">
		<table>
			<tr>
				<th>User Name</th>
				<th>User Type</th>
				<th>Delete?</th>
			</tr>
			<%
				PreparedStatement ps_getItemAttr = null;
				ResultSet rs_getItemAttr = null;

				String query = "SELECT Customer.username FROM Customer";

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
						out.println("Customer");
					%>
				</td>
				<td><input type="submit" value=<%=username%> name="usernamec" /></td>
			</tr>
			<%
				}
				query = "SELECT Merchant.username FROM Merchant";

				stmt = conn.createStatement();
				rsc = stmt.executeQuery(query);
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
						out.println("Merchant");
					%>
				</td>
				<td><input type="submit" value=<%=username%> name="usernamem" /></td>
			</tr>
			<%
				}
				query = "SELECT Admin.username, Admin.privilege FROM Admin";

				stmt = conn.createStatement();
				rsc = stmt.executeQuery(query);
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
						out.println("Admin");
					%>
				</td>
				<%
					if (rsc.getInt("privilege") < ((Integer) session
								.getAttribute("privilege")).intValue()) {
				%>
				<td><input type="submit" value=<%=username%> name="usernamea" /></td>
				<%
					}
				%>
			</tr>
			<%
				}
			%>
		</table>
	</form>
	<br>


</body>
</html>
