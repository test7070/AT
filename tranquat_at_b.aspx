<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'quat_orde_at', t_bbsTag = 'tbbs', t_content = " field=noa,noq,custno,comp,nick ", afilter = [], bbsKey = ['noa'], as;
           // var t_sqlname = 'quat_orde_at_load';
            t_postname = q_name;
            brwCount2 = 0;
            brwCount = -1;
            var isBott = false;
            var txtfield = [], afield, t_data, t_htm;
            var bbsNum = [];
            var i, s1;

            $(document).ready(function() {
                main();
            });
            // end ready

            function main() {
                if(dataErr)// 載入資料錯誤
                {
                    dataErr = false;
                    return;
                }
                mainBrow(0, t_content);
            }
            
            function mainPost(){
				q_getFormat();	
						
			}
			
            function refresh() {
                _refresh();
                /*for(var i=0;i<q_bbsCount;i++){
                	$('#chkSel_'+i).click(function(e){
                		t_checked = $(this).prop('checked');	
                		$(".chkSel").prop('checked',false);
                		$(this).prop('checked',t_checked);
                	});
                }*/
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 16%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 80%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm td input[type="button"] {
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .dbbs {
                width: 100%;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            .tbbs tr.error input[type="text"] {
                color: red;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width: 3%;"></td>
					<td align="center" style="width: 6%;"><a id='lblDatea'>日期</a></td>
					<td align="center" style="width: 6%;"><a id='lblStype'>類別</a></td>
					<td align="center" style="width: 6%;"><a id='lblContract'>合約號碼</a></td>
					<td align="center" style="width: 6%;"><a id='lblNick'>客戶</a></td>
					<td align="center" style="width: 6%;"><a id='lblProduct'>品名</a></td>
					<td align="center" style="width: 6%;"><a id='lblStraddr'>運送起迄</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal01'>貨櫃尺寸</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal02'>貨櫃高度</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal03'>貨櫃類型</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal04'>板架需求</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal05'>板架類型</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal06'>包裝方式</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal07'>作業方式</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal08'>每月櫃量</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal09'>領櫃碼頭</a></td>
					<td align="center" style="width: 6%;"><a id='lblVal10'>交櫃碼頭</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td><input id="chkSel.*" type="radio" name="radSel"/></td>
					<td><input id="txtDatea.*" type="text" class="txt c1" /></td>
					<td><input id="txtStype.*" type="text" class="txt c1" /></td>
					<td><input id="txtContract.*" type="text" class="txt c1" /></td>
					<td><input id="txtNick.*" type="text" class="txt c1" /></td>
					<td><input id="txtProduct.*" type="text" class="txt c1" /></td>
					<td><input id="txtStraddr.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal01.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal02.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal03.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal04.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal05.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal06.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal07.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal08.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal09.*" type="text" class="txt c1" /></td>
					<td><input id="txtVal10.*" type="text" class="txt c1" /></td>
				</tr>
			</table>
			<!--<input type="button"  id="chkAll" value="全選" onclick="checkall();" />-->
			<!--#include file="../inc/pop_ctrl.inc"-->
		</div>
	</body>
</html>
