<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			//update date:  2015/11/24
			var q_name = "cust_s";
			aPop = new Array(
				['txtNoa', 'lblNoa', 'cust', 'noa,comp,nick', 'txtNoa', ''],
				['txtSerial', 'lblSerial', 'cust', 'serial,noa,comp,nick', 'txtSerial', '']
			);
			
			$(document).ready(function() {
				main();
			});

			function main() {
				mainSeek();
				q_gf('', q_name);
			}
			
			function q_gfPost() {
				q_getFormat();
				q_langShow();
				
				var t_type = q_getMsg('at.typea').split('^');
				for(var i=0;i<t_type.length;i++){
					$('#listType').append('<option value="'+t_type[i]+'"></option>');
				}
				$('#txtNoa').focus();
			}
			function q_gtPost (t_name) {
				switch (t_name) {
				 	default:
						break;
				}
			}

			function q_seekStr() {
				t_type = $('#txtTypea').val();
				t_noa = $('#txtNoa').val();
				t_comp = $('#txtComp').val();
				t_serial = $('#txtSerial').val();
				t_tel = $('#txtTel').val();
				t_memo = $('#txtMemo').val();
				
				
				var t_where = " 1=1 ";
					
				if (t_noa.length > 0)
					t_where += " and charindex('" + t_noa + "',noa)>0";
				if (t_comp.length > 0)
                    t_where += " and (charindex('" + t_comp + "',comp)>0 or charindex('" + t_comp + "',nick)>0)";
				if (t_serial.length > 0)
					t_where += " and charindex('" + t_serial + "',serial)>0";
				if (t_memo.length > 0)
					t_where += " and charindex('" + t_memo + "',memo)>0";
				if (t_tel.length > 0)
					t_where += " and (charindex('" + t_tel + "',tel)>0 or charindex('" + t_tel + "',mobile)>0 or charindex('" + t_tel + "',fax)>0)";
				if (t_type.length > 0)
					t_where += " and charindex('" + t_type + "',typea)>0";	
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				background-color: #76a2fe
			}
		</style>
	</head>
	<body>
		<datalist id="listType"> </datalist>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
                    <td class='seek'  style="width:20%;"><a id='lblTypea'> </a>類別</td>
                    <td><input class="txt" id="txtTypea" list="listType" type="text" style="width:215px; font-size:medium;" /></td>
                </tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'>編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'>名稱</a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSerial'>統編</a></td>
					<td><input class="txt" id="txtSerial" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>電話、傳真、行動</a></td>
					<td><input class="txt" id="txtTel" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblMemo'>備註</a></td>
					<td><input class="txt" id="txtMemo" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
