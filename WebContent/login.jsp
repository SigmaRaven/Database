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
		PreparedStatement ps = null;
		ResultSet rs = null;

		String sql = "SELECT * FROM User_Credentials WHERE username=? AND password=? AND user_type=?";

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String user_type = request.getParameter("user_type");

		if ((!(username.equals(null) || username.equals("")) && !(password
				.equals(null) || password.equals("")))
				&& !user_type.equals("select")) {
			try {
				ps = Helper.openDBConnection().prepareStatement(sql);
				ps.setString(1, username);
				ps.setString(2, password);
				ps.setString(3, user_type);
				rs = ps.executeQuery();
				if (rs.next()) {
					userdbName = rs.getString("username");
					userdbPsw = rs.getString("password");
					dbUsertype = rs.getString("user_type");
					if (username.equals(userdbName)
							&& password.equals(userdbPsw)
							&& user_type.equals(dbUsertype)) {
						session.setAttribute("username", userdbName);
						session.setAttribute("user_type", dbUsertype);
						response.sendRedirect("welcome.jsp");
					}
				} else
					response.sendRedirect("error.jsp");
				rs.close();
				ps.close();
			} catch (SQLException sqe) {
				out.println(sqe);
			}
		} else {
	%>
	<center>
		<p style="color: red">Error In Login</p>
	</center>
	<%
		getServletContext().getRequestDispatcher("/home.jsp").include(
					request, response);
		}
	%>
</body>
</html>