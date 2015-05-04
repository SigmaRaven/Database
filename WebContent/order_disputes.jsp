<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="nav.css">
<link rel="stylesheet" type="text/css" href="table.css">

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Order Disputes</title>
</head>

<body>
	<br>
	<%
		if (session.getAttribute("username") != null
				&& session.getAttribute("user_type").equals("Customer")) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="order_disputes.jsp">Order Disputes</a></li>
		<li><a href="logout.jsp">Logout</a></li>

	</ul>
	<h1>Current Orders</h1>
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
		if (request.getParameter("order_id") != null && request.getParameter("dispute") != null) {
			
			boolean unique = false;
			Random rand = new Random();
			int disputeID = 0;
			
			while(unique == false) {
				
				disputeID = rand.nextInt(10001);
				ResultSet rs_getItemAttr = null;

				String query = "SELECT dispute_id FROM Disputes WHERE Disputes.dispute_id = "
						+ "\'" + disputeID + "\'";
				Statement stmt = conn.createStatement();
				ResultSet rsc = stmt.executeQuery(query);
				
				if(!rsc.next()) {
					unique = true;
				}
			}

			String insertSql = "INSERT into Disputes (dispute_id, order_id, message, source) VALUES(?,?,?,?)";
			PreparedStatement insert = Helper.openDBConnection().prepareStatement(insertSql);
			insert.setString(1, Integer.toString(disputeID));
			insert.setString(2, request.getParameter("order_id"));
			out.println(request.getParameter("order_id"));
			insert.setString(3, request.getParameter("dispute"));
			out.println(request.getParameter("dispute"));
			insert.setString(4, session.getAttribute("username").toString());
			insert.executeUpdate();
		}
			
	%>
	<form method="post" action="order_disputes.jsp">
		<table>
			<tr>
				<th>Order ID</th>
				<th>Item Number</th>
				<th>Item Quantity</th>
				<th>Merchant</th>
				<th>Order Status</th>
				<th>Dispute Order</th>
			</tr>
			<%
				//PreparedStatement ps_getItemAttr = null;
				//ResultSet rs_getItemAttr = null;

				String query = "SELECT * FROM Orders as O LEFT JOIN Disputes as D on O.order_id = D.order_id WHERE D.order_id IS NULL AND O.customer_username = "
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
						String merchant_username = rsc.getString("merchant_username");
							out.println(merchant_username);
					%>
				</td>
				<td>
					<%
						String order_status = rsc.getString("orders_status");
							out.println(order_status);
					%>
				</td>
				<td><input type="text" name="dispute" /></td>
				<td><input type="submit" value=<%=order_id %> name="order_id" /></td>
			</tr>
			<%
				}
			%>
		</table>
		
		
	</form>
	<br>


</body>
</html>
	