<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,jinro.*"%>
<%

request.setCharacterEncoding("utf-8");

//参加しているユーザーのセッションから名前を取得する
String strSessionName = (String)session.getAttribute("user_name");

//投票がある場合はその内容を入れる
String strVoteId = request.getParameter("vote_id");//投票した人のユーザーid
String strUserName = request.getParameter("user_name");
String strSentence = request.getParameter("sentence");

//sessionで1回投票したらもうできないとかやりたい


//ユーザー名しか渡してないので、IDは別で取りに行かないといけない書き方になってしまってる
UserDao dao = new UserDao();
int intUserId = dao.GetIdByUserName(strUserName);
UserDto dto = dao.GetUserDataByUserId(intUserId);

JinroGame jgm = new JinroGame();
List <JinroGameData> jgdL = new ArrayList<JinroGameData>();//まだ

List <JinroGameData> jgdAll = new ArrayList<JinroGameData>();//まだ
List <Integer> OstraId = new ArrayList<Integer>();

//誰が誰に投票し、どんな弁明を書いたか。投票結果を送信
//同じセッションからは1回だけにしたい。
//投票しない人はnullなので、除外
if(strVoteId !=null){
	int intVoteId = Integer.parseInt(strVoteId);
	jgm.voteOstra(intUserId,intVoteId,strSentence);

	//もっとも投票された人の名前と弁明文を返す。
	OstraId = jgm.getVoteId();
	//投票数を更新する
  jgdAll = jgm.getAllVote();

	if(OstraId.size()>=1 && jgdAll.size()>=16){
		for(int i :OstraId){
			JinroGameData jgd = new JinroGameData();
			jgd = jgm.getOstra(i);
			jgdL.add(jgd);
		}
	}

}


//game_idに参加しているUserNameを取得。投票リストに反映
UserDao dao1 = new UserDao();
List <UserDto> dtosL = dao1.getUsersList();
dao.close();
dao1.close();
%>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device,initial-scale=1">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/talk.css">
	<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
	<title>夜|JINRO </title>
</head>

<body>

	<div class="wrapper"　id="night">
			<div class="talk">


				<%
				if(OstraId.size()>=1 && jgdAll.size()>=16){
				%>

				<div class="talk_left">
					ゲームマスター
					<p>投票の結果、最多得票が
						<%for(JinroGameData result : jgdL){ %>
							<%= result.getUserName()+" " %>
						<%}%>
						になりました。</p>
				</div>
				<div class="talk_left">
					ゲームマスター
					<p>最多得票者は全員粛清されます。</p>
				</div>
				<!--for文で同じ最大値の人の弁明を表示-->
				<div class="talk_left">
					ゲームマスター
					<p>弁明内容：
						<%for(JinroGameData result: jgdL){ %>
							<%= result.getSentence() %>
						<%}%>
				</p>
				</div>
				<% } %>

				<%
				JinroGame jgm1 = new JinroGame();
				jgm1.ResetAllVote();
				jgm1.close();
				%>



				<div class="talk_left">
					ゲームマスター
					<p>夜になりました</p>
				</div>
				<div class="talk_left">
					ゲームマスター
					<p>人狼は食べる人を選択してください</p>
				</div>
        <div class="talk_left">
          ゲームマスター
          <p>占い師は占う人を選択してください。</p>
        </div>
        <div class="talk_left">
          ゲームマスター
          <p>騎士は守る人を選択してください。</p>
        </div>
				<div class="talk_left">
					ゲームマスター
					<p>全員が投票完了するまでゲームの進行はされません。</p>
				</div>

			</div>

			<div class="new_chat">
				<div><%=strSessionName%>さん、あなたは<%=dto.getRole_name()%>です。</div>
				<form action="chat.jsp" method="post">
					<% for(UserDto user : dtosL){ %>
						<input type="radio"  name="vote_id" value="<%=user.getUserId()%>"><%=user.getUser_name()%>
					<% } %>
					<input type="hidden" name="user_name" value="<%=strSessionName%>">
					<input type="submit"  id="submit" value="投票する">
				</form>
			</div>
	</div>


</body>
</html>
