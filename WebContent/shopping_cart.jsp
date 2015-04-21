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
	<ul>
		<li><a href="welcome.jsp">Home</a></li>
		<li><a href="search.jsp">Item Search</a></li>
		<li><a href="logout.jsp">Logout</a></li>
	</ul>
	<h1><%=session.getAttribute("username")%>'s Cart
	</h1>
	<br>

	<%
		String username = session.getAttribute("username").toString();

		Connection conn = null;
		PreparedStatement ps_getItemAttr = null;
		ResultSet rs_getItemAttr = null;
		conn = Helper.openDBConnection();

		/*Display all items in the user's cart*/
		String query = "SELECT I.item_no,I.item_name,I.item_price,SCC.carted_quantity,I.seller FROM Item I, Shopping_Cart_Contains SCC WHERE I.item_no = SCC.item_no AND SCC.username = 'smarker';";

		Statement stmt = conn.createStatement();
		ResultSet rs = stmt.executeQuery(query);

		while (rs.next()) {
	%>

	<form method="post" action="${pageContext.request.contextPath}/UploadServlet">
	<table>
		<tr>
			<th>Item No</th>
			<th>Item Name</th>
			<th>Item Price</th>
			<th>Carted Quantity</th>
			<th>Seller</th>
			<th>Delete<th>
		</tr>
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
					int carted_quantity = rs.getInt("carted_quantity");
					out.println(String.valueOf(carted_quantity));
				%>
			</td>
			<td>
				<%
					String seller = rs.getString("seller");
					out.println(seller);
				%>
			</td>
			<td>
				 <input type="submit" id="button1" name="button1"/>
				<%
				/*MOVE THIS*/
				/*
				PreparedStatement ps = null;
				stmt = conn.createStatement();
			    String sql_delete = "DELETE FROM Shopping_Cart_Contains WHERE item_no = ? AND username = ?";
			  	ps = conn.prepareStatement(sql_delete);
			  	ps.setString(1, String.valueOf(item_no));
				ps.setString(2, username);
			    ps.executeUpdate(sql_delete);				
				*/
				%>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	</form>

</body>
</html>