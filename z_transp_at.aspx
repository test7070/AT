<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" >
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"> </script>
		<script src="css/jquery/ui/jquery.ui.widget.js"> </script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"> </script>
		<script type="text/javascript">
            aPop = new Array(['txtCarno', 'lblCarno', 'car2', 'a.noa,driverno,driver', 'txtCarno', 'car2_b.aspx']);
            var t_carteam = null;
            var t_calctypes = null;
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_transp_at');       
            });

            function q_gfPost() {
            	q_gt('carteam', '', 0, 0, 0, "load_1");
            }
			function q_boxClose(s2) {
            	
			}
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'load_1':
                        t_carteam = '';
                        var as = _q_appendData("carteam", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_carteam += (t_carteam.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].team;
                        }
                        q_gt('calctype2', '', 0, 0, 0, "load_2");
                        break;
                    case 'load_2':
                        t_calctypes = '';
                        var as = _q_appendData("calctypes", "", true);
                        for ( i = 0; i < as.length; i++) {
                            t_calctypes += (t_calctypes.length > 0 ? ',' : '') + as[i].noa + as[i].noq + '@' + as[i].typea;
                        }
                        LoadFinish();
                        break;
                    default:
                        break;
                }
            }
            
            function LoadFinish(){
            	$('#q_report').q_report({
					fileName : 'z_transp_at',
					options : [{/*1-[1],[2]*/
                        type : '1',
                        name : 'datea'
                    },{/*2-[3],[4]*/
                        type : '1',
                        name : 'trandate'
                    }, {/*3-[5],[6]*/
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*4-[7],[8]*/
                        type : '2',
                        name : 'driver',
                        dbf : 'driver',
                        index : 'noa,namea',
                        src : 'driver_b.aspx'
                    }, {/*5 [9]*/
                        type : '6',
                        name : 'carno'
                    }, {/*6 [10]*/
                        type : '6',
                        name : 'cardno'
                    }, {/*7-[11]-車隊*/
                        type : '8',
                        name : 'carteam',
                        value : t_carteam.split(',')
                    }, {/*8-[12]-計算類別*/
                        type : '8',
                        name : 'calctype',
                        value : t_calctypes.split(',')
                    }, {/*9-[13],[14]-起迄地點*/
                        type : '2',
                        name : 'addr',
                        dbf : 'addr',
                        index : 'noa,addr',
                        src : 'addr_b.aspx'
                    }, {/*10 [15]*/
                        type : '6',
                        name : 'caseno'
                    }, {/*11 [16]*/
                        type : '6',
                        name : 'casetype'
                    }]
				});
				q_popAssign();
	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            	$('#txtNoa').val(t_para.noa);
	            }catch(e){
	            	
	            }    
	            $('#txtDatea1').mask('999/99/99');
                $('#txtDatea1').datepicker();
                $('#txtDatea2').mask('999/99/99');
                $('#txtDatea2').datepicker();
                $('#txtTrandate1').mask('999/99/99');
                $('#txtTrandate1').datepicker();
                $('#txtTrandate2').mask('999/99/99');
                $('#txtTrandate2').datepicker();
            }
		</script>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();">
		<div id="q_menu"> </div>
		<div style="position: absolute;top: 10px;left:50px;z-index: 1;width:2000px;">
			<div id="container">
				<div id="q_report"> </div>
			</div>
			<div class="prt" style="margin-left: -40px;">
				<!--#include file="../inc/print_ctrl.inc"-->
			</div>
		</div>
	</body>
</html>
           
          