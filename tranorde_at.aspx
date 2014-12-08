<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
            this.errorHandler = null;

            q_tables = 't';
            var q_name = "tranorde";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = [];
            var q_readonlyt = [];
            var bbmNum = [['txtMount',10,0,1]];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [['txtDatea','999/99/99']];
            var bbsMask = [];
            var bbtMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            brwCount2 = 5;

            aPop = new Array();
			
			var z_mech = new Array();
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
                
                $('#btnImport').click(function(e){
                	t_noa = $.trim($('#txtNoa').val());
                	t_custno = $.trim($('#txtCustno').val());
                	t_where ="isnull(a.enda,0)=0 and ISNULL(b.enda,0)=0 and a.custno='"+t_custno+"'";
                	
                	q_box("tranquat_at_b.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'quat_orde_at', "95%", "95%", q_getMsg('popTranquat'));
                });
            }
            
            function q_funcPost(t_func, result) {
                switch(t_func) {            	
                    default:
                        break;
                }
            }
			function q_popPost(id) {
                switch (id) {         
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                    	try{
                    		var t_para = JSON.parse(t_name);
                    		if(t_para.action==""){
							}
                    	}catch(e){
                    		
                    	}
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                	case 'quat_orde_at':
                        if (b_ret != null) {
                        	as = b_ret;
                        	if(as[0] != undefined && as.length>0){
                        		$('#txtTranquatno').val(as[0].noa);
                        		$('#txtTranquatnoq').val(as[0].noq);
                        		$('#txtVal01').val(as[0].val01);
                        		$('#txtVal02').val(as[0].val02);
                        		$('#txtVal03').val(as[0].val03);
                        		$('#txtVal04').val(as[0].val04);
                        		$('#txtVal05').val(as[0].val05);
                        		$('#txtVal06').val(as[0].val06);
                        		$('#txtVal07').val(as[0].val07);
                        		$('#txtVal08').val(as[0].val08);
                        		$('#txtVal09').val(as[0].val09);
                        		$('#txtVal10').val(as[0].val10);
                        	}
                        	
                        }else{
                        	Unlock(1);
                        }
                        break;
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('tranorde_at_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtNoa').val('AUTO');
                $('#txtDatea').val(q_date());
                $('#txtDatea').focus();
            }

            function btnModi() {
            	_btnModi();
            	$('#txtDatea').focus();
            }

            function btnPrint() {
                q_box("z_tranordep_at.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'workv', "95%", "95%", m_print);
            }

            function btnOk() {
                Lock(1, {opacity : 0});
				
				
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else
                    $('#txtWorker2').val(r_name);
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_tranorde') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);

            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['caseno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
            }
            /*function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }
            function btnPlut(org_htm, dest_tag, afield) {
                _btnPlut(org_htm, dest_tag, afield);
            }*/
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    	
                    }
                }
                _bbsAssign();
            }
			
            function bbtAssign() {
                for (var i = 0; i < q_bbtCount; i++) {
                    $('#lblNo__' + i).text(i + 1);
                    if (!$('#btnMinut__' + i).hasClass('isAssign')) {
                    	
                    }
                }
                _bbtAssign();
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;

                for(var i=0;i<q_bbsCount;i++){
                }
                
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
            	
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 150px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 900px;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 12%;
            }
            .tbbm .tdZ {
                width: 1%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width:400px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 100%;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width:400px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblContract" class="lbl"> </a></td>
						<td colspan="3"><input id="txtContract"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTranquatno" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtTranquatno"  type="text" class="txt" style="float:left;width:80%;"/>
							<input id="txtTranquatnoq"  type="text" class="txt" style="float:left;width:20%;"/>
						</td>
						<td></td>
						<td><input id="btnImport" type="button" value="報價匯入" /></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="width:25%;float:left;"/>
							<input id="txtComp"  type="text" style="width:75%;float:left;"/>
							<input id="txtNick"  type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTel" class="lbl"> </a></td>
						<td colspan="3"><input id="txtTel"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblFax" class="lbl"> </a></td>
						<td colspan="3"><input id="txtFax"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtProductno"  type="text" style="width:25%;float:left;"/>
							<input id="txtProduct"  type="text" style="width:75%;float:left;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">船公司</a></td>
						<td colspan="2"><input type="text" id="txtBoat" class="txt c1"/></td>
						<td><span> </span><a class="lbl">船名</a></td>
						<td colspan="2"><input type="text" id="txtBoatName" class="txt c1"/></td>
						<td><span> </span><a class="lbl">航次</a></td>
						<td><input type="text" id="txtShip" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">櫃型</a></td>
						<td><input type="text" id="txtCasetype" class="txt c1"/></td>
						<td><span> </span><a class="lbl">櫃數</a></td>
						<td><input id="txtMount"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a class="lbl">領櫃地</a></td>
						<td><input type="text" id="txtPort2" class="txt c1"/></td>
						<td><span> </span><a class="lbl">交櫃地</a></td>
						<td><input type="text" id="txtEmpdock2" class="txt c1"/></td>
					</tr>
					<tr style="background-color: pink;">
						<td><span> </span><a class="lbl" style="color:black;">出口</a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: pink;">
						<td><span> </span><a id="" class="lbl">S/O</a></td>
						<td><input type="text" id="txtSo" class="txt c1"/></td>
						<td><span> </span><a  class="lbl">領櫃代號</a></td>
						<td><input type="text" id="txtDo1" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">卸貨港</a></td>
						<td><input type="text" id="txtPort" class="txt c1"/></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: pink;">
						<td><span> </span><a id="" class="lbl">報關日</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">開船日</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">到達日</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: burlywood;">
						<td><span> </span><a class="lbl" style="color:black;">進口</a></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: burlywood;">
						<td><span> </span><a id="" class="lbl">提單號碼</a></td>
						<td><input type="text" id="txtDo2" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">領櫃代號</a></td>
						<td><input type="text" id="txtTakeno" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">領櫃編號</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">領櫃單</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: burlywood;">
						<td><span> </span><a id="" class="lbl">掛號</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">艙號</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">追蹤</a></td>
						<td><input type="text" id="txtTrackno" class="txt c1"/></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: burlywood;">
						<td><span> </span><a id="" class="lbl">FREE TIME</a></td>
						<td><input type="text" id="txtFreetime" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">放行日</a></td>
						<td><input type="text" id="txtRedate" class="txt c1"/></td>
						<td><span> </span><a id="" class="lbl">空/重櫃</a></td>
						<td><input type="text" id="txtEf" class="txt c1"/></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">報關行</a></td>
						<td><input id="" type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">電話</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">連絡人</a></td>
						<td><input type="text" class="txt c1"/></td>
						<td><span> </span><a class="lbl">分機</a></td>
						<td><input type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3" rowspan="2"><textarea id="txtMemo" class="txt c1" rows="3"></textarea></td>
					</tr>
					<tr></tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					
					<td style="width:200px;"><a id='lbl_uno'>櫃號</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					
					<td><input class="txt" id="txtCaseno.*" type="text" style="width:95%;" title=""/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
		<div id="dbbt">
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;">
						<input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
						</td>
						<td style="width:20px;"></td>
						<td style="width:300px; text-align: center;">起迄地點</td>
					</tr>
					<tr class="detail">
						<td>
							<input id="btnMinut..*"  type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input id="txtNoq..*" type="text" style="display: none;"/>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td>
							<input class="txt" id="txtStraddrno..*" type="text" style="width:35%;float:left;"/>
							<input class="txt" id="txtStraddr..*" type="text" style="width:60%;float:left;"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</body>
</html>
