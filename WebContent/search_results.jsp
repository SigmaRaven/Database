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
if(session.getAttribute("username") != null) {
%>
<ul>
  <li><a href="welcome.jsp">Home</a></li>
  <li><a href="shopping_cart.jsp">My Cart</a></li>
  <li><a href="search.jsp">Item Search</a></li>
  <li><a href="logout.jsp">Logout</a></li>
</ul>
<h1>Welcome, <%=session.getAttribute("username")%></h1>
<%} else { %>
<ul>
  <li><a href="welcome.jsp">Home</a></li>
  <li><a href="search.jsp">Item Search</a></li>
  <li><a href="login.jsp">Login</a></li>
</ul>
<h1>Search Results</h1>
<%} %>
	<br>
	<table>
		<tr>
			<th>Item Name</th>
			<th>Item Price</th>
			<th>Quantity Avail</th>
			<th>Rating</th>
			<th>Seller</th>
		</tr>
		<%

			Connection conn = null;
			PreparedStatement ps_getItemAttr = null;
			ResultSet rs_getItemAttr = null;
			conn = Helper.openDBConnection();

			/*Parameters obtained by the form post*/
			String item_name_choice = request.getParameter("item_name").toLowerCase();
			if(item_name_choice == null || item_name_choice.length() == 0) {
				item_name_choice = "null";
			}
			String seller_choice = request.getParameter("seller");
			String min_rating_choice = request.getParameter("rating");
			String price_sort_choice = request.getParameter("price_button");
			
			String query = "SELECT Item.item_name, Item.item_price, Item.quantity_avail, Item.item_rating, Item.seller ";
			//String query_test = "SELECT * FROM Item;";
			query = query + "FROM Item WHERE";
			
			boolean delete_and = false;
			if(item_name_choice != null && item_name_choice != "") {
				query = query + " Item.item_name=" + "'"+item_name_choice+"' AND ";
				delete_and = true;
			}
			if(!seller_choice.equals("select")) {
				query = query + " Item.seller=" + "'"+seller_choice+"' AND ";
				delete_and = true;
			}
			if(!min_rating_choice.equals("select")) {
				query = query + " Item.item_rating>=" + min_rating_choice + " AND ";
				delete_and = true;
			}
			if(price_sort_choice != null && price_sort_choice != "") {
				if(delete_and) {
					query = query.substring(0,query.length()-5); //take off unnecessary AND
				}
				query = query + " ORDER BY Item.item_price " + price_sort_choice + ";";
			}
			
			//out.println(query);
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(query);

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
		</tr>
		<%
			}
		%>
	</table>
	<br>


</body>
</html>
