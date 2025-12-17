
package com.elms.util;
import java.sql.*;
public class DBConnection {
 public static Connection getConnection() throws Exception {
  Class.forName("org.postgresql.Driver");
  String url = System.getenv("DATABASE_URL");
  if (url == null || url.isEmpty()) {
      url = "jdbc:postgresql://ep-little-thunder-a1eixrgm-pooler.ap-southeast-1.aws.neon.tech/neondb?user=neondb_owner&password=npg_lxESX2hUb8VO&sslmode=require&channelBinding=require";
  }
  return DriverManager.getConnection(url);
 }
}
