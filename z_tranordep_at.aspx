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
            $(document).ready(function() {
            	q_getId();
                q_gf('', 'z_tranordep_at');       
            });

            function q_gfPost() {
				$('#q_report').q_report({
					fileName : 'z_tranordep_at',
					options : [{/*1-[1],[2]*/
                        type : '1',
                        name : 'strdate'
                    },{/*2-[3],[4]*/
                        type : '1',
                        name : 'dldate'
                    }, {/*3-[5],[6]*/
                        type : '2',
                        name : 'cust',
                        dbf : 'cust',
                        index : 'noa,comp',
                        src : 'cust_b.aspx'
                    }, {/*4-[7]*/
                        type : '6',
                        name : 'contract'
                    }, {/*5-[8]*/
                        type : '8',
                        name : 'stype',
                        value : q_getMsg('stype').split('^')
                    }, {/*6-[9]*/
                        type : '5',
                        name : 'enda',
                        value : (' @全部,Y@結案,N@未結案').split(',')
                    }]
				});
				q_popAssign();
	            var t_para = new Array();
	            try{
	            	t_para = JSON.parse(q_getId()[3]);
	            	$('#txtNoa').val(t_para.noa);
	            }catch(e){
	            	
	            }    
	            $('#txtStrdate1').mask('999/99/99');
                $('#txtStrdate1').datepicker();
                $('#txtStrdate2').mask('999/99/99');
                $('#txtStrdate2').datepicker();
            }

			function q_boxClose(s2) {
            	
			}
            
			function q_gtPost(s2) {
            	
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
           
          