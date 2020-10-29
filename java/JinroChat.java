/*注意：JinroChatData.javaと同時コンパイルしないと動かない*/

package jinro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class JinroChat {

	private Connection conn;

	public JinroChat() throws ClassNotFoundException, SQLException {
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


	public List<JinroChatData> getChatTxt() throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
    List <JinroChatData> cdtL = new ArrayList<JinroChatData>();
		try{
			stmt = conn.createStatement();
			String strSql = "select * from chat_list join user_list "
											+"on chat_list.user_id = user_list.id ";
			rs = stmt.executeQuery(strSql);
      while(rs.next()){
        JinroChatData cdt = new JinroChatData();
   			cdt.setChatId(rs.getInt("chat_id"));
        cdt.setUserId(rs.getInt("user_id"));
        cdt.setUserName(rs.getString("user_list.user_name"));
        cdt.setSentence(rs.getString("sentence"));
        cdtL.add(cdt);
      }
      return cdtL;
		}finally {
			try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
			try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}

	/*  */
	public void InsertSentence(int user_id, String sentence) throws SQLException {
		Statement stmt = null;
		try{
			stmt = conn.createStatement();
			String strSql = "INSERT INTO chat_list(user_id,sentence) "
			 								+" VALUES("+user_id+" , '"+sentence+"')";
			int rs = stmt.executeUpdate(strSql);
		}finally {
			try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}

}
