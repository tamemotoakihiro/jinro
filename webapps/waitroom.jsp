<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,jinro.*"%>
<%
//人狼2、占い師1、騎士1、霊媒師1、市民3
String[] role = {"人狼","人狼","占い師","騎士","霊媒師","市民","市民","市民"};
String yourRole = "";

request.setCharacterEncoding("utf-8");
String strUser=request.getParameter("user_name");

UserDao dao = new UserDao();
UserDto dto = new UserDto();

boolean SameAccount = dao.DepreCheck(strUser);
//重複ユーザーチェック

//ユーザー情報を登録。登録結果をintで持っておく
int result = dao.RegisterNewUser(strUser,SameAccount);
String StrResult = new Integer(result).toString();

//登録ができたら、ユーザー情報をセッションに保存する
if(StrResult.equals("1")){

	session.setAttribute("user_name",strUser);

}


int intUserId = dao.GetIdByUserName(strUser);

if(intUserId != -1){
	int roleId = intUserId % 8;
	yourRole = role[roleId];
	dao.AddNewRole(yourRole,strUser);
}


//何人ユーザーが参加しているかを確認する用
List<UserDto> dtoL = dao.getUsersList();

//DBへのプロセス終了
dao.close();

%>

<!DOCTYPE html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device,initial-scale=1">
	<link rel="stylesheet" href="css/style.css">
	<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&display=swap" rel="stylesheet">
	<title>JINRO | トップページ</title>
</head>

<body>


	<div class ="main-contents">
		<div class="form">
			<%if(StrResult.equals("0") || intUserId == -1){%>

				<p>済みません。再度お試しください。</p>
				<p>名前は5文字以上でお願いいたします。</p>

			<%}else if(StrResult.equals("-1")){%>

				<p>同じ名前を使っているユーザーがすでに存在します</p>

			<%}else if(dtoL.size()>=9){ %>

				<p>締め切りました</p>

			<%}else{ %>

				<!--ランダムでrole_idを付加する-->
				<p>ユーザー登録完了しました</p>
				<p>あなたの役割は<%= yourRole%>です</p>
				<p>自分の役割を誰かにあかさないでください</p>
				<p>ブラウザの更新で、人数が増えるまでお待ちください</p>

				<% if (dtoL.size()==8){ %>
				<a href="chat.jsp">ゲームへ移動する</A>
				<!--人数が集まったらリンクを表示する-->
				<!--AjaxでDBのゲーム人数が8人になったら、表示する-->
				<% } %>

			<%}%>

		</div>

	</div><!--main-contents-->


</body>
</html>
