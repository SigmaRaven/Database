<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="nav.css">
<link rel="stylesheet" type="text/css" href="table.css">
<title>Shopping Cart</title>
</head>

<body>

	<%
		if (session.getAttribute("username") != null
				&& session.getAttribute("user_type").equals("Customer")) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="shopping_cart.jsp">My Cart</a></li>
		<li><a href="search.jsp">Item Search</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<h1>
		<%=session.getAttribute("username")%>'s Shopping Cart
	</h1>
	<%
		} else {
			response.sendRedirect("welcome.jsp");
		}
	%>
	<br>
	<%
		String username = session.getAttribute("username").toString();

		Connection conn = null;
		PreparedStatement ps_getItemAttr = null;
		ResultSet rs_getItemAttr = null;
		conn = Helper.openDBConnection();
		String remove_no = request.getParameter("itemno");
		if (remove_no != null) {
			PreparedStatement ps = null;
			String sql_delete = "DELETE FROM Orders WHERE item_no = "
					+ remove_no + " AND customer_username = \'" + username
					+ "\'";
			ps = conn.prepareStatement(sql_delete);
			//ps.setInt(1, Integer.parseInt((remove_no)));
			//ps.setString(2, username);
			ps.executeUpdate(sql_delete);
		}
		String checkout = request.getParameter("checkout");
		if (checkout != null) {
			String sql_checkout = "UPDATE Orders SET orders_status=\'pending\' WHERE customer_username=\'"
					+ session.getAttribute("username") + "\';";
			PreparedStatement ps = conn.prepareStatement(sql_checkout);
			ps.executeUpdate(sql_checkout);
		}
	%>
	<%
		int item_no;
		String item_name;
		double item_price;
		int item_quantity;
		String seller;

		/*Display all items in the user's cart*/
		String query = "SELECT I.item_no,I.item_name,I.item_price,O.item_quantity,I.seller FROM Item I, Orders O WHERE I.item_no = O.item_no AND O.customer_username = '"
				+ session.getAttribute("username") + "' AND O.orders_status=\'cart\';";

		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);

		while (rs.next()) {
	%>

	<form method="post" action="shopping_cart.jsp">
		<table>
			<tr>
				<th>Item No</th>
				<th>Item Name</th>
				<th>Item Price</th>
				<th>Carted Quantity</th>
				<th>Seller</th>
				<th>Delete</th>
			</tr>
			<tr>
				<td>
					<%
						item_no = rs.getInt("item_no");
							out.println(String.valueOf(item_no));
					%>
				</td>
				<td>
					<%
						item_name = rs.getString("item_name");
							out.println(item_name);
					%>
				</td>
				<td>
					<%
						item_price = rs.getDouble("item_price");
							out.println(String.valueOf(item_price));
					%>
				</td>
				<td>
					<%
						item_quantity = rs.getInt("item_quantity");
							out.println(String.valueOf(item_quantity));
					%>
				</td>
				<td>
					<%
						seller = rs.getString("seller");
							out.println(seller);
					%>
				</td>
				<td><input type="submit" value=<%=item_no%> name="itemno" /></td>
			</tr>
			<%
				}
			%>
		</table>
	</form>
	<form method="post" action="shopping_cart.jsp">
		<input type="submit" value="checkout" name="checkout">
	</form>
</body>
</html>