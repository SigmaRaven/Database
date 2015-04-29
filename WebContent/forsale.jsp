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
				&& session.getAttribute("user_type").equals("Merchant")) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="forsale.jsp">My Marketplace</a></li>
		<li><a href="search.jsp">Item Search</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<h1>
		Welcome,
		<%=session.getAttribute("username")%></h1>
	<%
		} else {
			response.sendRedirect("welcome.jsp");
		}
	%>
	<br>
	<%
		Connection conn = null;
		PreparedStatement ps_getItemAttr = null;
		ResultSet rs_getItemAttr = null;
		conn = Helper.openDBConnection();
		Statement stmt = conn.createStatement();
		String sql_delete = "pie";
		if (request.getParameter("item_no") != null) {
			sql_delete = "DELETE FROM Item WHERE Item.item_no = "
					+ request.getParameter("item_no");
			stmt.executeUpdate(sql_delete);
		}
		String query = "SELECT Item.item_no, Item.item_name, Item.item_price, Item.quantity_avail FROM Item WHERE Item.seller = '"
				+ session.getAttribute("company") + "'";

		ResultSet rs = stmt.executeQuery(query);
	%>
	<form method="post" action="forsale.jsp">
		<table>
			<tr>
				<th>Item Name</th>
				<th>Item Price</th>
				<th>Quantity Avail</th>
				<th>Remove</th>
			</tr>

			<%
				while (rs.next()) {
			%>

			<tr>
				<td>
					<%
						String item_name = rs.getString("item_name");
							out.println(item_name);
					%>
				</td>
				<td>
					<%
						double item_price = rs.getDouble("item_price");
							out.println(String.valueOf(item_price));
					%>
				</td>
				<td>
					<%
						int quantity_avail = rs.getInt("quantity_avail");
							out.println(String.valueOf(quantity_avail));
					%>
				</td>
				<td><input type="submit" value=<%=rs.getInt("item_no")%>
					name="item_no" /></td>
			</tr>
			<%
				}
			%>
		</table>
	</form>
	<br>


</body>
</html>
