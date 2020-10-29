<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,jinro.*"%>
<%

request.setCharacterEncoding("utf-8");

UserDao dao = new UserDao();
List <UserDto> dtosL = dao.getUsersList();

//参加ユーザー名
String strSessionName = (String)session.getAttribute("user_name");

//チャット情報をPOSTリクエストで送る
String strRequestName = request.getParameter("chat_user");
String strSentence = request.getParameter("sentence");

//チャット系のクラスファイルの起動
JinroChat jct = new JinroChat();
JinroChatData cdt = new JinroChatData();

//名前と文章がnullでなければ、チャットを追加する
if(strRequestName!=null&&strSentence!=null){
	UserDao dao1 = new UserDao();
	int UserId = dao1.GetIdByUserName(strRequestName);
	jct.InsertSentence(UserId,strSentence);
	dao1.close();
}

//チャット全体の情報を取得する
List<JinroChatData> cdtL = jct.getChatTxt();

jct.close();
dao.close();
%>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device,initial-scale=1">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/talk.css">
	<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
	<title>チャット|JINRO </title>
</head>

<body>

	<%@include file ="include/header.html" %>

	<div class="wrapper">

		<% if(dtosL.size()>=2){ %>

			<div class="talk">

				<div class="talk_left">
					ゲームマスター
					<p>【X日目】朝がやってきました。</p>
				</div>
				<!-- 結果次第でゲームマスターのセリフが変わる-->
				<div class="talk_left">
					ゲームマスター
					<p>この村には恐ろしい狼が潜んでいます。</p>
				</div>

				<!-- ゲームが進行する限りは変わらない-->
				<div class="talk_left">
					ゲームマスター
					<p>議論の時間は「X分」です。<br>議論の後に処刑者を決める投票を行います。<br>それでは議論を始めてください</p>
				</div>

			<!-- chatデータを-->
			<% for(JinroChatData talk: cdtL){ %>
				<% if(talk.getUserName().equals(strSessionName)){ %>
					<div class="talk_right">
						<%= talk.getUserName()%>
						<p><%= talk.getSentence()%></p>
						<% //自分のセリフが表示される %>
					</div>
				<% }else{ %>
					<div class="talk_left">
						<%= talk.getUserName()%>
						<p><%= talk.getSentence()%></p>
						<% //他の人の書いたセリフが表示される %>
					</div>
				<%}
			}%>
			</div>
		<%	}else{ %>
		<div class="talk">

			<div class="talk_left">
				ゲームマスター
				<p>最後の2人になってしまいました。人狼の勝ちです。</p>
			</div>

		</div>



		<% } %>



			<div class="new_chat">
			<% if(dtosL.size()>=2){ %>
				<div><%=strSessionName%>さんのチャット</div>
				<form action="chat.jsp" method="post" class="chat">
					<input type="text" id="text" name="sentence">
					<input type="hidden" name="chat_user" value="<%=strSessionName%>">
					<input type="submit"  id="chat" value="チャットする">
				</form>
				<!--時間が経過したら、以下のhtmlを表示させる-->
				<div class="vote">
					<form action="vote.jsp" method="post">
					<input type="submit"  id="vote" value="投票する">
					</form>
				</div>
			<% }else{ %>
				<div><%=strSessionName%>さんの負け/勝ち</div>

				<%
					UserDao dao1 = new UserDao();
				  JinroGame jgm1 = new JinroGame();
				  dao1.DeleteAllUser();
				  jgm1.ResetAllVote();
					session.invalidate();
				  dao1.close();
				  jgm1.close();
				%>

				<div><a href="index.jsp">最初に戻る</a></div>
			<% } %>
			</div>
	</div>

	<script>
		const chat = document.querySelector('.chat');
		//

		function display(){
			chat.textContent = "投票してください";
		}

		setTimeout("display()",1000*60);//60秒でとりあえずテスト　5秒後に投票してに切り替わる
		//これだと、セッション開始じゃなく、レスポンスが帰ったタイミングで更新されちゃう。

	</script>

</body>
</html>
