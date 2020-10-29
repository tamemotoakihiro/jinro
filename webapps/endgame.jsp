<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,jinro.*"%>
<%
String strInvalidate = request.getParameter("invalidate");

if(strInvalidate!= null){
  UserDao dao = new UserDao();
  JinroGame jgm = new JinroGame();
  dao.DeleteAllUser();
  jgm.ResetAllVote();
	session.invalidate();
  dao.close();
  jgm.close();
}

//falseと書かないと、新しいsessionが代入されてしまうのでnullにならない
session = request.getSession(false);
%>


<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device,initial-scale=1">
	<link rel="stylesheet" href="css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
	<title>JINRO | ゲーム終了</title>
</head>

<body>

	<div class ="main-contents">
    <%if(session != null){%>
		<h3>人狼ゲームを終了しますか？</h3>
		<div class="introduction">
			<p>終了するを押した場合、参加者全員の進行がストップします。</p>
      <p>再度<a href="index.jsp">ユーザー登録</a>からやり直してください。</p>
      <p><a href="javascript:history.back();">チャット画面</a>に戻る。</p>
		</div>

		<div class="form">

				<form action="endgame.jsp?invalidate" method="post">
				<input type="submit" value ="ゲームを終了する">
				</form>
		</div><!--form-->
    <%}else{%>
    <h3>人狼ゲームを終了しました</h3>
		<div class="introduction">
      <p>再度<a href="index.jsp">ユーザー登録</a>からやり直してください。</p>
		</div>
    <%}%>


	</div><!--main-contents-->

</body>
</html>
