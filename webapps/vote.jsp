<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,jinro.*"%>
<%

request.setCharacterEncoding("utf-8");

//参加しているユーザーのセッションから名前を取得する
String strSessionName = (String)session.getAttribute("user_name");

//game_idに参加しているUserNameを取得→投票箱に
UserDto dto = new UserDto();
UserDao dao = new UserDao();
List <UserDto> dtosL = dao.getUsersList();

%>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device,initial-scale=1">
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/talk.css">
	<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
	<title>投票の時間|JINRO </title>
</head>

<body>

	<div class="wrapper">
			<div class="talk">

				<div class="talk_left">
					ゲームマスター
					<p>投票の時間になりました</p>
				</div>
				<div class="talk_left">
					ゲームマスター
					<p>それでは投票する人を選択してください</p>
				</div>
        <div class="talk_left">
          ゲームマスター
          <p>また、テキスト欄に弁明を記述してください。</p>
        </div>
				<div class="talk_left">
					ゲームマスター
					<p>全員が投票完了するまでゲームの進行はされません。</p>
				</div>

			</div>

			<div class="new_chat">
				<form action="voteresult.jsp" method="post">
          <div>誰に投票しますか？</div>
					<!--for文で回す-->
					<% for(UserDto user : dtosL){ %>
						<input type="radio"  name="vote_id" value="<%=user.getUserId()%>"><%=user.getUser_name()%>
					<% } %>
						<!--for文で回す-->
          <input type="text" id="text" name="sentence">
					<input type="hidden" name="user_name" value="<%=strSessionName %>">
					<input type="submit"  id="submit" value="投票する">
				</form>
			</div>
	</div>


</body>
</html>
