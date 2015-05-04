<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="nav.css">
<title>Welcome</title>
</head>
<body>

<%
if(session.getAttribute("username") != null && session.getAttribute("user_type").equals("Customer")) {
%>
<ul>
  <li><a href="welcome.jsp">Home</a></li>
  <li><a href="shopping_cart.jsp">My Cart</a></li>
  <li><a href="search.jsp">Item Search</a></li>
  <li><a href="order_history.jsp">Order HIstory</a></li>
  <li><a href="logout.jsp">Logout</a></li>
</ul>
<h1>Welcome, <%=session.getAttribute("username")%></h1>
<%} else if(session.getAttribute("username") != null && session.getAttribute("user_type").equals("Merchant")){ %>
<ul>
  <li><a href="welcome.jsp">Home</a></li>
  <li><a href="forsale.jsp">My Marketplace</a></li>
  <li><a href="search.jsp">Item Search</a></li>
  <li><a href="fulfill_order.jsp">Pending Orders</a>
  <li><a href="logout.jsp">Logout</a></li>
</ul>
<h1>Welcome, <%=session.getAttribute("username")%></h1>
<%} else if(session.getAttribute("username") != null && session.getAttribute("user_type").equals("Admin")){ %>
<ul>
  <li><a href="welcome.jsp">Home</a></li>
  <li><a href="userlist.jsp">User List</a></li>
  <li><a href="authorize.jsp">Authorize</a></li>
  <li><a href="permissions.jsp">Permissions</a></li>
  <li><a href="logout.jsp">Logout</a></li>
</ul>
<h1>Welcome, <%=session.getAttribute("username")%></h1>
<%} else {%>
<ul>
  <li><a href="welcome.jsp">Home</a></li>
  <li><a href="search.jsp">Item Search</a></li>
  <li><a href="login.jsp">Login</a></li>
  <li><a href="signuphome.jsp">Sign Up</a></li>
</ul>
<h1>Welcome to Luckerdogs!</h1>
<%} %>
<p>
</body>
</html>