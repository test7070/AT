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
            var q_name = "tranorde_at_s";
            aPop = new Array(['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']);

            $(document).ready(function() {
                main();
            });
            /// end ready

            function main() {
                mainSeek();
                q_gf('', q_name);
            }

            function q_gfPost() {
                q_getFormat();
                q_langShow();

                bbmMask = [['txtBdate', r_picd], ['txtEdate', r_picd],['txtBdate2', r_picd], ['txtEdate2', r_picd]];
                q_mask(bbmMask);
				$('#txtBdate').datepicker();
				$('#txtEdate').datepicker();
				$('#txtBdate2').datepicker();
				$('#txtEdate2').datepicker(); 
                $('#txtNoa').focus();
            }

            function q_seekStr() {
                t_noa = $('#txtNoa').val();
                t_bdate = $('#txtBdate').val();
                t_edate = $('#txtEdate').val();
                t_custno = $('#txtCustno').val();
                t_comp = $('#txtComp').val();
                t_trackno = $('#txtTrackno').val();
                t_caseno = $('#txtCaseno').val();
				t_bdate2 = $('#txtBdate2').val();
                t_edate2 = $('#txtEdate2').val();
                
                var t_where = " stype='進口' " 
                	+ q_sqlPara2("noa", t_noa) 
                	+ q_sqlPara2("datea", t_bdate, t_edate) 
                	+ q_sqlPara2("ef", t_bdate2, t_edate2) 
                	+ q_sqlPara2("custno", t_custno)
                	+ q_sqlPara2("trackno", t_trackno) ;
				if (t_comp.length>0)
                    t_where += " and charindex('" + t_comp + "',comp)>0";
                if (t_caseno.length>0)
                    t_where += " and exists(select view_tranorde"+r_accy+".noa from view_tranordes"+r_accy+" where view_tranordes"+r_accy+".noa=view_tranorde"+r_accy+".noa and  (charindex('"+t_caseno+"',view_tranordes"+r_accy+".containerno1)>0 or charindex('"+t_caseno+"',view_tranordes"+r_accy+".containerno2)>0))";
                     
                t_where = ' where=^^' + t_where + '^^ ';
                return t_where;
            }
		</script>
		<style type="text/css">
            .seek_tr {
                color: white;
                text-align: center;
                font-weight: bold;
                BACKGROUND-COLOR: #76a2fe
            }
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDate'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblDate2'>重櫃期限</a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate2" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate2" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'></a></td>
					<td>
					<input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCustno'></a></td>
					<td>
					<input class="txt" id="txtCustno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'></a></td>
					<td>
					<input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTrackno'>追蹤號碼</a></td>
					<td>
					<input class="txt" id="txtTrackno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblCaseno'>櫃號</a></td>
					<td>
					<input class="txt" id="txtCaseno" type="text" style="width:215px; font-size:medium;" />
					</td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
