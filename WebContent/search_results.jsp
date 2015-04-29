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
		if (session.getAttribute("username") != null) {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="shopping_cart.jsp">My Cart</a></li>
		<li><a href="search.jsp">Item Search</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<h1>
		Welcome,
		<%=session.getAttribute("username")%></h1>
	<%
		} else {
	%>
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="search.jsp">Item Search</a></li>
		<li><a href="login.jsp">Login</a></li>
	</ul>
	<h1>Search Results</h1>
	<%
		}
	%>
	<br>
	<table>
		<tr>
			<th>Item No</th>
			<th>Item Name</th>
			<th>Item Price</th>
			<th>Quantity Avail</th>
			<th>Rating</th>
			<th>Seller</th>
			<th>Add Quantity</th>
			<th>Add to Cart</th>
		</tr>
		<%
			Connection conn = null;
			PreparedStatement ps_getItemAttr = null;
			ResultSet rs_getItemAttr = null;
			conn = Helper.openDBConnection();

			String selected_item_no = request.getParameter("itemno");
			String selected_add_quantity = request.getParameter("add_quantity");
			out.println(selected_item_no + " " + selected_add_quantity);

			if (selected_item_no != null && selected_add_quantity != null) {
				PreparedStatement ps = null;
				String merchant_username;
				String sql_get_merchant_username = "SELECT M.username FROM Item I, Merchant M WHERE I.item_no = "
						+ "'"
						+ selected_item_no
						+ "'"
						+ ", I.seller = M.company;";

				out.println(sql_get_merchant_username);

				/*
				SELECT M.username FROM Item I, Merchant M WHERE I.item_no = selected_item_no, I.seller = M.company;
				 */
				/* Syntax:
				INSERT INTO Orders (item_quantity, customer_username, merchant_username)
				VALUES (1, 'Smarker', 'Ray');
				 */
				String sql_insert = "INSERT INTO Orders (item_no, item_quantity, customer_username, merchant_username) ";
				sql_insert = sql_insert + "VALUES (" + selected_item_no + ","
						+ selected_add_quantity + "," + "'"
						+ session.getAttribute("username") + "'" + "," + "'"
						+ sql_get_merchant_username + "'" + ");";

				out.println(sql_insert);

				ps = conn.prepareStatement(sql_insert);
				ps.executeUpdate("INSERT INTO Orders (item_no, item_quantity, customer_username, merchant_username) VALUES (3,1, 'Smarker', 'Ray');"); //sql_insert
				System.out.println("Inserted item_no: " + selected_item_no);
			}

			/*Parameters obtained by the form post*/
			String item_name_choice = request.getParameter("item_name")
					.toLowerCase();
			if (item_name_choice == null || item_name_choice.length() == 0) {
				item_name_choice = "";
			}
			String seller_choice = request.getParameter("seller");
			String min_rating_choice = request.getParameter("rating");
			String price_sort_choice = request.getParameter("price_button");

			String query = "SELECT Item.item_no, Item.item_name, Item.item_price, Item.quantity_avail, Item.item_rating, Item.seller ";
			//String query_test = "SELECT * FROM Item;";
			query = query + "FROM Item ";

			boolean delete_and = false;
			boolean first_where = true;
			if (!item_name_choice.equalsIgnoreCase("")) {
				if (first_where) {
					query = query + "WHERE";
					first_where = false;
				}
				query = query + " Item.item_name=" + "'" + item_name_choice
						+ "' AND ";
				delete_and = true;
			}
			if (!seller_choice.equalsIgnoreCase("select")) {
				if (first_where) {
					query = query + "WHERE";
					first_where = false;
				}
				query = query + " Item.seller=" + "'" + seller_choice
						+ "' AND ";
				delete_and = true;
			}
			if (!min_rating_choice.equalsIgnoreCase("select")) {
				if (first_where) {
					query = query + "WHERE";
					first_where = false;
				}
				query = query + " Item.item_rating>=" + min_rating_choice
						+ " AND ";
				delete_and = true;
			}
			if (price_sort_choice != null
					&& !price_sort_choice.equalsIgnoreCase("")) {
				if (delete_and) {
					query = query.substring(0, query.length() - 5); //take off unnecessary AND
				}
				query = query + " ORDER BY Item.item_price "
						+ price_sort_choice + ";";
			}

			//out.println(query);

			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);

			while (rs.next()) {
		%>
		<form method="post" action="search_results.jsp">
		<tr>
			<td>
				<%
					int item_no = rs.getInt("item_no");
						out.println(String.valueOf(item_no));
				%>
			</td>
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
			<td>
				<%
					int rating = rs.getInt("item_rating");
						out.println(String.valueOf(rating));
				%>
			</td>
			<td>
				<%
					String seller = rs.getString("seller");
						out.println(seller);
				%>
			</td>


			<td><select name="add_quantity">
					<option value="q1" selected>1</option>
					<option value="q5">5</option>
					<option value="q10">10</option>
					<option value="q50">50</option>
					<option value="q100">100</option>
			</select></td>

			<td><input type="hidden"
				value=<%=request.getParameter("item_name")%> name="item_name" /> <input
				type="hidden" value=<%=request.getParameter("seller")%>
				name="seller" /> <input type="hidden"
				value=<%=request.getParameter("rating")%> name="rating" /> <input
				type="hidden" value=<%=request.getParameter("price_button")%>
				name="price_button" /><input type="submit" value=<%=item_no%>
				name="itemno" /></td>

		</tr>
		</form>
		<%
			}
		%>
	</table>
	<!-- Ghetto search form: we need to save the item search parameters here or else they will disappear when you submit this form! -->

	<br>


</body>
</html>
