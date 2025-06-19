package org.example.dao;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public static User findUser(ServletContext servletContext, String email, String password) throws SQLException {
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("ds");

        try {
            Connection connection = ds.getConnection();
            PreparedStatement pstm = connection.prepareStatement("SELECT * FROM user WHERE email = ? AND password = ?");
            pstm.setString(1, email);
            pstm.setString(2, password);

            ResultSet rs = pstm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                return user;

            }else {
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
