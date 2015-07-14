<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			var q_name = "trans";
			var q_readonly = ['txtWeight3','txtMiles','txtTotal','txtTotal2','txtNoa','txtOrdeno','txtWorker','txtWorker2'];
			var bbmNum = [['txtCustdiscount',10,0,1],['txtInmount',10,3,1],['txtPton',10,3,1],['txtPrice',10,3,1],['txtTotal',10,0,1]
			,['txtOutmount',10,3,1],['txtPton2',10,3,1],['txtPrice2',10,3,1],['txtPrice3',10,3,1],['txtDiscount',10,3,1],['txtTotal2',10,0,1]
			,['txtOverw',10,0,1],['txtOverh',10,0,1]];
			var bbmMask = [['txtDatea','999/99/99'],['txtTrandate','999/99/99'],['txtMon','999/99'],['txtMon2','999/99'],['txtLtime','99:99'],['txtStime','99:99'],['txtDtime','99:99']];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			q_desc = 1;
            q_xchg = 1;
            brwCount2 = 15;
            //不能彈出瀏覽視窗
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno,txtDriverno,txtDriver', 'car2_b.aspx']
			,['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
			,['txtTggno', 'lblTgg', 'tgg', 'noa,comp', 'txtTggno,txtTgg', 'tgg_b.aspx']
			,['txtDriverno', 'lblDriver', 'driver', 'noa,namea', 'txtDriverno,txtDriver', 'driver_b.aspx']
			,['txtUccno', 'lblUcc', 'ucc', 'noa,product', 'txtUccno,txtProduct', 'ucc_b.aspx']
			,['txtStraddrno', 'lblStraddr', 'addr', 'noa,addr,productno,product', 'txtStraddrno,txtStraddr,txtUccno,txtProduct,txtStraddr', 'addr_b.aspx'] 
			);
			
			z_calctypes = new Array()
			z_carteam = new Array();
			
			function sum() {
				if(q_cur!=1 && q_cur!=2)
					return;
				var t_isoutside = true;
				for(var i=0;i<z_calctypes.length;i++){
					if($('#cmbCalctype').val()==z_calctypes[i].noa+z_calctypes[i].noq){
						t_isoutside = z_calctypes[i].isoutside=="true"?true:false;
						break;
					}
				}
				if(q_float('txtOverw')!=0 && q_float('txtOverh')!=0)
				   $('#txtDiscount').val(round((1-q_float('txtOverw')/100)*q_float('txtOverh')/100,3));
				
				t_mount = q_float('txtInmount')+q_float('txtPton');
				t_mount2 = q_float('txtOutmount')+q_float('txtPton2');
				
			    if(q_float('txtCustdiscount')==0)
			        $('#txtCustdiscount').val(100);
		        var t_custdiscount = q_float('txtCustdiscount');
				var t_mount = q_add(q_float('txtInmount'),q_float('txtPton'));
				
				var t_total = round(q_div(q_mul(q_mul(t_mount,q_float('txtPrice')),t_custdiscount),100),0);
				$('#txtMount').val(t_mount);
				$('#txtTotal').val(t_total);
				var t_mount2 = q_add(q_float('txtOutmount'),q_float('txtPton2'));
				var t_total2 = t_isoutside?q_float('txtPrice3'):q_float('txtPrice2');
				t_total2 = round(q_mul(q_mul(t_mount2,t_total2),q_float('txtDiscount')),0);
				$('#txtMount2').val(t_mount2);
				$('#txtTotal2').val(t_total2);
			}
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				q_brwCount();
				
				q_gt('carteam', '', 0, 0, 0, 'transInit_1');
			});
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
			}

			function mainPost() {
				$('#btnIns').val($('#btnIns').val() + "(F8)");
				$('#btnOk').val($('#btnOk').val() + "(F9)");
				q_mask(bbmMask);
				q_cmbParse("cmbCstype",' ,領,送,收,交,移,整趟');
				
				var t_carteam= '';
				for(var i=0;i<z_carteam.length;i++){
					t_carteam += (t_carteam.length>0?',':'') + z_carteam[i].noa + '@'+ z_carteam[i].team ;
				}
				if(t_carteam.length>0)
					q_cmbParse("cmbCarteamno",t_carteam);
				
				var t_calctypes = '';
				for(var i=0;i<z_calctypes.length;i++){
					t_calctypes += (t_calctypes.length>0?',':'') + z_calctypes[i].noa + z_calctypes[i].noq + '@'+ z_calctypes[i].typea ;
				}
				if(t_calctypes.length>0)
					q_cmbParse("cmbCalctype",t_calctypes);
				
				$("#cmbCalctype").focus(function() {
					sum();
				}).focusout(function() {
					sum();
				}).click(function() {
					sum();
				}).blur(function() {
					sum();
				});
				
				$("#cmbCstype").focus(function() {
					var t_addrno = $.trim($('#txtStraddrno').val());
					var t_date = $.trim($('#txtTrandate').val());
					var t_saction = $.trim($('#cmbCstype').val());
					q_gt('addrs', "where=^^ noa='"+t_addrno+"' and custunit='"+t_saction+"' and datea<='"+t_date+"' ^^", 0, 0, 0, 'getPrice');
				}).focusout(function() {
					var t_addrno = $.trim($('#txtStraddrno').val());
					var t_date = $.trim($('#txtTrandate').val());
					var t_saction = $.trim($('#cmbCstype').val());
					q_gt('addrs', "where=^^ noa='"+t_addrno+"' and custunit='"+t_saction+"' and datea<='"+t_date+"' ^^", 0, 0, 0, 'getPrice');
				}).click(function() {
					var t_addrno = $.trim($('#txtStraddrno').val());
					var t_date = $.trim($('#txtTrandate').val());
					var t_saction = $.trim($('#cmbCstype').val());
					q_gt('addrs', "where=^^ noa='"+t_addrno+"' and custunit='"+t_saction+"' and datea<='"+t_date+"' ^^", 0, 0, 0, 'getPrice');
				}).blur(function() {
					var t_addrno = $.trim($('#txtStraddrno').val());
					var t_date = $.trim($('#txtTrandate').val());
					var t_saction = $.trim($('#cmbCstype').val());
					q_gt('addrs', "where=^^ noa='"+t_addrno+"' and custunit='"+t_saction+"' and datea<='"+t_date+"' ^^", 0, 0, 0, 'getPrice');
				});
				
				$('#txtInmount').change(function(){
					$('#txtOutmount').val($('#txtInmount').val());
					sum();
				});
				$('#txtPton').change(function(){
					sum();
				});
				$('#txtPrice').change(function(){
					sum();
				});
				$('#txtCustdiscount').change(function(){
                    sum();
                });
                
				
				$('#txtOutmount').change(function(){
					sum();
				});
				$('#txtPton2').change(function(){
					sum();
				});
				$('#txtPrice2').change(function(){
					sum();
				});
				$('#txtPrice3').change(function(){
					sum();
				});
				$('#txtOverw').change(function(){
                    sum();
                });
                $('#txtOverh').change(function(){
                    sum();
                });
				$('#txtDiscount').change(function(){
					sum();
				});
                
				$("#txtStraddrno").focus(function() {
					var input = document.getElementById ("txtStraddrno");
		            if (typeof(input.selectionStart) != 'undefined' ) {	  
		                input.selectionStart =  $(input).val().replace(/^(\w+\u002D).*$/g,'$1').length;
		                input.selectionEnd = $(input).val().length;
		            }
				});
				q_xchgForm();
			}

			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
			}

			function q_gtPost(t_name) {
				switch (t_name) {
                	
					case 'transInit_1':
						var as = _q_appendData("carteam", "", true);
						z_carteam = new Array();
						if(as[0]!=undefined){
							for(var i=0;i<as.length;i++){
								z_carteam.push({noa:as[i].noa,team:as[i].team});
							}
						}
						q_gt('calctype2', '', 0, 0, 0, 'transInit_2');
						break;
					case 'transInit_2':
						var as = _q_appendData("calctypes", "", true);
						z_calctypes = new Array();
						if(as[0]!=undefined){
							for(var i=0;i<as.length;i++){
								z_calctypes.push({noa:as[i].noa,noq:as[i].noq
									,typea:as[i].typea,isoutside:as[i].isoutside
									,discount:as[i].discount,discount2:as[i].discount2});
							}
						}
						q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
						break;
					case 'getPrice':
						var t_price = 0;
						var t_price2 = 0;
						var t_price3 = 0;
						var as = _q_appendData("addrs", "", true);
						if(as[0]!=undefined){
							t_price = as[0].custprice;
						 	t_price2 = as[0].driverprice;
							t_price3 = as[0].driverprice2;
						}
						$('#txtPrice').val(t_price);
						$('#txtPrice2').val(t_price2);
						$('#txtPrice3').val(t_price3);
						sum();
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
						break;
				}
			}
			function q_popPost(id) {
				switch(id) {
					case 'txtCarno':
						if(q_cur==1 || q_cur==2){
							$('#txtDriverno').focus();
						}
						break;
					case 'txtStraddrno':
						var t_addrno = $.trim($('#txtStraddrno').val());
						var t_date = $.trim($('#txtTrandate').val());
						var t_saction = $.trim($('#cmbCstype').val());
						q_gt('addrs', "where=^^ noa='"+t_addrno+"' and custunit='"+t_saction+"' and datea<='"+t_date+"' ^^", 0, 0, 0, 'getPrice');
						break;
					default:
						break;
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)
					return;
				q_box('trans_at_s.aspx', q_name + '_s', "550px", "95%", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				$('#txtNoa').val('AUTO');
				$('#txtNoq').val('001');
				$('#txtDatea').val(q_date());
				$('#txtTrandate').val(q_date());
				$('#txtDatea').focus();
			}
			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				$('#txtDatea').focus();
			}
			function btnPrint() {
				q_box('z_transp_at.aspx?'+ r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'trans', "95%", "95%", m_print);
			}
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
			function btnOk() {
				Lock(1,{opacity:0});
				//日期檢查
				if($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())){
					alert(q_getMsg('lblDatea')+'錯誤。');
            		Unlock(1);
            		return;
				}
				if($('#txtTrandate').val().length == 0 || !q_cd($('#txtTrandate').val())){
					alert(q_getMsg('lblTrandate')+'錯誤。');
            		Unlock(1);
            		return;
				}
				//---------------------------------------------------------------
				var t_isoutside = true;
				for(var i=0;i<z_calctypes.length;i++){
					if($('#cmbCalctype').val()==z_calctypes[i].noa+z_calctypes[i].noq){
						t_isoutside = z_calctypes[i].isoutside=="true"?true:false;
						break;
					}
				}
				if(t_isoutside)
					$('#txtPrice2').val(0);
				else
					$('#txtPrice3').val(0);
        		sum();
				//---------------------------------------------------------------
				if(q_cur ==1){
                	$('#txtWorker').val(r_name);
                }else{
                	$('#txtWorker2').val(r_name);
                }
				var t_noa = trim($('#txtNoa').val());
				var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_trans') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else
					wrServer(t_noa);		
			}

			function wrServer(key_value) {
				var i;
				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
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

			function btnPlus(org_htm, dest_tag, afield) {
				_btnPlus(org_htm, dest_tag, afield);
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
		</script>
		<style type="text/css">
			#dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 100%; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 950px;
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
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }
            .tbbs input[type="text"] {
                width: 98%;
            }
            .tbbs a {
                font-size: medium;
            }
            .num {
                text-align: right;
            }
            .bbs {
                float: left;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id="dmain">
			<div class="dview" id="dview">
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id="vewChk"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDatea"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewTrandate"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewCarno"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewDriver"> </a></td>
						<td align="center" style="width:80px; color:black;"><a id="vewNick"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewStraddr"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewMount"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewPrice"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewMount2"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewPrice2"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewPrice3"> </a></td>
						<td align="center" style="width:60px; color:black;"><a id="vewDiscount"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewPo"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewCaseno"> </a></td>
						<td align="center" style="width:120px; color:black;"><a id="vewCustorde"> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox"/></td>
						<td id="datea" style="text-align: center;">~datea</td>
						<td id="trandate" style="text-align: center;">~trandate</td>
						<td id="carno" style="text-align: center;">~carno</td>
						<td id="driver" style="text-align: center;">~driver</td>
						<td id="nick" style="text-align: center;">~nick</td>
						<td id="straddr" style="text-align: center;">~straddr</td>
						<td id="mount" style="text-align: right;">~mount</td>
						<td id="price" style="text-align: right;">~price</td>
						<td id="mount2" style="text-align: right;">~mount2</td>
						<td id="price2" style="text-align: right;">~price2</td>
						<td id="price3" style="text-align: right;">~price3</td>
						<td id="discount" style="text-align: right;">~discount</td>
						<td id="po" style="text-align: left;">~po</td>
						<td id="caseno" style="text-align: left;">~caseno</td>
						<td id="custorde" style="text-align: left;">~custorde</td>
					</tr>
				</table>
			</div>
			<div class="dbbm">
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td> </td>
						<td class="tdZ"> </td>
					</tr>
					<tr>
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td>
							<input id="txtDatea"  type="text" class="txt c1"/>
							<input id="txtMon"  type="text" style="display:none;"/>
							<input id="txtMon2"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a id="lblTrandate" class="lbl"> </a></td>
						<td><input id="txtTrandate"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCalctype" class="lbl"> </a></td>
						<td><select id="cmbCalctype" class="txt c1"> </select></td>
						<td><span> </span><a id="lblCarteam" class="lbl"> </a></td>
						<td>
							<select id="cmbCarteamno" class="txt c1"> </select>
							<input id="txtCarteam" type="text" style="display:none;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCarno" class="lbl btn"> </a></td>
						<td><input id="txtCarno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCardno" class="lbl">板架</a></td>
						<td><input id="txtCardno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td colspan="2">
							<input id="txtDriverno"  type="text" style="float:left;width:50%;"/>
							<input id="txtDriver"  type="text" style="float:left;width:50%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCust" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtCustno"  type="text" style="float:left;width:30%;"/>
							<input id="txtComp"  type="text" style="float:left;width:70%;"/>
							<input id="txtNick" type="text" style="display:none;"/>
						</td>
						<td><span> </span><a class="lbl">作業</a></td>
						<td><select id="cmbCstype" class="txt c1"></select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblStraddr" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtStraddrno"  type="text" style="float:left;width:30%;"/>
							<input id="txtStraddr"  type="text" style="float:left;width:70%;"/>
						</td>
						<td><span> </span><a id="lblUcc" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtUccno"  type="text" style="float:left;width:30%;"/>
							<input id="txtProduct"  type="text" style="float:left;width:70%;"/>
						</td>
					</tr>
					<tr style="background-color: #B18904;">
						<td><span> </span><a id="lblInmount" class="lbl"> </a></td>
						<td><input id="txtInmount"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblPton" class="lbl"> </a></td>
						<td><input id="txtPton"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblPrice" class="lbl"> </a></td>
                        <td><input id="txtPrice"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblCustdiscount" class="lbl">折數％</a></td>
                        <td><input id="txtCustdiscount"  type="text" class="txt c1 num"/></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: #B18904;">
					    <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
					    <td><span> </span><a id="lblTotal" class="lbl"> </a></td>
                        <td>
                            <input id="txtMount"  type="text" style="display:none;"/>
                            <input id="txtTotal"  type="text" class="txt c1 num"/>
                        </td>
                        <td class="tdZ"></td>
					</tr>
					<tr style="background-color: #B18904;">
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="7"><input id="txtMemo"  type="text" class="txt c1"/></td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color: pink;">
						<td><span> </span><a id="lblOutmount" class="lbl"> </a></td>
						<td><input id="txtOutmount"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblPton2" class="lbl"> </a></td>
						<td><input id="txtPton2"  type="text" class="txt c1 num"/></td>
						<td><span> </span>
							<a class="lbl">公司車單價</a>
						</td>
						<td><input id="txtPrice2"  type="text" class="txt c1 num"/></td>
						<td><a id="lblPrice3" class="lbl"> </a></td>
                        <td><input id="txtPrice3"  type="text" class="txt c1 num"/></td>
						<td class="tdZ"></td>
					</tr>
					<tr  style="background-color:pink;">
					    <td><span> </span><a class="lbl">扣％(百分比)</a></td>
                        <td><input id="txtOverw"  type="text" class="txt c1 num"/></td>
                        <td><span> </span><a class="lbl">抽成(百分比)</a></td>
                        <td><input id="txtOverh"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblDiscount" class="lbl"> </a></td>
						<td><input id="txtDiscount"  type="text" class="txt c1 num"/></td>
						<td><span> </span><a id="lblTotal2" class="lbl"> </a></td>
                        <td>
                            <input id="txtMount2"  type="text" style="display:none;"/>
                            <input id="txtTotal2"  type="text" class="txt c1 num"/>
                        </td>
						<td class="tdZ"></td>
					</tr>
					<tr style="background-color:pink;">
						<td><span> </span><a id="lblSender" class="lbl">備註</a></td>
						<td colspan="7"><input id="txtSender"  type="text" class="txt c1"/></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPo" class="lbl"> </a></td>
						<td colspan="2"><input id="txtPo"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCustorde" class="lbl"> </a></td>
						<td colspan="2"><input id="txtCustorde" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblSo" class="lbl"> </a></td>
						<td colspan="2"><input id="txtSo"  type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblCaseno" class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtCaseno"  type="text" style="float:left;width:50%;"/>
							<input id="txtCaseno2"  type="text" style="float:left;width:50%;"/>
						</td>
						<td><span> </span><a id="lblCasetype" class="lbl"> </a></td>
						<td><input id="txtCasetype" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblMiles" class="lbl"> </a></td>
						<td><input id="txtMiles"  type="text" class="txt c1 num"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td>
							<input id="txtNoa"  type="text" class="txt c1"/>
							<input id="txtNoq"  type="text" style="display:none;"/>
						</td>
						<td><span> </span><a class="lbl">轉來</a></td>
						<td><input id="txtOrdeno"  type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
