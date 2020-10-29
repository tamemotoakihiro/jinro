package jinro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class UserDao {

	private Connection conn;

	public UserDao() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.jdbc.Driver");
		String strConn = "jdbc:mysql://localhost:3306/jinro"
		+ "?user=Mulder&password=TrustNo1"
		+ "&useUnicode=true&characterEncoding=ms932";
		conn = DriverManager.getConnection(strConn);
	}

	public void close() {
		try {
		conn.close();
		} catch (SQLException e) {
		e.printStackTrace();
		}
	}
  //DBの起動・終了

  //会員登録
  public int RegisterNewUser(String user_name,boolean SameAccount)
	throws Exception {
    Statement stmt = null;
		int rs = 0;
		//バリデーション：ユーザー名は5文字以上、パスワードは8文字以上、名前の重複はない
		if(user_name.length() >=5 && SameAccount == false){
				try{
		      stmt = conn.createStatement();
		      String strSql = "INSERT INTO user_list(user_name) "
		                      +" VALUES('"+user_name+"')";
		      rs = stmt.executeUpdate(strSql);
		    }finally{
		      try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		    }//try
		}else if(SameAccount == true){
			rs = -1;
		}else{
			rs = 0;
		}
			System.out.println(rs);
			return rs;
  }//public int

	//役割登録
  public void AddNewRole(String role_name,String user_name)
	throws Exception {
    Statement stmt = null;
		//バリデーション：ユーザー名は5文字以上、パスワードは8文字以上、名前の重複はない
		try{
		    stmt = conn.createStatement();
		    String strSql =  "UPDATE user_list SET role_name = '"+role_name+"'"
												+" WHERE user_name = '"+ user_name+ "'";
		     int result = stmt.executeUpdate(strSql);
		    }finally{
		      try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		    }//try
  }//public void


	//指定した参加ユーザーを消す：投票で消えるか、食べられる
		public int DeleteUser(String strName) throws SQLException {
			Statement stmt = null;
			try{
				stmt = conn.createStatement();
				String strSql = "DELETE FROM user_list WHERE user_name='"+strName+"'";
				int result = stmt.executeUpdate(strSql);
				return result;
			}finally {
				try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			}
		}

		//ゲームをリセットする用
		public void DeleteAllUser() throws SQLException {
			Statement stmt = null;
			try{
				stmt = conn.createStatement();
				String strSql = "DELETE FROM user_list";
				int result = stmt.executeUpdate(strSql);
			}finally {
				try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			}
		}

	//id取得
  public int GetIdByUserName(String strUser)
	throws Exception{

    Statement stmt = null;
    ResultSet rs = null;
    UserDto dto = new UserDto();
		int userId = -1;
    try{
      stmt = conn.createStatement();
      String strSql = "select id from user_list "
                      + "where user_name = '"+strUser+"' ";
      rs = stmt.executeQuery(strSql);
			//もし結果が帰ってきてしまったら、同じユーザー名の人が存在するので、重複=trueを返す
      if(rs.next()){
				dto.setUserId(rs.getInt("id"));
				userId = dto.getUserId();
			}
			return userId;
    }finally{
      try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
      try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
  }

	//データ取得
  public UserDto GetUserDataByUserId(int UserId)
	throws Exception{

    Statement stmt = null;
    ResultSet rs = null;
    UserDto dto = new UserDto();

    try{
      stmt = conn.createStatement();
      String strSql = "select * from user_list "
                      + "where id = "+UserId+" ";
      rs = stmt.executeQuery(strSql);
			//もし結果が帰ってきてしまったら、同じユーザー名の人が存在するので、重複=trueを返す
      rs.next();
			dto.setUser_name(rs.getString("user_name"));
			dto.setRole_name(rs.getString("role_name"));
      return dto;
    }finally{
      try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
      try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
  }

	public List<UserDto> getUsersList() throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
    List <UserDto> dtosL = new ArrayList<UserDto>();
		try{
			stmt = conn.createStatement();
			String strSql = "select * from user_list";
			rs = stmt.executeQuery(strSql);
      while(rs.next()){
        UserDto dto = new UserDto();
        dto.setUserId(rs.getInt("id"));
        dto.setUser_name(rs.getString("user_name"));
        dtosL.add(dto);
      }
      return dtosL;
		}finally {
			try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
			try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}

	//重複回避
  public boolean DepreCheck(String strUser)
	throws Exception{

    boolean SameName=false;
    Statement stmt = null;
    ResultSet rs = null;
    UserDto dto = new UserDto();

    try{
      stmt = conn.createStatement();
      String strSql = "select * from user_list "
                      + "where user_name = '"+strUser+"' ";
      rs = stmt.executeQuery(strSql);
			//もし結果が帰ってきてしまったら、同じユーザー名の人が存在するので、重複=trueを返す
      if(rs.next()){
					SameName= true;
  			}
      return SameName;
    }finally{
      try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
      try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
  }

}
