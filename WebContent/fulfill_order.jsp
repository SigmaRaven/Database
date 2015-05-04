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
<title>Pending Orders</title>
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
		<li><a href="fulfill_order.jsp">Pending Orders</a>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<h1>Orders Pending</h1>
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
		if (request.getParameter("fulfill") != null) {
			sql_update = "UPDATE Orders SET orders_status = \'fulfilled\' WHERE order_id = \'"
					+ request.getParameter("fulfill") + "\'";
			ps = conn.prepareStatement(sql_update);
			ps.executeUpdate(sql_update);
		} else if (request.getParameter("reject") != null) {
			sql_update = "UPDATE Orders SET orders_status = \'rejected\' WHERE order_id = "
					+ request.getParameter("reject");
			ps = conn.prepareStatement(sql_update);
			ps.executeUpdate(sql_update);
		}
	%>
	<form method="post" action="fulfill_order.jsp">
		<table>
			<tr>
				<th>Order ID</th>
				<th>Item Number</th>
				<th>Item Quantity</th>
				<th>Order Status</th>
				<th>Fulfills</th>
				<th>Reject</th>
			</tr>
			<%
				PreparedStatement ps_getItemAttr = null;
				ResultSet rs_getItemAttr = null;

				String query = "SELECT * FROM Orders WHERE Orders.orders_status = \'pending\' AND Orders.merchant_username = "
						+ "\'" + session.getAttribute("username") + "\'";
				Statement stmt = conn.createStatement();
				ResultSet rsc = stmt.executeQuery(query);

				while (rsc.next()) {
			%>
			<tr>
				<td>
					<%
						String order_id = rsc.getString("order_id");
							out.println(order_id);
					%>
				</td>
				<td>
					<%
						String item_no = rsc.getString("item_no");
							out.println(item_no);
					%>
				</td>
				<td>
					<%
						String item_quantity = rsc.getString("item_quantity");
							out.println(item_quantity);
					%>
				</td>
				<td>
					<%
						String order_status = rsc.getString("orders_status");
							out.println(order_status);
					%>
				</td>
				<td><input type="submit" value=<%=order_id%> name="fulfill" /></td>
				<td><input type="submit" value=<%=order_id%> name="reject" /></td>
			</tr>
			<%
				}
			%>
		</table>
	</form>
	<br>


</body>
</html>
