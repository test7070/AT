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
			var q_name = 'tranmsg';
            var _curData = new Array();
            var _timeout;
			
            $(document).ready(function() {
            	_q_boxClose();
                q_getId();
                q_gf('', 'tranmsg');
				
				$('#curCarno').text(q_getId()[3]);
				$('#btnAuthority').click(function () {
                    btnAuthority(q_name);
                });
            });
            function q_gfPost() {
                q_langShow();
                init();
                $('#btnRefresh').click();
            }

			function init(){
				//-------Send
				$('#btnSend').click(function(e){
					var t_msg = $.trim($('#message').val());
					if(t_msg.length==0){
						alert('請輸入資料。');
						return;
					}
					stoptimeout();
					var t_data = JSON.stringify({sender:r_name,carno:encodeURI($('#curCarno').text()),sendmsg:encodeURI(t_msg)});
					console.log(t_data);
					$.ajax({
	                    url: 'tranmsg_at_data.aspx',
	                    headers: { 'database': q_db,'action':'setdata'},
	                    type: 'POST',
	                    data: t_data,
	                    dataType: 'text',
	                    timeout: 10000,
	                    success: function(data){
	                    	console.log(data);
	                    },
	                    complete: function(){
	                    	$('#message').val('');
	                    	$('#btnRefresh').click();
	                    	timeout();            
	                    },
	                    error: function(jqXHR, exception) {
	                        var errmsg = 'Send Error。\n';
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
				//-------REFRESH
				$('#btnRefresh').click(function(e){
					$.ajax({
	                    url: 'tranmsg_at_data.aspx',
	                    headers: { 'database': q_db,'action':'getdata','carno':encodeURI($('#curCarno').text())},
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
	                    	refresh('msg');               
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
			    _timeout = setTimeout(function () {
			        $('#btnRefresh').click();
			        timeout();
			    }, 30000);
			}
			function stoptimeout(){
				clearTimeout(_timeout);
			}
			function refresh(key){
				for(var i=_curData.length-1;i>=0;i--){
					var n = $('#'+key).find('.tData').find('tr').length;
					if(n==0){
						$('#'+key).find('.tData').prepend($('#'+key).find('.tSchema').find('tr').eq(0).clone().data('key', n).data('data',''));
					}else{
						if($('#'+key).find('.tData').find('tr').first().data("seq")>=_curData[i].seq){
							continue;
						}else{
							$('#'+key).find('.tData').prepend($('#'+key).find('.tSchema').find('tr').eq(0).clone().data('key', n).data('data',''));
						}
					}
					$('#'+key).find('.tData').find('tr').first().data("seq",_curData[i].seq);
					var obj = $('#'+key).find('.tData').find('tr').first().find('td').find('a');
					for(var j=0;j<obj.length;j++){
						t_id = obj.eq(j).attr('id');
						obj.eq(j).addClass(t_id).attr('id',t_id+'_'+n);
					}
					$('#txtSender_'+n).text(_curData[i].sender);
					$('#txtSendtime_'+n).text(_curData[i].sendtime);
					$('#txtSendmsg_'+n).text(_curData[i].sendmsg);
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
		<div style="min-width:100%;width: 100%;height:40px;float:none;">
			<div id="curCarno" style="float:left;"></div>
			<span style="display:block;width:50px;float:left;text-align: center;">&nbsp;</span>
			<input type='button' id='btnRefresh' name='btnRefresh' style='font-size:16px;float:left;' value='資料更新'/>
			<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;float:left;' value='權限'/>
			<span style="display:block;width:50px;float:left;text-align: center;">&nbsp;</span>
		</div>
		<div style="min-width:100%;width: 100%;height:30px;float:none;">
			<input id="message" style="float:left;font-size:16px;width:500px;"/>
			<span style="display:block;width:20px;float:left;text-align: center;">&nbsp;</span>
			<input type='button' id='btnSend' name='btnSend' style='font-size:16px;float:left;width:80px;' value='發送'/>
		</div>
		<div id="msg" style="float:left;">
			<div style="min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tHeader">
					<tr>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>發送人</a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a>時間</a></td>
						<td align="center" style="width:350px; max-width:350px;color:black;"><a>訊息</a></td>
					</tr>
				</table>
			</div>
			<div style="display:none;min-width:600px;width: 600px;overflow-y:scroll;">
				<table class="tSchema">
					<tr>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtSender"> </a></td>
						<td align="center" style="width:100px; max-width:100px;color:black;"><a id="txtSendtime"> </a></td>
						<td align="center" style="width:350px; max-width:350px;color:black;"><a id="txtSendmsg"> </a></td>
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
