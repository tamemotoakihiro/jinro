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

		<div class="form">
			<h3>ユーザー登録</h3>
				<form action="waitroom.jsp" method="post">
				<div class="form-section">
					<table>
						<tr><td>ユーザー名</td><td><input type="text" NAME="user_name" placeholder="5文字以上10文字以下"></td></tr>
					</table>
				</div>
				<input type="submit" value ="この名前でゲームに参加する">
				</form>
		</div><!--main-->

	</div><!--main-contents-->

</body>
</html>
