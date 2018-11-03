<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<script src="../jquery/jquery-2.2.2.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript">
			var mathArraySome = new Array();
			mathArraySome[0] = "选择函数:描述函数";
			mathArraySome[1] = "round(x):把数四舍五入为最接近的整数。";
			mathArraySome[2] = "random():返回 0 ~ 1 之间的随机数。";
			mathArraySome[3] = "max(x,y):返回 x 和 y 中的最高值。";
			mathArraySome[4] = "min(x,y):返回 x 和 y 中的最低值。";
			mathArraySome[5] = "abs(x):返回数的绝对值。";
			mathArraySome[6] = "acos(x):返回数的反余弦值。";
			mathArraySome[7] = "asin(x):返回数的反正弦值";
			mathArraySome[8] = "atan(x):以介于 -PI/2 与 PI/2 弧度之间的数值来返回 x 的反正切值。";
			mathArraySome[9] = "atan2(y,x):返回从 x 轴到点 (x,y) 的角度（介于 -PI/2 与 PI/2 弧度之间）。";
			mathArraySome[10] = "ceil(x):对数进行上舍入。";
			mathArraySome[11] = "cos(x):返回数的余弦。";
			mathArraySome[12] = "exp(x):返回 e 的指数。";
			mathArraySome[13] = "floor(x):对数进行下舍入。";
			mathArraySome[14] = "log(x):返回数的自然对数（底为e）。";
			mathArraySome[15] = "pow(x,y):返回 x 的 y 次幂。";
			mathArraySome[16] = "sin(x):返回数的正弦。";
			mathArraySome[17] = "sqrt(x):返回数的平方根";
			mathArraySome[18] = "tan(x):返回角的正切。";
			mathArraySome[19] = "toSource():返回该对象的源代码。";
			mathArraySome[20] = "valueOf():返回 Math 对象的原始值。";
			$(function(e){
				$("#func").change(function(){
				var $func =	$(this).val();
				alert(mathArraySome[$func].substring(mathArraySome[$func].indexOf(":")+1,mathArraySome[$func].length));
				$("#funsome").text(mathArraySome[$func].substring(mathArraySome[$func].indexOf(":")+1,mathArraySome[$func].length));
				});
				$("#pare").blur(function(){
					var $func =	$("#func").val();
					var $pare = $("#pare").val();
				if($func != 0 && $pare.length > 0) {
					var $hanshu = "Math." + mathArraySome[$func].substring(0, mathArraySome[$func].indexOf("(") + 1) + $pare + ")"; //得到要实现的数学函数
					$("#result").html("<script> $('#result').text("+$hanshu+")</"+"script>");
				} else {
					alert("請選擇正確的函數！");
				}
				})
				
			});
		</script>
		<title></title>
	</head>

	<body>

		<p>如果需要多哥参数的函数需要用‘,’(逗号)分割</p>
		<table width="70%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td><label for="func"></label>
					<script type="application/javascript">
						//遍歷循環數組mathArraySome的到下拉列表的值
						document.write("<select name='func' id='func'>");
						for(var i = 0; i < mathArraySome.length; i++) {
							//將鍵和值分開顯示鍵：即方法
							document.write();
							document.write("<option value='" + i + "'>" + mathArraySome[i].substring(0, mathArraySome[i].indexOf(":")) + "</option>");
						}
						document.write("</select>");
					</script>
					<span id="funsome">#####</span></td>
				<td><label for="textfield"></label>
					<input type="text" name="para" id="pare" onblur="doMathArray();"></td>
				<td>==&gt;</td>
				<td><span id="result">#####</span></td>
			</tr>
		</table>
	</body>

</html>