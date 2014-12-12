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
            q_tables = 's';
            var q_name = "transvcce";
            var q_readonly = ['txtNoa', 'txtMount', 'txtWorker', 'txtWorker2', 'txtOrdeno'];
            var q_readonlys = ['txtCommandid', 'txtSendno', 'txtSendid', 'txtSenddate'];
            var bbmNum = [['txtMount', 10, 1, 1]];
            var bbsNum = [['txtMount', 10, 1, 1], ['txtSel', 10, 0, 1]];
            var bbmMask = [['txtDatea', '999/99/99'], ['txtTrandate', '999/99/99'], ['txtTrantime', '99:99']];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
            q_xchg = 1;
            brwCount2 = 10;

            aPop = new Array(['txtCarno_', 'btnCarno_', 'car2', 'a.noa,driverno,driver', 'txtCarno_,txtDriverno_,txtDriver_', 'car2_b.aspx']
            , ['txtDriverno_', 'btnDriver_', 'driver', 'noa,namea,tel', 'txtDriverno_,txtDriver_,txtTel_', 'driver_b.aspx']
            , ['txtAddrno_', 'btnAddr_', 'addr', 'noa,addr', 'txtAddrno_,txtAddr_', 'addr_b.aspx']
            , ['txtCustno', 'lblCust', 'cust', 'noa,comp,nick', 'txtCustno,txtComp,txtNick', 'cust_b.aspx']
            , ['textCustno', 'buttonCust', 'cust', 'noa,comp', 'textCustno', 'cust_b.aspx']);
            //---------------------------------------------------------------------
            function tranorde() {
            }
            tranorde.prototype = {
                data : null,
                tbCount : 10,
                curPage : -1,
                totPage : 0,
                curIndex : '',
                curCaddr : null,
                lock : function() {
                	$('#btnTranorde_refresh').attr('disabled','disabled');
					$('#btnTranorde_previous').attr('disabled','disabled');
					$('#btnTranorde_next').attr('disabled','disabled');
					$('#textCurPage').attr('disabled','disabled');
                    for (var i = 0; i < this.tbCount; i++) {
                        if ($('#tranorde_chk' + i).attr('disabled') != 'disabled') {
                            $('#tranorde_chk' + i).addClass('lock').attr('disabled', 'disabled');
                        }
                    }
                },
                unlock : function() {
                	$('#btnTranorde_refresh').removeAttr('disabled');
					$('#btnTranorde_previous').removeAttr('disabled');
					$('#btnTranorde_next').removeAttr('disabled');
					$('#textCurPage').removeAttr('disabled');
                    for (var i = 0; i < this.tbCount; i++) {
                        if ($('#tranorde_chk' + i).hasClass('lock')) {
                            $('#tranorde_chk' + i).removeClass('lock').removeAttr('disabled');
                        }
                    }
                },

                load : function() {
                    var string = '<table id="tranorde_table">';
                    string += '<tr id="tranorde_header">';
                    string += '<td id="tranorde_chk" align="center" style="width:20px; color:black;"></td>';
                    string += '<td id="tranorde_sel" align="center" style="width:20px; color:black;"></td>';
                    string += '<td id="tranorde_nick" onclick="tranorde.sort(\'custno\',false)" title="客戶" align="center" style="width:100px; color:black;">客戶</td>';
                    string += '<td id="tranorde_noa" onclick="tranorde.sort(\'noa\',false)" title="訂單編號" align="center" style="width:120px; color:black;">訂單編號</td>';
                    string += '<td id="tranorde_stype" onclick="tranorde.sort(\'stype\',false)" title="類型" align="center" style="width:50px; color:black;">類型</td>';
                    string += '<td id="tranorde_strdate" onclick="tranorde.sort(\'strdate\',false)" title="開工日" align="center" style="width:50px; color:black;">開工日</td>';
                    string += '<td id="tranorde_dldate" onclick="tranorde.sort(\'dldate\',false)" title="完工日" align="center" style="width:50px; color:black;">完工日</td>';
					string += '<td id="tranorde_product" title="品名" align="center" style="width:80px; color:black;">品名</td>';
					string += '<td id="tranorde_caseno" title="櫃號" align="center" style="width:120px; color:black;">櫃號</td>';
					string += '<td id="tranorde_casetype" title="櫃型" align="center" style="width:120px; color:black;">櫃型</td>';
                    string += '<td id="tranorde_casetypeB" title="板架" align="center" style="width:120px; color:black;">板架</td>';
                    string += '<td id="tranorde_straddr" title="起迄地點" align="center" style="width:120px; color:black;">起迄地點</td>';
                    string += '<td id="tranorde_port2" title="領櫃地" align="center" style="width:120px; color:black;">領櫃地</td>';
                    string += '<td id="tranorde_empdock2" title="交櫃地" align="center" style="width:120px; color:black;">交櫃地</td>';
                    string += '<td id="tranorde_mount" title="收數量" align="center" style="width:80px; color:black;">收數量</td>';
                    string += '<td id="tranorde_vccecount" title="已派數量" align="center" style="width:80px; color:black;">已派數量</td>';
                    string += '<td id="tranorde_memo" title="備註" align="center" style="width:120px; color:black;">備註</td>';
                    
                    string += '</tr>';

                    var t_color = ['DarkBlue', 'DarkRed'];
                    for (var i = 0; i < this.tbCount; i++) {
                        string += '<tr id="tranorde_tr' + i + '">';
                        string += '<td style="text-align: center;">';
                        string += '<input id="tranorde_chk' + i + '" class="tranorde_chk" type="checkbox"/></td>';
                        string += '<td style="text-align: center; font-weight: bolder; color:black;">' + (i + 1) + '</td>';
                        string += '<td id="tranorde_nick' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_noa' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_stype' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_strdate' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_dldate' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_product' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_caseno' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_casetype' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_casetypeB' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_straddr' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_port2' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_empdock2' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '<td id="tranorde_mount' + i + '" style="text-align: right;color:' + t_color[i % t_color.length] + '"></td>';
						string += '<td id="tranorde_vccecount' + i + '" style="text-align: right;color:' + t_color[i % t_color.length] + '"></td>';
						string += '<td id="tranorde_memo' + i + '" style="text-align: center;color:' + t_color[i % t_color.length] + '"></td>';
                        string += '</tr>';
                    }
                    string += '</table>';
                    $('#tranorde').append(string);
                    for (var i = 0; i < this.tbCount; i++) {
                    	$('#tranorde_noa'+i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var t_noa = $(this).text();
							if(t_noa.length>0)
                    			q_box("tranorde_at.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";noa='"+t_noa+"';" + r_accy + "_" + r_cno, 'tranorde', "95%", "95%", '');
						});
                    }
				
                    string = '<input id="btnTranorde_refresh"  type="button" style="float:left;width:100px;" value="訂單刷新"/>';
                    string += '<input id="btnTranorde_previous" onclick="tranorde.previous()" type="button" style="float:left;width:100px;" value="上一頁"/>';
                    string += '<input id="btnTranorde_next" onclick="tranorde.next()" type="button" style="float:left;width:100px;" value="下一頁"/>';
                    string += '<input id="textCurPage" onchange="tranorde.page(parseInt($(this).val()))" type="text" style="float:left;width:100px;text-align: right;"/>';
                    string += '<span style="float:left;display:block;width:10px;font-size: 25px;">/</span>';
                    string += '<input id="textTotPage"  type="text" readonly="readonly" style="float:left;width:100px;color:green;"/>';
                    string += '<select id="combStype" style="float:left;width:100px;"> </select>';
                    string += '<a style="float:left;">客戶</a>';
                   	string += '<input id="textCustno" type="text" style="float:left;width:100px;">';
                   	string += '<a style="float:left;">訂單編號</a>';
                   	string += '<input id="textOrdeno" type="text" style="float:left;width:150px;">';
                    $('#tranorde_control').html(string);
                },
                init : function(obj) {
                    $('.tranorde_chk').click(function(e) {
                        $(".tranorde_chk").not(this).prop('checked', false);
                        $(".tranorde_chk").not(this).parent().parent().find('td').css('background', 'pink');
                        $(this).prop('checked', true);
                        $(this).parent().parent().find('td').css('background', '#FF8800');
                    });
                    this.data = new Array();
                    if (obj[0] != undefined) {
                    	for(var i=0;i<obj.length;i++){
                        	try{
                    			obj[i]['caseno'] = JSON.parse(obj[i]['caseno']);
                    			obj[i]['straddrno'] = JSON.parse(obj[i]['straddrno']);
                    			obj[i]['straddr'] = JSON.parse(obj[i]['straddr']);
                        	}catch(e){
                        		alert(obj[i]['noa']+'\n'+obj[i]['caseno']+'\n'+obj[i]['straddrno']+'\n'+obj[i]['straddr']);
                        	}
                            this.data.push(obj[i]);
                        }
                    }
                    this.totPage = Math.ceil(this.data.length / this.tbCount);
                    $('#textTotPage').val(this.totPage);
                    this.sort('noa', false);
                    Unlock();
                },
                sort : function(index, isFloat) {
                    //訂單排序
                    this.curIndex = index;

                    if (isFloat) {
                        this.data.sort(function(a, b) {
                            var m = parseFloat(a[tranorde.curIndex] == undefined ? "0" : a[tranorde.curIndex]);
                            var n = parseFloat(b[tranorde.curIndex] == undefined ? "0" : b[tranorde.curIndex]);
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
                                    return -1;
                                return 0;
                            } else
                                return n-m;
                        });
                    } else {
                        this.data.sort(function(a, b) {
                            var m = a[tranorde.curIndex] == undefined ? "" : a[tranorde.curIndex];
                            var n = b[tranorde.curIndex] == undefined ? "" : b[tranorde.curIndex];
                            if (m == n) {
                                if (a['noa'] < b['noa'])
                                    return 1;
                                if (a['noa'] > b['noa'])
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
                        	t_straddr = '';
                            title_straddr = '';
                            t_n = 0;
                            for (var j = 0; j < this.data[n + i].straddr.length; j++) {
                            	if(this.data[n+i].straddr[j].straddr.length>0){
                            		t_n++;
                            		if(t_n>3){
                            			
                            		}else if(t_n==3){
                            			t_straddr += '&nbsp;.....';
                            		}else{
                            			t_straddr += (t_straddr.length > 0 ? '<br>' : '') + this.data[n+i].straddr[j].straddr;
                            		}
                            		title_straddr += (title_straddr.length > 0 ? '\r\n' : '') + this.data[n+i].straddr[j].straddr;             		
                            	}
                            }
                            
                            t_caseno = '';
                            title_caseno = '';
                            t_n = 0;
                            for (var j = 0; j < this.data[n + i].caseno.length; j++) {
                            	if(this.data[n+i].caseno[j].caseno.length>0){
                            		t_n++;
                            		if(t_n>3){
                            			
                            		}else if(t_n==3){
                            			t_caseno += '&nbsp;.....';
                            		}else{
                            			t_caseno += (t_caseno.length > 0 ? '<br>' : '') + this.data[n+i].caseno[j].caseno;
                            		}
                            		title_caseno += (title_caseno.length > 0 ? '\r\n' : '') + this.data[n+i].caseno[j].caseno;             		
                            	}
                            }
                            
                            $('#tranorde_chk' + i).removeAttr('disabled');
                            $('#tranorde_nick' + i).html(this.data[n+i]['nick']);
                            $('#tranorde_noa' + i).html(this.data[n+i]['noa']);
                            $('#tranorde_stype' + i).html(this.data[n+i]['stype']);
                            $('#tranorde_strdate' + i).html(this.data[n+i]['strdate']);
                            $('#tranorde_dldate' + i).html(this.data[n+i]['dldate']);
                            $('#tranorde_product' + i).html(this.data[n+i]['product']);
                            $('#tranorde_caseno' + i).html(t_caseno).attr('title',title_caseno);
                            $('#tranorde_casetype' + i).html(this.data[n+i]['casetype']);
                            $('#tranorde_casetypeB' + i).html(this.data[n+i]['casetype2']);
                            $('#tranorde_straddr' + i).html(t_straddr).attr('title',title_straddr);
                            $('#tranorde_port2' + i).html(this.data[n+i]['port2']);
                            $('#tranorde_empdock2' + i).html(this.data[n+i]['empdock2']);
                            $('#tranorde_mount' + i).html(this.data[n+i]['mount']);
                            $('#tranorde_vccecount' + i).html(this.data[n+i]['vccecount']);
                            $('#tranorde_memo' + i).html(this.data[n+i]['memo']);
                        } else {
                            $('#tranorde_chk' + i).attr('disabled', 'disabled');
                            $('#tranorde_nick' + i).html('');
                            $('#tranorde_noa' + i).html('');
							$('#tranorde_stype' + i).html('');
							$('#tranorde_strdate' + i).html('');
							$('#tranorde_dldate' + i).html('');
							$('#tranorde_product' + i).html('');
							$('#tranorde_caseno' + i).html('');
							$('#tranorde_casetype' + i).html('');
							$('#tranorde_casetypeB' + i).html('');
							$('#tranorde_straddr' + i).html('');
							$('#tranorde_port2' + i).html('');
							$('#tranorde_empdock2' + i).html('');
							$('#tranorde_mount' + i).html('');
							$('#tranorde_vccecount' + i).html('');
							$('#tranorde_memo' + i).html('');
                        }
                    }
                    $('#tranorde_chk0').click();
                    $('#tranorde_chk0').prop('checked', 'true');
                },
                paste : function() {
                    //複製資料
                    if (this.totPage <= 0)
                        return;
                    var n = (this.curPage - 1) * this.tbCount;
                    for (var i = 0; i < this.tbCount; i++) {
                        if ($('#tranorde_chk' + i).prop('checked')) {
                            $('#txtOrdeno').val(this.data[n+i]['noa']);
                            $('#txtCustno').val(this.data[n+i]['custno']);
                            $('#txtComp').val(this.data[n+i]['comp']);
                            $('#txtNick').val(this.data[n+i]['nick']);
                            $('#txtMemo').val(this.data[n+i]['memo']);
                        }
                    }
                },
                paste2 : function(ordeno, sel) {
                    //複製資料
                    if (ordeno.length == 0)
                        return;
                    var t_where = "where=^^ noa='" + ordeno + "'^^";
                    q_gt('view_tranorde_dc', t_where, 0, 0, 0, 'ddd_' + ordeno + '_' + sel, r_accy);
                }
            };
            tranorde = new tranorde();

            //---------------------------------------------------------------------
            $(document).ready(function() {
                tranorde.load();
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1, 0, '', r_accy);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }

            function mainPost() {
                $('#btnIns').attr('value', $('#btnIns').attr('value') + "(F8)");
                $('#btnOk').attr('value', $('#btnOk').attr('value') + "(F9)");
                q_mask(bbmMask);
                q_cmbParse("combStype", ' @全部,' + q_getMsg('stype').replace(/\^/g, ','));
                q_cmbParse("cmbSaction",' ,領,送,收,交,移','s');
              	
              	$('#textCustno').bind('contextmenu', function(e) {
					/*滑鼠右鍵*/
					e.preventDefault();
					$('#buttonCust').click();
				});
                //--------------------------------------------------
                $('#divImport').mousedown(function(e) {
                    if (e.button == 2) {
                        $(this).data('xtop', parseInt($(this).css('top')) - e.clientY);
                        $(this).data('xleft', parseInt($(this).css('left')) - e.clientX);
                    }
                }).mousemove(function(e) {
                    if (e.button == 2 && e.target.nodeName != 'INPUT') {
                        $(this).css('top', $(this).data('xtop') + e.clientY);
                        $(this).css('left', $(this).data('xleft') + e.clientX);
                    }
                }).bind('contextmenu', function(e) {
                    if (e.target.nodeName != 'INPUT')
                        e.preventDefault();
                });
                $('#btn1').click(function(e) {
                    $('#divImport').toggle();
                    $('#textDate').focus();
                });
                $('#btnDivimport').click(function(e) {
                    $('#divImport').hide();
                });
               
                //--------------------------------------------------
                $('#btnTranorde_refresh').click(function(e) {
                    t_custno = $('#textCustno').val();
                    t_stype = $('#combStype').val();
					t_ordeno = $('#textOrdeno').val();
                    q_func('qtxt.query.transvcce', 'transvcce.txt,orde_vcce,true;' + encodeURI(t_custno) + ';' + encodeURI(t_stype)+ ';' + encodeURI(t_ordeno));
                });
                //自動載入訂單
                $('#btnTranorde_refresh').click();
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

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    case 'qtxt.query.transvcce':
                        var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            tranorde.init(as);
                        } else {
                            alert('無訂單資料!');
                        }
                        Unlock(1);
                        break;
                    case 'qtxt.query.transvcce_btnIns':
                    	var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            $('#txtCustno').val(as[0].custno);
                            $('#txtComp').val(as[0].comp);
                            $('#txtNick').val(as[0].nick);
                            
                            var t_addrno = JSON.parse(as[0].straddrno);
                            var t_addr = JSON.parse(as[0].straddr);                     
                            var t_caseno = JSON.parse(as[0].caseno);
                            
                            tranorde.curCaddr = new Array();
                            for(var i=0;i<t_addrno.length;i++){
                            	tranorde.curCaddr.push({addrno:t_addrno[i].straddrno,addr:t_addr[i].straddr});
                            }
                            while(q_bbsCount<t_caseno.length){
                            	$('#btnPlus').click();
                            }
                            for(var i=0;i<t_caseno.length;i++){
                            	$('#txtCaseno_'+i).val(t_caseno[i].caseno);
                            }
                            
                        } else {
                            alert('訂單遺失!');
                        }
                        Unlock(1);
                    	break;
                	case 'qtxt.query.transvcce_btnModi':
                    	var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            $('#txtCustno').val(as[0].custno);
                            $('#txtComp').val(as[0].comp);
                            $('#txtNick').val(as[0].nick);
                            
                            var t_addrno = JSON.parse(as[0].straddrno);
                            var t_addr = JSON.parse(as[0].straddr);                     
                            var t_caseno = JSON.parse(as[0].caseno);
                            
                            tranorde.curCaddr = new Array();
                            for(var i=0;i<t_addrno.length;i++){
                            	tranorde.curCaddr.push({addrno:t_addrno[i].straddrno,addr:t_addr[i].straddr});
                            }
                        } else {
                            alert('訂單遺失!');
                        }
                        Unlock(1);
                    	break;
                	case 'qtxt.query.transvcce_stPost':
                    	var as = _q_appendData("tmp0", "", true, true);
                        if (as[0] != undefined) {
                            for(var i=0;i<tranorde.data.length;i++){
                            	if(tranorde.data[i].noa == as[0].noa){
                            		tranorde.data[i].vccecount = as[0].vccecount;
                            		break;
                            	}
                            }
                            tranorde.refresh();
                        } else {
                        }
                    	break;
                    default:
                        break;
                }
            }

            function q_popPost(id) {
                switch (id) {
                    case 'txtCarno_':
                        tranorde.paste2($('#txtOrdeno').val(), b_seq);
                        break;
                    case 'txtDriverno_':
                        tranorde.paste2($('#txtOrdeno').val(), b_seq);
                        break;
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
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                var t_ordeno = $.trim($('#txtOrdeno').val());
                if (t_ordeno.length > 0) {
                	Lock(1, {opacity : 0});
                    q_func('qtxt.query.transvcce_stPost', 'transvcce.txt,orde_vcce,false;;;' + encodeURI(t_ordeno));
                }
                Unlock(1);
            }

            function btnOk() {
                if ($('#txtDatea').val().length == 0 || !q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                if (!q_cd($('#txtTrandate').val())) {
                    alert(q_getMsg('lblTrandate') + '錯誤。');
                    return;
                }
                if ($('#txtTrantime').val().length != 0 && !(/^(?:[0-1][0-9]|2[0-3])\:([0-5][0-9])$/g).test($('#txtTrantime').val())) {
                    alert(q_getMsg('lblTrantime') + '錯誤。');
                    return;
                }
                $('#txtOrdeno').val($.trim($('#txtOrdeno').val()));
                if ($('#txtDatea').val().length == 0) {
                    alert('無' + q_getMsg('lblOrdeno') + '。');
                    return;
                }
                if (q_cur == 1) {
                    $('#txtWorker').val(r_name);
                } else if (q_cur == 2) {
                    $('#txtWorker2').val(r_name);
                }
                sum();
                var t_noa = trim($('#txtNoa').val());
                var t_date = trim($('#txtDatea').val());
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_transvcce') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('transvcce_at_s.aspx', q_name + '_s', "550px", "600px", q_getMsg("popSeek"));
            }

            function btnIns() {
                tranorde.lock();
                _btnIns();
                tranorde.paste();

                $('#txtNoa').val('AUTO');
                $('#txtDatea').focus();

                var t_ordeno = $.trim($('#txtOrdeno').val());
                if (t_ordeno.length > 0) {
                	Lock(1, {opacity : 0});
                    q_func('qtxt.query.transvcce_btnIns', 'transvcce.txt,orde_vcce,false;;;' + encodeURI(t_ordeno));
                }
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                tranorde.lock();
                $('#txtDatea').focus();
                var t_ordeno = $.trim($('#txtOrdeno').val());
                if (t_ordeno.length > 0) {
                	Lock(1, {opacity : 0});
                    q_func('qtxt.query.transvcce_btnModi', 'transvcce.txt,orde_vcce,false;;;' + encodeURI(t_ordeno));
                }
            }

            function btnPrint() {
                q_box('z_transvccep_at.aspx?'+ r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'transvcce', "95%", "95%", m_print);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsAssign() {
                var t_str = '';
                for (var i = 0; tranorde.curCaddr != undefined && i < tranorde.curCaddr.length; i++)
                    t_str += '<option value="' + i + '">' + (tranorde.curCaddr[i].addrno + ' ' + tranorde.curCaddr[i].addr).replace('</', '') + '</option>';
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#combCaddr_' + i).html(t_str).change(function(e) {
                        var n = parseInt($(this).attr('id').replace('combCaddr_', ''));
                        $('#txtAddrno_' + n).val(tranorde.curCaddr[parseInt($(this).val())].addrno);
                        $('#txtAddr_' + n).val(tranorde.curCaddr[parseInt($(this).val())].addr);
                    });
                    $('#lblNo_' + i).text(i + 1);
                    $('#chkSendcommandresult_' + i).attr('disabled', 'disabled');
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                        $('#txtMount_' + i).change(function() {
                            sum();
                        });
                        $('#txtCarno_' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtCarno_', '');
							$('#btnCarno_'+n).click();
						});
						$('#txtDriverno_' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtDriverno_', '');
							$('#btnDriver_'+n).click();
						});
						$('#txtAddrno_' + i).bind('contextmenu', function(e) {
							/*滑鼠右鍵*/
							e.preventDefault();
							var n = $(this).attr('id').replace('txtAddrno_', '');
							$('#btnAddr_'+n).click();
						});
                    }
                }
                _bbsAssign();
            }

            function bbsSave(as) {
                if (!as['carno']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function sum() {
                if (!(q_cur == 1 || q_cur == 2))
                    return;
                var t_mount = 0;
                for (var i = 0; i < q_bbsCount; i++) {
                    t_mount = q_add(t_mount,q_float('txtMount_' + i));
                }
                $('#txtMount').val(t_mount);
            }

            function refresh(recno) {
                _refresh(recno);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if (t_para) {
                    $('#txtDatea').datepicker('destroy');
                    $('#txtTrandate').datepicker('destroy');
                } else {	
                    $('#txtDatea').datepicker();
                    $('#txtTrandate').datepicker();
                }
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#chkSendcommandresult_' + i).attr('disabled', 'disabled');
                    if (q_cur == 1 || q_cur == 2)
                        $('#combCaddr_' + i).removeAttr('disabled');
                    else
                        $('#combCaddr_' + i).attr('disabled', 'disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
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
                tranorde.unlock();
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                /*float: left;*/
                width: 950px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: darkblue;
            }
            .dbbm {
                /*float: left;*/
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
                width: 10%;
            }
            .tbbm .tdZ {
                width: 1%;
            }
            td .schema {
                display: block;
                width: 95%;
                height: 0px;
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
                font-size: medium;
            }
            .dbbs {
                width: 1300px;
            }
            .tbbs a {
                font-size: medium;
            }

            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            #tranorde_table {
                border: 5px solid gray;
                font-size: medium;
                background-color: white;
            }
            #tranorde_table tr {
                height: 30px;
            }
            #tranorde_table td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: pink;
                color: blue;
            }
            #tranorde_header td:hover {
                background: yellow;
                cursor: pointer;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;width:1400px;">
			<!--#include file="../inc/toolbar.inc"-->
			<!--<input type="button" id="btn1" style="width:100px;float:left;" value="司機回傳">-->
		</div>
		<div id="tranorde" style="float:left;width:1500px;"></div>
		<div id="tranorde_control" style="width:1500px;"></div>
		<div style="overflow: auto;display:block;width:1400px;">
			<div id="divImport" style="display:none;position:absolute;top:100px;left:700px;width:400px;height:150px;background:RGB(237,237,237);">
				<table style="border:4px solid gray; width:100%; height: 100%;">
					<tr style="height:1px;background-color: #cad3ff;">
						<td style="width:25%;"></td>
						<td style="width:25%;"></td>
						<td style="width:25%;"></td>
						<td style="width:25%;"></td>
					</tr>
					<tr>
						<td colspan="2" style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;color: blue;"><a>發送訊息日期</a></td>
						<td colspan="2" style="padding: 2px;text-align: center;border-width: 0px;background-color: #cad3ff;">
						<input type="text" id="textDate" style="float:left;width:95%;"/>
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center" style="background-color: #cad3ff;">
						<input type="button" id="btnImport" value="匯入"/>
						</td>
						<td colspan="2" align="center" style=" background-color: #cad3ff;">
						<input type="button" id="btnDivimport" value="關閉"/>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<div style="overflow: auto;display:block;width:1400px;">
			<div id='dmain' >
				<div class="dview" id="dview">
					<table class="tview" id="tview">
						<tr>
							<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
							<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
							<td align="center" style="width:100px; color:black;"><a id='vewNick'> </a></td>
							<td align="center" style="width:80px; color:black;"><a id='vewMount'> </a></td>
							<td align="center" style="width:250px; color:black;"><a id='vewCarno'> </a></td>
							<td align="center" style="width:100px; color:black;"><a id='vewMemo2'> </a></td>
							<td align="center" style="width:200px; color:black;"><a id='vewMemo3'> </a></td>
						</tr>
						<tr>
							<td >
							<input id="chkBrow.*" type="checkbox" style=''/>
							</td>
							<td id='datea' style="text-align: center;">~datea</td>
							<td id='nick' style="text-align: center;">~nick</td>
							<td id='mount,1,1' style="text-align: right;">~mount,1,1</td>
							<td id='carno' style="text-align: left;">~carno</td>
							<td id='memo2' style="text-align: left;">~memo2</td>
							<td id='memo3' style="text-align: left;">~memo3</td>
						</tr>
					</table>
				</div>

				<div class='dbbm'>
					<table class="tbbm"  id="tbbm">
						<tr style="height: 1px;">
							<td>
							<input type="text" id="txtCarno" style="display:none;">
							</td>
							<td>
							<input type="text" id="txtMemo2" style="display:none;">
							</td>
							<td>
							<input type="text" id="txtMemo3" style="display:none;">
							</td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td class="tdZ"></td>
						</tr>
						<tr>
							<td><span> </span><a id="lblCust"t class="lbl"> </a></td>
							<td colspan="4">
							<input id="txtCustno"  type="text"  style="float:left; width:30%;"/>
							<input id="txtComp"  type="text"  style="float:left; width:70%;"/>
							<input id="txtNick"  type="text"  style="display:none;"/>
							</td>
						</tr>
						<tr>
							<td><span> </span><a id="lblOrdeno" class="lbl"> </a></td>
							<td>
							<input id="txtOrdeno"  type="text"  class="txt c1"/>
							</td>
							<td><span> </span><a id="lblDatea" title="實際派車日期" class="lbl"> </a></td>
							<td>
							<input id="txtDatea"  type="text" title="實際派車日期" class="txt c1"/>
							</td>
						</tr>
						<tr>
							<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
							<td colspan="6">
							<input id="txtMemo" type="text" class="txt c1"/>
							</td>
						</tr>
						<tr>
							<td><span> </span><a id="lblTrandate" title="發送訊息給司機用" class="lbl"> </a></td>
							<td>
							<input id="txtTrandate"  type="text" title="發送訊息給司機用" class="txt c1"/>
							</td>
							<td><span> </span><a id="lblTrantime" title="發送訊息給司機用" class="lbl"> </a></td>
							<td>
							<input id="txtTrantime" title="發送訊息給司機用" type="text"  class="txt c1"/>
							</td>
							<td><span> </span><a id="lblMount" title="總數量" class="lbl"> </a></td>
							<td>
							<input id="txtMount" title="總數量" type="text"  class="txt c1 num"/>
							</td>
						</tr>
						<tr>
							<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
							<td>
							<input id="txtWorker"  type="text"  class="txt c1"/>
							</td>
							<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
							<td>
							<input id="txtWorker2"  type="text"  class="txt c1"/>
							</td>
							<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
							<td>
							<input id="txtNoa"  type="text"  class="txt c1"/>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;">
					<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"></td>
					<td align="center" style="width:60px;"><a>作業</a></td>
					<td align="center" style="width:90px;"><a>車牌</a></td>
					<td align="center" style="width:150px;"><a>司機/電話</a></td>
					<td align="center" style="width:80px;"><a>數量</a></td>
					<td align="center" style="width:150px;"><a>櫃號</a></td>
					<td align="center" style="width:80px;"><a>板架</a></td>
					<td align="center" style="width:150px;"><a>起迄地點</a></td>
					<td align="center" style="width:150px;"><a>備註</a></td>
					<td align="center" style="width:150px;"><a>發送訊息/回傳訊息</a></td>
					<td align="center" style="width:40px;"><a>發送</a></td>
					<td align="center" style="width:40px;"><a>已送</a></td>
					<td align="center" style="width:100px;"><a></a></td>	
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
					<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
					<input id="txtNoq.*" type="text" style="float:left;visibility: hidden; width:1%" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><select id="cmbSaction.*" style="width:95%;"></select></td>
					<td><input id="txtCarno.*" type="text" style="width: 95%;"/></td>
					<td>
						<input id="txtDriverno.*"type="text" style="width: 45%;float:left;"/>
						<input id="txtDriver.*" type="text" style="width: 45%;float:left;"/>
						<input id="txtTel.*" type="text" style="width: 95%;"/>
					</td>
					<td><input id="txtMount.*" type="text" style="width: 95%;text-align: right;"/></td>
					<td><input id="txtCaseno.*" type="text" style="width: 95%;"/></td>
					<td><input id="txtCarpno.*" type="text" style="width: 95%;"/></td>
					<td>
						<input id="txtAddrno.*" type="text" style="width: 70%;"/>
						<select id="combCaddr.*" style="width: 15%;"></select>
						<input id="txtAddr.*" type="text" style="width: 95%;"/>
					</td>
					<td>
						<input id="txtMemo.*" type="text" style="display:none;"/>
						<input id="txtMemo2.*" type="text" style="width: 95%;"/>
					</td>
					<td>
						<input id="txtMsg.*" type="text" style="width: 95%;"/>
						<input id="txtTaskcontent.*" type="text" style="width: 95%;color:rgb(255,100,100);"/>
					</td>
					<td align="center" >
					<input id="chkIssend.*" title="若要發送訊息給司機，請打勾。" type="checkbox" />
					</td>
					<td align="center" >
					<input id="chkSendcommandresult.*" type="checkbox" />
					</td>
					<td>
					<input id="txtCommandid.*" type="text" style="width: 95%;"/>
					<input id="txtSendno.*" type="text" style="display:none;"/>
					<input id="txtSendid.*" type="text" style="width: 30%;float:left;"/>
					<input id="txtSenddate.*" type="text" style="width: 60%;float:left;"/>
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
