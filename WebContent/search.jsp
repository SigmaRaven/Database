<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.Helper"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="nav.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search</title>
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
		<li><a href="order_history.jsp">Order History</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<%
		} else if (session.getAttribute("username") != null
				&& session.getAttribute("user_type").equals("Merchant")) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="forsale.jsp">My Marketplace</a></li>
		<li><a href="search.jsp">Item Search</a></li>
		<li><a href="fulfill_order.jsp">Pending Orders</a>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<%
		}
	%>

	<!-- Search for item by:
item_name (type in a box - case insensitive)
seller (drop-down)
rating (drop-down) - order by rating
item_price (drop-down) - order by price increasing decreasing
	-->
	<%
		Connection con = null;
		PreparedStatement ps_getMerchants = null;
		ResultSet rs_getMerchants = null;

		String sql_getMerchants = "SELECT seller FROM Item";

		try {
			con = Helper.openDBConnection();
			ps_getMerchants = con.prepareStatement(sql_getMerchants);
			rs_getMerchants = ps_getMerchants.executeQuery();
	%>
	<h1>Search for an Item</h1>
	<form method="post" action="search_results.jsp">
		<!-- goes to this page after click submit button -->
		<h2>Refine your search:</h2>
		<br> Item Name: <input type="text" name="item_name" /> <br>
		Items Sold by: <select name="seller">
			<option value="select">select</option>
			<%
				while (rs_getMerchants.next()) {
						String seller = rs_getMerchants.getString("seller"); //create user_type dropdown list
			%>
			<option value=<%=seller%>><%=seller%></option>
			<%
				}

				} catch (SQLException sqe) {
					out.println("search" + sqe);
				}
			%>
		</select> <br>Item Rating Greater than or Equal to: <select name="rating">
			<option value="select">select</option>
			<%
				int rating;
				for (rating = 0; rating <= 10; rating++) {
			%>
			<option value=<%=rating%>><%=rating%></option>
			<%
				}
			%>
		</select> <br>Sort by Price: <br> <input type="radio"
			name="price_button" value="ASC" checked> Increasing<br>
		<input type="radio" name="price_button" value="DESC">
		Decreasing<br> <input type="submit" value="Submit">
	</form>
</body>
</html>