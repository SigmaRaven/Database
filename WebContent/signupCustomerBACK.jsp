<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="SQLHelper.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Luckerdogs Login</title>
</head>
<body>
	<%!String userdbName;
	String userdbPsw;
	String dbUsertype;%>
	<%
	PreparedStatement insert = null;
	PreparedStatement checkUsername = null;
	ResultSet rs = null;
	
	String checkSql = "SELECT * FROM (SELECT C.username FROM Customer C UNION SELECT M.username FROM Merchant M UNION SELECT A.username FROM Admin A) AS users WHERE username=?";
	String insertSql = "INSERT into Customer (username, password, name, shipping_addr, billing_info) VALUES(?,?,?,?,?)";

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String shippingAddress = request.getParameter("shipping address");
		String billingInfo = request.getParameter("billing info");
		if ((!(username.equals(null) || username.equals("")) && !(password
				.equals(null) || password.equals("")) && !(name.equals(null) || name.equals("")) && 
				!(shippingAddress.equals(null) || shippingAddress.equals("")) && !(billingInfo.equals(null) || billingInfo.equals("")))) {
			try {
				checkUsername = Helper.openDBConnection().prepareStatement(checkSql);
				checkUsername.setString(1, username);
				rs = checkUsername.executeQuery();
				if (!rs.next()) {
					//userdbName = rs.getString("username");
					dbUsertype = "Customer";
					//if (username.equals(userdbName)) {
					
					//} else {
						insert = Helper.openDBConnection().prepareStatement(insertSql);
						insert.setString(1, username);
						insert.setString(2, password);
						insert.setString(3, name);
						insert.setString(4, shippingAddress);
						insert.setString(5, billingInfo);
						insert.executeUpdate();
						session.setAttribute("username", username);
						session.setAttribute("user_type", dbUsertype);
						response.sendRedirect("welcome.jsp");
						insert.close();
					//}
				} else {
					%>
	<center>
		<p style="color: red">Error: that username is already taken.
			Please try again.</p>
	</center>
	<% 
				getServletContext().getRequestDispatcher("/signupCustomerFRONT.jsp").include(
					request, response);
				}
				rs.close();
				checkUsername.close();
			} catch (SQLException sqe) {
				out.println(sqe);
			}
		} else {
	%>
	<center>
		<p style="color: red">Error: you failed to fill out all provided
			fields. Please try again.</p>
	</center>
	<%
		getServletContext().getRequestDispatcher("/signupCustomerFRONT.jsp").include(
					request, response);
		}
	%>
</body>
</html>