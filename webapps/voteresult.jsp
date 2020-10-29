<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,jinro.*"%>
<%
	//java.lang.IndexOutOfBoundsException: Index 1 out of bounds for length 1

request.setCharacterEncoding("utf-8");

//sessionでカウントを見たい

//参加しているユーザーのセッションから名前を取得する
String strSessionName = (String)session.getAttribute("user_name");

String strVoteId = request.getParameter("vote_id");//投票した人のユーザーid
int intVoteId = Integer.parseInt(strVoteId);
String strUserName = request.getParameter("user_name");//投票者の名前
String strSentence = request.getParameter("sentence");//弁明

//ユーザー名しか渡してないので、IDは別で取りに行かないといけない書き方になってしまってる
UserDao dao = new UserDao();
int intUserId = dao.GetIdByUserName(strUserName);
JinroGame jgm = new JinroGame();
List <JinroGameData> jgdL = new ArrayList<JinroGameData>();//まだ


//誰が誰に投票し、どんな弁明を書いたか。投票結果を送信
//同じセッションからは1回だけにしたい。
jgm.voteOstra(intUserId,intVoteId,strSentence);

//投票数を更新する
List <JinroGameData> jgdAll = jgm.getAllVote();

//もっとも投票された人の名前と弁明文を返す。
List <Integer> OstraId = jgm.getVoteId();

//投票された人のうち最多得票者が1以上 かつ 全体の投票者が8以上なら
//投票された人のデータを入れる
if(OstraId.size()>=1 && jgdAll.size()>=8){
	for(int i :OstraId){
		JinroGameData jgd = new JinroGameData();
		System.out.println(i);
		jgd = jgm.getOstra(i);
		jgdL.add(jgd);
	}
}



dao.close();
jgm.close();
%>

<% /*
int count = 0;
		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;
		if (cookies != null) {
				for (int i = 0; i < cookies.length; i++) {
						if (cookies[i].getName().equals("count")) {
								count = Integer.parseInt(cookies[i].getValue());
								break;
						}
				}
				count++;
				System.out.println(String.valueOf((int)count));
				cookie.setValue(String.valueOf((int)count));
		} else {
				cookie = new Cookie("count", "1");
		}
		cookie.setMaxAge(60 * 5);
		response.addCookie(cookie);
		*/

%>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device,initial-scale=1">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/talk.css">
	<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
	<title>投票結果|JINRO </title>
</head>

<body>

	<div class="wrapper">
			<div class="talk">

				<%
				if(OstraId.size()>=1 && jgdAll.size()>=8){
				%>

				<div class="talk_left">
					ゲームマスター
					<p>投票の結果、最多得票が
						<%for(JinroGameData result : jgdL){ %>
							<%= result.getUserName()+" " %>
						<%}%>
						になりました</p>
				</div>
				<div class="talk_left">
					ゲームマスター
					<p>最多得票者は<%= OstraId.size() %>人。1人の場合は粛清されます。</p>
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

				<% }else{ %>
				<div class="talk_left">
					ゲームマスター
					<p>全員が投票するまでお待ちください。更新ブラウザの戻るは使用しないでください。
					現在投票人数<%= jgdAll.size() %>
					</p>
				</div>

				<div class="talk_left">
					ゲームマスター
					<p>クッキー情報
						<%
						//cookie.getValue()
						 %>
					</p>
				</div>
				<% } %>

				<% if(jgdL.size()>=2){ %>


				<div class="talk_left">
					ゲームマスター
					<p>決選投票を行います。投票する人を選択してください</p>
				</div>
        <div class="talk_left">
          ゲームマスター
          <p>また、投票される人はテキスト欄に弁明を記述してください。</p>
        </div>
				<div class="talk_left">
					ゲームマスター
					<p>全員が投票完了するまでゲームの進行はされません。</p>
				</div>

				<% }else if(jgdL.size()==1){

					//投票された人を削除する
					//java.lang.IndexOutOfBoundsException: Index 1 out of bounds for length 1
					UserDao dao1 = new UserDao();
					JinroGameData onlyone = jgdL.get(0);
					dao1.DeleteUser(onlyone.getUserName());
					dao1.close();


				} %>

			</div>

			<div class="new_chat">

				<% if(jgdL.size()>=2){ %>

				<form action="night.jsp" method="post">
          <!--選択する人数を減らす-->
					<%for(JinroGameData X : jgdL){%>
					<input type="radio"  name="vote_id" value="<%= X.getUserId() %>"><%= X.getUserName() %>
					<% } %>
          <input type="text" id="text" name="sentence">
					<input type="hidden" name="user_name" value="<%=strSessionName %>">
					<input type="submit"  id="submit" value="投票する">
				</form>

				<% }else if(jgdL.size()==1){ %>

				<form action="night.jsp" method="post">
					<input type="hidden" name="user_name" value="<%=strSessionName %>">
					<input type="submit"  id="submit" value="夜に向かう">
				</form>

				<% } %>




			</div>


	</div>


</body>
</html>
