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
				&& (Integer) session.getAttribute("privilege") > 2) {
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

		String query;

		Statement stmt = conn.createStatement();
		if (request.getParameter("resolve") != null) {
			query = "DELETE FROM Disputes WHERE dispute_id ="
					+ request.getParameter("resolve")+";";
			stmt.executeUpdate(query);
		}
	%>
	<table>
		<tr>
			<th>Dispute ID</th>
			<th>Disputee</th>
			<th>View</th>
		</tr>
		<%
			query = "SELECT * FROM Disputes";

			stmt = conn.createStatement();
			ResultSet rsc = stmt.executeQuery(query);

			while (rsc.next()) {
		%>
		<tr>
			<td>
				<%
					int id = rsc.getInt("dispute_id");
						out.println(id);
				%>
			</td>
			<td>
				<%
					String disputee = rsc.getString("source");
						out.println(disputee);
				%>
			</td>
			<td><form method="post" action="dispute.jsp">
					<input type="hidden" value=<%=rsc.getInt("order_id")%> name="order" />
					<input type="hidden" value=<%=rsc.getString("message")%>
						name="message" /><input type="hidden"
						value=<%=rsc.getString("source")%> name="source"><input
						type="submit" value=<%=rsc.getInt("dispute_id")%> name="dispute" />
				</form></td>
		</tr>
		<%
			}
		%>
	</table>
	<br>
	<br>
	<%
		if (request.getParameter("dispute_id") != null) {
			query = "SELECT * FROM Orders WHERE order_id="
					+ request.getParameter("order_id") + ";";
			rsc = stmt.executeQuery(query);
	%>
	<table border="1" align="center">
		<tr>
			<td>Disputee</td>
			<td>
				<%
					if (request.getParameter("source").equals("customer")) {
							out.println(rsc.getString("customer_username"));
						} else {
							out.println(rsc.getString("merchant_username"));
						}
				%>
			</td>
		</tr>
		<tr>
			<td>Other Party</td>
			<td>
				<%
					if (request.getParameter("source").equals("merchant")) {
							out.println(rsc.getString("customer_username"));
						} else {
							out.println(rsc.getString("merchant_username"));
						}
				%>
			</td>
		</tr>
		<tr>
			<td>Message</td>
			<td><%=request.getParameter("message")%></td>
		</tr>
		<tr>
			<td></td>
			<td><input type="submit"
				value=<%=request.getParameter("dispute_id")%> name="resolve" /></td>
	</table>
	<%
		}
	%>


</body>
</html>
