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
			var q_name = 'transtatus';
            var _curData = new Array();
			
            $(document).ready(function() {
            	_q_boxClose();
                q_getId();
                q_gf('', 'transtatus');
				
				$('#btnAuthority').click(function () {
                    btnAuthority(q_name);
                });
            });
            function q_gfPost() {
                q_langShow();
                init();
				$('#btnRefresh').click();
				$('#btnCar').click(function(e){
					$('#car').toggle();
				});
				$('#btnCard').click(function(e){
					$('#card').toggle();
				});
				$('#btnYard').click(function(e){
					$('#yard').toggle();
				});
            }

			function init(){
				
				//-------REFRESH
				$('#btnRefresh').click(function(e){
					$.ajax({
	                    url: 'transtatus_at_getdata.aspx',
	                    headers: { 'database': q_db},
	                    type: 'POST',
	                    data: '',
	                    dataType: 'text',
	                    timeout: 10000,
	                    success: function(data){
	                    	try{
	                    		_curData = JSON.parse(data);
	                    	}catch(e){
	                    	}
	                    },
	                    complete: function(){
	                    	refresh('car'); 
	                    	refresh('card'); 
	                    	refresh('yard');                  
	                    },
	                    error: function(jqXHR, exception) {
	                        var errmsg = this.url+'資料讀取異常。\n';
	                        if (jqXHR.status === 0) {
	                            alert(errmsg+'Not connect.\n Verify Network.');
	                        } else if (jqXHR.status == 404) {
	                            alert(errmsg+'Requested page not found. [404]');
	                        } else if (jqXHR.status == 500) {
	                            alert(errmsg+'Internal Server Error [500].');
	                        } else if (exception === 'parsererror') {
	                            alert(errmsg+'Requested JSON parse failed.');
	                        } else if (exception === 'timeout') {
	                            alert(errmsg+'Time out error.');
	                        } else if (exception === 'abort') {
	                            alert(errmsg+'Ajax request aborted.');
	                        } else {
	                            alert(errmsg+'Uncaught Error.\n' + jqXHR.responseText);
	                        }
	                    }
	                });
				});
				timeout();
			}
			function timeout() {
			    setTimeout(function () {
			        $('#btnRefresh').click();
			        timeout();
			    }, 30000);
			}
			function refresh(key){
				
				while($('#'+key).find('.tData').find('tr').length<_curData[key].length){
					var n = $('#'+key).find('.tData').find('tr').length;
					$('#'+key).find('.tData').append($('#'+key).find('.tSchema').find('tr').eq(0).clone().data('key', n).data('data',''));
					
					for(var i=0;i<$('#'+key).find('.tData').find('tr').last().find('td').length;i++){
						var obj = $('#'+key).find('.tData').find('tr').last().find('td').eq(i).find('input[type="button"]').eq(0);
						obj.attr('id',obj.attr('id')+'_'+key+'_'+n).attr('value',n+1);
						obj.click(function(e){
							if($(this).attr('id').indexOf('btnSel_car_')<0)
								return;
							var n = $(this).attr('id').replace(/(btnSel_car_)(.*)/g,'$2');
							var t_carno = $('#txtNoa_car_'+n).text(); 
							q_box("tranmsg_at.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_carno + ";" + r_accy, '', "95%", "95%", q_getMsg("popTranmsg"));
						});
						
						var obj = $('#'+key).find('.tData').find('tr').last().find('td').eq(i).find('a');
						for(var k=0;k<obj.length;k++){
							t_id = obj.eq(k).attr('id');
							obj.eq(k).addClass(t_id+'_'+key).attr('id',t_id+'_'+key+'_'+n);
						}
					}
				}
				for(var i=0;i<$('#'+key).find('.tData').find('tr').length;i++){
					if(i<_curData[key].length){
						$('#'+key).find('.tData').find('tr').eq(i).css('display','');
						$('#txtNoa_'+key+'_'+i).text(_curData[key][i].noa);
						$('#txtQtime_'+key+'_'+i).text(_curData[key][i].qtime);
						$('#txtMemo_'+key+'_'+i).text(_curData[key][i].memo);
						
						
					}else{
						$('#'+key).find('.tData').find('tr').eq(i).css('display','none');		
					}
				}
			}
			
		</script>
		<style type="text/css">
            .tHeader {
                border: 1px solid gray;
                background-color: gray;
            }
            .tHeader td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: darkblue;
            }
            .tHeader a {
                color: white;
            }
            .tData {
                border: 1px solid gray;
                background-color: white;
            }
            .tData tr {
                height:35px;
            }
            .tData td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #cad3ff;
            }
            .tData td.edit {
            	background-color: pink;
                /*background-color: #FF8800;*/
            }
            .tData a {
                color: black;
            }
		</style>
	</head>
	<body>
		<div style="min-width:1500px;width: 1500px;height:40px;float:none;">
			<div id='q_menu'></div>
			<span style="display:block;width:50px;float:left;text-align: center;">&nbsp;</span>
			<input type='button' id='btnRefresh' name='btnRefresh' style='font-size:16px;float:left;' value='資料更新'/>
			<input type='button' id='btnPrint' name='btnPrint' style='font-size:16px;float:left;' value='列印'/>
			<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;float:left;' value='權限'/>
			<span style="display:block;width:50px;float:left;text-align: center;">&nbsp;</span>
			<input type='button' id='btnCar' style='font-size:16px;float:left;' value='車輛'/>
			<input type='button' id='btnCard' style='font-size:16px;float:left;' value='板台'/>
			<input type='button' id='btnYard' style='font-size:16px;float:left;' value='車場'/>
		</div>
		<div id="car" style="float:left;">
			<div style="min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tHeader">
					<tr>
						<td align="center" style="width:50px; max-width:50px; color:black; font-weight: bolder;"><a>序</a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>車牌</a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>時間</a></td>
						<td align="center" style="width:350px; max-width:350px;color:black;"><a>備註</a></td>
					</tr>
				</table>
			</div>
			<div style="display:none;min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tSchema">
					<tr>
						<td align="center" style="width:50px; max-width:50px; color:black;"><input id="btnSel" type="button" class="btnSel"/></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtNoa"> </a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtQtime"> </a></td>
						<td align="center" style="width:350px; max-width:350px;color:black;"><a id="txtMemo"> </a></td>
					</tr>
				</table>
			</div>
			<div style="min-width:600px;width: 600px;height:800px;overflow-y:scroll;">
				<table class="tData">
				</table>
			</div>
		</div>
		<div id="card" style="float:left;">
			<div style="min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tHeader">
					<tr>
						<td align="center" style="width:50px; max-width:50px; color:black; font-weight: bolder;"><a>序</a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>板台</a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>時間</a></td>
						<td align="center" style="width:350px; max-width:350px;color:black;"><a>備註</a></td>
					</tr>
				</table>
			</div>
			<div style="display:none;min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tSchema">
					<tr>
						<td align="center" style="width:50px; max-width:50px; color:black;"><input id="btnSel" type="button" class="btnSel"/></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtNoa"> </a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtQtime"> </a></td>
						<td align="center" style="width:400px; max-width:350px;color:black;"><a id="txtMemo"> </a></td>
					</tr>
				</table>
			</div>
			<div style="min-width:600px;width: 600px;height:800px;overflow-y:scroll;">
				<table class="tData">
				</table>
			</div>
		</div>
		<div id="yard" style="float:left;">
			<div style="min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tHeader">
					<tr>
						<td align="center" style="width:50px; max-width:50px; color:black; font-weight: bolder;"><a>序</a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>車場</a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>時間</a></td>
						<td align="center" style="width:350px; max-width:350px;color:black;"><a>備註</a></td>
					</tr>
				</table>
			</div>
			<div style="display:none;min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tSchema">
					<tr>
						<td align="center" style="width:50px; max-width:50px; color:black;"><input id="btnSel" type="button" class="btnSel"/></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtNoa"> </a></td>
						<td align="center" style="width:100px; max-width:150px;color:black;"><a id="txtQtime"> </a></td>
						<td align="center" style="width:350px; max-width:400px;color:black;"><a id="txtMemo"> </a></td>
					</tr>
				</table>
			</div>
			<div style="min-width:600px;width: 600px;height:800px;overflow-y:scroll;">
				<table class="tData">
				</table>
			</div>
		</div>
	</body>
</html>
