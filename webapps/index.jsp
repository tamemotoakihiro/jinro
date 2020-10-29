<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.*,jinro.*"%>

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
		<h3>ようこそ人狼ゲームへ</h3>
		<div class="introduction">
			<p>この人狼ゲームは、人狼2、占い師1、騎士1、霊媒師1、市民3の8人固定制です。</p>
		</div>

		<div class="form">

				<form action="signin.jsp" method="post">
				<input type="submit" value ="ゲームに参加する">
				</form>
		</div><!--main-->

	</div><!--main-contents-->

</body>
</html>
