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
		<script type="text/javascript">

			var q_name = "trandv";
			
			aPop = new Array(['textDriverno', 'lblDriver', 'driver', 'noa,namea', '0textDriverno,textDriver', 'driver_b.aspx']);
			
			var chk_tranvcces=''; //儲存要派車通知的資料
			
			function tranvcces() {
            }
            tranvcces.prototype = {
                data : null,
                tbCount : 15,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                load : function(){
                    var string = "<table id='tranvcces_table' style='width:1260px;'>";
                    string+='<tr id="tranvcces_header">';
                    string+='<td id="tranvcces_seq" align="center" style="color:black;display:none;">Seq</td>';
                    string+='<td id="tranvcces_seq" align="center" style="color:black;display:none;">發送時間</td>';
                    string+='<td id="tranvcces_enda" align="center" style="width:40px; color:black;">回報</td>';
                    string+='<td id="tranvcces_carno" onclick="tranvcces.sort(\'carno\',false)" title="車號" align="center" style="width:100px; color:black;">車號</td>';
                    string+='<td id="tranvcces_driver" onclick="tranvcces.sort(\'driver\',false)" title="司機" align="center" style="width:100px; color:black;">司機</td>';
                    string+='<td id="tranvcces_work" onclick="tranvcces.sort(\'work\',false)" title="作業" align="center" style="width:40px; color:black;">作業</td>';
                    string+='<td id="tranvcces_message" align="center" style="color:black;">任務內容</td>';
                    string+='</tr>';
                    
                    var t_color = ['DarkBlue','DarkRed'];
                    for(var i=0;i<this.tbCount;i++){
                        string+='<tr id="tranvcces_tr'+i+'">';
                        string+='<td id="tranvcces_seq'+i+'" style="text-align: center; font-weight: bolder; color:black;display:none;"></td>';
                        string+='<td id="tranvcces_sendtime'+i+'" style="text-align: center; font-weight: bolder; color:black;display:none;"></td>';
                        string+='<td id="tranvcces_enda'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"><input class="tranvcces_btn" id="btnEnda_'+i+'" type="button" value="'+(i+1)+'" style=" width: 35px;" /></td>';
                        string+='<td id="tranvcces_carno'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="tranvcces_driver'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="tranvcces_work'+i+'" style="text-align: center;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='<td id="tranvcces_message'+i+'" style="text-align: left;color:'+t_color[i%t_color.length]+'"></td>';
                        string+='</tr>';
                    }
                    string+='</table>';
                    
                    $('#tranvcces').append(string);
                    string='';
                    string+='<a style="float:left;">車號</a><input id="textCarno"  type="text" style="float:left;width:100px;"/>';
                    string+='<a id="lblDriver" style="float:left;">司機編號</a><input id="textDriverno"  type="text" style="float:left;width:100px;"/>';
                    string+='<a id="lblDriver" style="float:left;">司機姓名</a><input id="textDriver"  type="text" style="float:left;width:100px;"/>';
                    string+='<input id="btnTranvcces_refresh"  type="button" style="float:left;width:100px;" value="任務刷新"/>';
                    string+='<input id="btnTranvcces_previous" onclick="tranvcces.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string+='<input id="btnTranvcces_next" onclick="tranvcces.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string+='<input id="textCurPage" onchange="tranvcces.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string+='<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string+='<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    $('#tranvcces_control').append(string);
                },
                init : function(obj) {
                    //結案
                    $('.tranvcces_btn').click(function(e) {
                        //顯示BBS的資料
                        var n=$(this).attr('id').replace('btnEnda_','')
                        tranvcces_n=n;
                        $('#textSeq').val($('#tranvcces_seq'+n).text());
                        $('#textField').val($('#tranvcces_work'+n).text());
                        $('#textSendtime').val($('#tranvcces_sendtime'+n).text());
                        $('#textDatea').val(q_date());
                        $('#textTimea').val(padL(new Date().getHours(), '0', 2)+':'+padL(new Date().getMinutes(),'0',2));
                        //資料清空
                        $('#textCaseno').val('');
                        $('#textCaseno2').val('');
                        $('#textCardno').val('');
                        $('#textPo').val('');
                        $('#textMiles').val('');
                        //顯示
                        $('#div_return').css('top',e.pageY);
						$('#div_return').css('left',e.pageX);
                        $('#div_return').show();
                        
                        $('#tranvcces_control').hide();
                        $('.tranvcces_btn').attr('disabled', 'disabled');
                    });
                    
                    
                    this.data = new Array();
                    if (obj[0] != undefined) {
                        for (var i in obj)
                            if (obj[i]['seq'] != undefined ){
                                this.data.push(obj[i]);
                            }
                    }
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('seq', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                    //訂單排序
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[tranvcces.curIndex] == undefined ? "0" : a[tranvcces.curIndex]);
                            var n = parseFloat(b[tranvcces.curIndex] == undefined ? "0" : b[tranvcces.curIndex]);
                            if (m == n) {
                                if (a['seq'] < b['seq'])
                                    return 1;
                                if (a['seq'] > b['seq'])
                                    return -1;
                                return 0;
                            } else
                                return n - m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[tranvcces.curIndex] == undefined ? "" : a[tranvcces.curIndex];
                            var n = b[tranvcces.curIndex] == undefined ? "" : b[tranvcces.curIndex];
                            if (m == n) {
                                if (a['seq'] < b['seq'])
                                    return 1;
                                if (a['seq'] > b['seq'])
                                    return -1;
                                return 0;
                            } else {
                                if (m < n)
                                    return 1;
                                if (m > n)
                                    return -1;
                                return 0;
                            }
                        });
                    }
                    this.page(1);
                },
                next : function() {
                    if (this.curPage == this.totPage) {
                        alert('最末頁。');
                        return;
                    }
                    this.curPage++;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                previous : function() {
                    if (this.curPage == 1) {
                        alert('最前頁。');
                        return;
                    }
                    this.curPage--;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                page : function(n) {
                    if (n <= 0 || n > this.totPage) {
                        this.curPage = 1;
                        $('#textCurPage').val(this.curPage);
                        this.refresh();
                        return;
                    }
                    this.curPage = n;
                    $('#textCurPage').val(this.curPage);
                    this.refresh();
                },
                refresh : function() {
                    //頁面更新
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ((n + i) < this.data.length) {
                        	$('#btnEnda_' + i).removeAttr('disabled');
                            $('#tranvcces_seq' + i).html(this.data[n+i]['seq']);
                            $('#tranvcces_sendtime' + i).html(this.data[n+i]['sendtime']);
                            $('#tranvcces_carno' + i).html(this.data[n+i]['carid']);
                            $('#tranvcces_driver' + i).html(this.data[n+i]['driver']);
                            $('#tranvcces_work' + i).html(this.data[n+i]['field']);
                            $('#tranvcces_message' + i).html(this.data[n+i]['message']);
                        } else {
                            $('#btnEnda_' + i).attr('disabled', 'disabled');
                            $('#tranvcces_seq' + i).text('');
                            $('#tranvcces_carno' + i).html('');
                            $('#tranvcces_driver' + i).html('');
                            $('#tranvcces_work' + i).html('');
                            $('#tranvcces_message' + i).html('');
                        }
                    }
                }
            };
            tranvcces = new tranvcces();

			$(document).ready(function() {		
				_q_boxClose();
                q_getId();
                q_gf('', q_name);
                tranvcces.load();
			});
			
			function q_gfPost() {
				q_getFormat();
                q_langShow();
                q_popAssign();
                q_cur=2;
                
                $('#textDatea').mask(r_picd);
                $('#textTimea').mask('99:99');
                
                t_where="where=^^1=1 and cast(seq as nvarchar(50))+'-'+field+'-'+CONVERT(VARCHAR(50),sendtime,20) in (select cast(seq as nvarchar(50))+'-'+field+'-'+MAX(isnull(CONVERT(VARCHAR(50),sendtime,20),'')) from tranvcces group by cast(seq as nvarchar(50)),field ) and isnull(receivetime,'')='' ^^";
				q_gt('tranvcces', t_where, 0, 0, 0,'tranvcces_init', r_accy);
                
                $('#btnTranvcces_refresh').click(function(e) {
                    var t_where = "1=1 and cast(seq as nvarchar(50))+'-'+field+'-'+CONVERT(VARCHAR(50),sendtime,20) in (select cast(seq as nvarchar(50))+'-'+field+'-'+MAX(isnull(CONVERT(VARCHAR(50),sendtime,20),'')) from tranvcces group by cast(seq as nvarchar(50)),field ) and isnull(receivetime,'')='' ";
                    var t_carno = $('#textCarno').val();
                    var t_driverno = $('#textDriverno').val();
                    var t_driver = $('#textDriver').val();
                    
                    t_where += q_sqlPara2("carid", t_carno)+q_sqlPara2("driverno", t_driverno)+q_sqlPara2("driver", t_driver);
                    
                    t_where="where=^^"+t_where+"^^";
                    Lock();
					q_gt('tranvcces', t_where, 0, 0, 0,'tranvcces_init', r_accy);
                });
                
                $('#btnClose_div_return').click(function(e) {
                	for (var i = 0; i < tranvcces.tbCount; i++) {
                        if (!emp($('#tranvcces_seq' + i).text())) 
                    	    $('#btnEnda_' + i).removeAttr('disabled');
					}
                   //$('.tranvcces_btn').removeAttr('disabled');
                   $('#div_return').hide();
                   $('#tranvcces_control').show();
                });
                
                $('#btnOk_div_return').click(function(e) {
                   //$('.tranvcces_btn').removeAttr('disabled');
                   if(!emp($('#textSeq').val())&&!emp($('#textField').val())&&!emp($('#textSendtime').val())){
						var datea=[];
						datea[0]={
							seq:$('#textSeq').val(),
							field:$('#textField').val(),
							sendtime:$('#textSendtime').val().substr(0,$('#textSendtime').val().length-6),
							caseno:$('#textCaseno').val(),
							caseno2:$('#textCaseno2').val(),
							cardno:$('#textCardno').val(),
							po:$('#textPo').val(),
							miles:$('#textMiles').val(),
							receivetime:(dec($('#textDatea').val().substr(0,3))+1911)+$('#textDatea').val().substr(3,6)+' '+$('#textTimea').val()
						}
						
						Lock(1,{opacity:0});
						$.ajax({
		                    url: 'trandv_update.aspx',
		                    headers: { 'database': q_db },
		                    type: 'POST',
		                    data: JSON.stringify(datea[0]),
		                    dataType: 'text',
		                    timeout: 10000,
		                    success: function(data){
		                        if(data.length>0){
		                        	alert(data)
		                        }
		                        //回報後沖刷資料
		                    	$('#btnTranvcces_refresh').click();
		                    },
		                    complete: function(){ 
		                    	Unlock(1);
		                    },
		                    error: function(jqXHR, exception) {
		                        var errmsg = this.url+'資料寫入異常。\n';
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
                   }else{
						alert('資料錯誤!!');
					}
					$('#div_return').hide();
					$('#tranvcces_control').show();
                });
                
            }
            
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}
			
			var mouse_point;
			var tranvcces_n='';//目前tranvcces的列數
			function q_gtPost(t_name) {
				switch (t_name) {
                    case 'tranvcces_init':
                        var as = _q_appendData("tranvcces", "", true);
                        tranvcces.init(as);
                        if (as[0] == undefined){
                            Unlock();
                            alert('無資料。');
                        }
                        break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
						break;
					default:
                        break;
				}
			}
			
			function q_funcPost(t_func, result) {
                switch(t_func) {
                	
                }
			}
			
		</script>
		<style type="text/css">
			#dmain {
				overflow: hidden;
			}
			.dview {
				float: left;
				width: 98%;
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
				width: 98%;
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
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 38%;
				float: left;
			}
			.txt.c3 {
				width: 60%;
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
				font-size: medium;
			}

			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1px;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: #cad3ff;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			#tranvcces_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #tranvcces_table tr {
                height: 30px;
            }
            #tranvcces_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #tranvcces_header td:hover{
                background : yellow;
                cursor : pointer;
            }
		</style>
	</head>
	<body>
		<div id='q_menu'> </div>
		<div id='q_acDiv'> </div>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;' value='權限'/>
		<p> </p>
		<div id="div_return" style="position:absolute; top:300px; left:400px; display:none; width:300px; background-color: #CDFFCE; border: 5px solid gray;">
			<table id="table_return" style="width:100%;" border="1" cellpadding='2'  cellspacing='0'>
				<tr>
					<td style="background-color: #f8d463;" align="center">櫃號1</td>
					<td style="background-color: #f8d463;" colspan="2" ><input id="textCaseno"  type="text" class="txt " style="width: 98%;"/></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">櫃號2</td>
					<td style="background-color: #f8d463;" colspan="2" ><input id="textCaseno2"  type="text" class="txt " style="width: 98%;"/></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">板架</td>
					<td style="background-color: #f8d463;" colspan="2" ><input id="textCardno"  type="text" class="txt " style="width: 98%;"/></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">P/O號碼</td>
					<td style="background-color: #f8d463;" colspan="2"><input id="textPo"  type="text" class="txt " style="width: 98%;"/></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;" align="center">公里數</td>
					<td style="background-color: #f8d463;" colspan="2"><input id="textMiles"  type="text" class="txt " style="width: 98%;"/></td>
				</tr>
				<tr>
					<td style="background-color: #f8d463;width: 100px;" align="center">完成時間</td>
					<td style="background-color: #f8d463;width: 100px;"><input id="textDatea"  type="text" class="txt " style="width: 98%;"/></td>
					<td style="background-color: #f8d463;width: 100px;"><input id="textTimea"  type="text" class="txt " style="width: 98%;"/></td>
				</tr>
				<tr id='return_close'>
					<td align="center" colspan='3'>
						<input id="btnOk_div_return" type="button" value="回報">
						<input id="btnClose_div_return" type="button" value="取消">
						<input id="textSeq"  type="hidden"/>
						<input id="textField"  type="hidden"/>
						<input id="textSendtime"  type="hidden"/>
					</td>
				</tr>
			</table>
		</div>
		<div id="tranvcces" style="float:left;width:1260px;"> </div> 
		<p style="float: left;width: 1260px;"> </p>
		<div id="tranvcces_control" style="width:1200px;"> </div> 
	</body>
</html>