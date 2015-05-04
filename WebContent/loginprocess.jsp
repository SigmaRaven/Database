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

		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String user_type = request.getParameter("user_type");
		String sql = "";
		if (user_type.equals("Customer")) {
			sql = "SELECT * FROM Customer WHERE username=? AND password=?";
		} else if (user_type.equals("Merchant")) {
			sql = "SELECT * FROM Merchant WHERE username=? AND password=?";
		} else if (user_type.equals("Admin")) {
			sql = "SELECT * FROM Admin WHERE username=? AND password=?";
		}
		if ((!(username.equals(null) || username.equals("")) && !(password
				.equals(null) || password.equals("")))
				&& !user_type.equals("select")) {
			try {
				ps = Helper.openDBConnection().prepareStatement(sql);
				ps.setString(1, username);
				ps.setString(2, password);

				rs = ps.executeQuery();
				if (rs.next()) {
					userdbName = rs.getString("username");
					userdbPsw = rs.getString("password");
					dbUsertype = user_type;
					if (username.equals(userdbName)
							&& password.equals(userdbPsw)
							&& user_type.equals(dbUsertype)) {
						session.setAttribute("username", userdbName);
						session.setAttribute("user_type", dbUsertype);
						if (dbUsertype.equals("Admin")) {
							session.setAttribute("privilege",
									rs.getInt("privilege"));
						}
						if (dbUsertype.equals("Merchant")) {
							session.setAttribute("company",
									rs.getString("company"));
							session.setAttribute("authorized",
									rs.getInt("authorized"));
						}
						response.sendRedirect("welcome.jsp");
					}
				} else
					response.sendRedirect("error.jsp");
				rs.close();
				ps.close();
			} catch (SQLException sqe) {
	%>
	<center>
		<p style="color: red">Error In Login</p>
	</center>
	<%
		getServletContext().getRequestDispatcher("/login.jsp")
						.include(request, response);

			}
		} else {
	%>
	<center>
		<p style="color: red">Error In Login</p>
	</center>
	<%
		getServletContext().getRequestDispatcher("/login.jsp").include(
					request, response);
		}
	%>
</body>
</html>