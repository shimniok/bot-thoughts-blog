<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Pragma" content="no-cache">
	<meta http-equiv="EXPIRES" content="0">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content = "height = device-height, width = 420, user-scalable = no" /> 
        <title>WebIOPi | Demo</title>

	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
        <script type="text/javascript" src="/webiopi.js"></script>
        <script type="text/javascript" src="/rover.js"></script>
	<link rel="stylesheet" href="rover.css" />
</head>
<body>
	<div align="center">

        <img id="streamimage" src="http://<?php echo $_SERVER['SERVER_ADDR']; ?>:8080/?action=stream"/>

<!--
	<table>
		<tr>
			<td></td>
			<td align="center" id="topbuttons"></td></tr>
			<td></td>
		<tr>
			<td id="leftbuttons"></td>
			<td align="center">
</td>
			<td id="rightbuttons"></td>
		</tr>
	</table>
-->

	<table id="buttontable" padding=5>
		<tr height="80" align="center">
			<td></td><!--<td id="FL" class="button">FL</td>-->
			<td id="F" class="button">F</td>
			<td></td><!--<td id="FR" class="button">FR</td>-->
		</tr>
		<tr height="80" align="center">
			<td id="SL" class="button">L</td>
			<td id="ST" class="button">S</td>
			<td id="SR" class="button">R</td>
		</tr>
		<tr height="80" align="center">
			<td></td><!--<td id="RL" class="button">RL</td>-->
			<td id="R" class="button">B</td>
			<td></td><!--<td id="RR" class="button">RR</td>-->
		</tr>
	</table>
	</div>
	<div id="status2" align="center"></div>
</body>
</html>
