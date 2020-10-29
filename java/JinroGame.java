/*

	Gameテーブル

	Roleテーブル
	id,name,introduction

	Voteテーブル

	id,game_id,vote_num
	vote_numは投票されたユーザーidとリンクする
	game_idは開催されているゲームがどのゲームかを決める。

	Nightテーブル

	占い師に参加者のusre_idに対するrole_idを返す
	騎士が守るuser_id
	人狼
	霊媒師がVoteされた人のrole_idを返す

	ゲームが終了したら、そのgame_idのuserはdeleteする
*/

package jinro;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

public class JinroGame {

	private Connection conn;

	public JinroGame() throws ClassNotFoundException, SQLException {
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

	/* 投票する */ //同じuser_idの投票ははじく
	public void voteOstra(int user_id, int vote_id, String sentence) throws SQLException {
		Statement stmt = null;
		List<JinroGameData> jgdL = getAllVote();
		if(jgdL.size()<=7){
			try{
				stmt = conn.createStatement();
				String strSql = "INSERT INTO vote_list (user_id,vote_id,sentence) "
				 								+" VALUES("+user_id+" , "+vote_id+" , '"+sentence+"')";
				int rs = stmt.executeUpdate(strSql);
			}finally {
				try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			}
		}
	}

	//投票者の数字を集めて、一番多かった人のvote_idから名前を返す
  //idが8集まってなければストップ
	public List <Integer> getVoteId() throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
    List <Integer> VoteIdList = new ArrayList<Integer>();
		try{
			stmt = conn.createStatement();
			String strSql = "select * from "
											+"(select vote_id,count(*) cnt2 from vote_list group by vote_id) temp "
											+"where temp.cnt2 = ( "
											+"select max(cnt) from ( "
											+"select vote_id,count(*) cnt from vote_list group by vote_id "
											+" )num "
											+")";

			rs = stmt.executeQuery(strSql);
      while(rs.next()){
        JinroGameData jgd = new JinroGameData();
   			jgd.setVoteId(rs.getInt("vote_id"));
				int intVoteID =jgd.getVoteId();
        VoteIdList.add(intVoteID);
      }
			System.out.println(VoteIdList.get(0));
      return VoteIdList;
		}finally {
			try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
			try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}

	//getVoteIdの結果を受けて、投票された人の名前(username)と弁明文(sentence)を表示する
	public JinroGameData getOstra(int VoteId) throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
    JinroGameData jgd = new JinroGameData();
		try{
			stmt = conn.createStatement();
			String strSql = "select * from vote_list join user_list "
											+"on vote_list.vote_id = user_list.id "
											+"where vote_id = "+ VoteId;
			rs = stmt.executeQuery(strSql);
      if(rs.next()){
				jgd.setUserId(rs.getInt("vote_id"));
				jgd.setUserName(rs.getString("user_list.user_name"));
	      //jgd.setSentence(rs.getString("sentence"));
			}
			strSql = "select sentence from vote_list "
							+"where user_id =" + jgd.getUserId();
			rs = stmt.executeQuery(strSql);
			if(rs.next()){
				jgd.setSentence(rs.getString("sentence"));
			}
			return jgd;
		}finally {
			try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
			try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}

//全員の投票情報を渡す
	public List<JinroGameData> getAllVote() throws SQLException {
		Statement stmt = null;
		ResultSet rs = null;
    List <JinroGameData> jgdL = new ArrayList<JinroGameData>();
		try{
			stmt = conn.createStatement();
			String strSql = "select * from vote_list join user_list "
											+"on vote_list.user_id = user_list.id ";
			rs = stmt.executeQuery(strSql);
      while(rs.next()){
				JinroGameData jgd = new JinroGameData();
				jgd.setVoteId(rs.getInt("vote_id"));
				jgd.setUserId(rs.getInt("user_id"));
				jgd.setUserName(rs.getString("user_list.user_name"));
	      jgd.setSentence(rs.getString("sentence"));
				jgdL.add(jgd);
			}
      return jgdL;
		}finally {
			try { rs.close(); } catch (SQLException e){ e.printStackTrace(); }
			try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
		}
	}

	//全投票データをリセットする
		public void ResetAllVote() throws SQLException {
			Statement stmt = null;
			try{
				stmt = conn.createStatement();
				String strSql = "DELETE FROM vote_list";
				int result = stmt.executeUpdate(strSql);
			}finally {
				try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
			}
		}

}
