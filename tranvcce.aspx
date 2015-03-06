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
            var q_name = 'tranvcce';
            aPop = new Array(['txtCustno', 'lblCustno', 'cust', 'noa,comp', 'txtCustno', 'cust_b.aspx']);

            $(document).ready(function() {
                _q_boxClose();
                q_getId();
                q_gf('', 'tranvcce');

                $('#btnAuthority').click(function() {
                    btnAuthority(q_name);
                });
            });

            function q_gfPost() {
                $('#aa').grid({
                    width : [300, 700],
                    column1 : [{
                        field : "recno",
                        name : '序',
                        width : 50
                    }, {
                        field : "datea",
                        name : '日期',
                        width : 100,
                        type : 'date',
                        nextField : 'straddr'
                    }, {
                        field : "ordeno",
                        name : '訂單編號',
                        width : 150,
                        type : 'norm',
                        nextField : 'cust',
                        readonly : true
                    }],
                    column2 : [{
                        field : "cust",
                        name : '貨主',
                        width : 100,
                        type : 'norm',
                        nextField : 'straddr',
                        readonly : true
                    }, {
                        field : "straddr",
                        name : '起迄地點',
                        width : 150,
                        type : 'norm',
                        nextField : 'containerno1'
                    }, {
                        field : "containerno1",
                        name : '櫃號一',
                        width : 150,
                        type : 'norm',
                        nextField : 'containerno2'
                    }, {
                        field : "containerno2",
                        name : '櫃號二',
                        width : 150,
                        type : 'norm',
                        nextField : 'casetype'
                    }, {
                        field : "casetype",
                        name : '規格',
                        width : 50,
                        type : 'norm',
                        nextField : 'date1'
                    }, {
                        field : "date1",
                        name : '領櫃日期',
                        width : 100,
                        type : 'date',
                        nextField : 'carno1'
                    }, {
                        field : "carno1",
                        name : '領櫃車號',
                        width : 100,
                        type : 'norm',
                        nextField : 'driver1'
                    }, {
                        field : "driver1",
                        name : '司機１',
                        width : 100,
                        type : 'norm',
                        nextField : 'date2'
                    }, {
                        field : "date2",
                        name : '送櫃日期',
                        width : 100,
                        type : 'date',
                        nextField : 'carno2'
                    }, {
                        field : "carno2",
                        name : '送櫃車號',
                        width : 100,
                        type : 'norm',
                        nextField : 'driver2'
                    }, {
                        field : "driver2",
                        name : '司機２',
                        width : 100,
                        type : 'norm',
                        nextField : 'date3'
                    }, {
                        field : "date3",
                        name : '收櫃日期',
                        width : 100,
                        type : 'date',
                        nextField : 'carno3'
                    }, {
                        field : "carno3",
                        name : '收櫃車號',
                        width : 100,
                        type : 'norm',
                        nextField : 'driver3'
                    }, {
                        field : "driver3",
                        name : '司機３',
                        width : 100,
                        type : 'norm',
                        nextField : 'date4'
                    }, {
                        field : "date4",
                        name : '交櫃日期',
                        width : 100,
                        type : 'date',
                        nextField : 'carno4'
                    }, {
                        field : "carno4",
                        name : '交櫃車號',
                        width : 100,
                        type : 'norm',
                        nextField : 'driver4'
                    }, {
                        field : "driver4",
                        name : '司機４',
                        width : 100,
                        type : 'norm',
                        nextField : 'date5'
                    }, {
                        field : "date5",
                        name : '移櫃日期(1)',
                        width : 100,
                        type : 'date',
                        nextField : 'carno5'
                    }, {
                        field : "carno5",
                        name : '移櫃車號(1)',
                        width : 100,
                        type : 'norm',
                        nextField : 'driver5'
                    }, {
                        field : "driver5",
                        name : '司機５',
                        width : 100,
                        type : 'norm',
                        nextField : 'date6'
                    }, {
                        field : "date6",
                        name : '移櫃日期(2)',
                        width : 100,
                        type : 'date',
                        nextField : 'carno6'
                    }, {
                        field : "carno6",
                        name : '移櫃車號(2)',
                        width : 100,
                        type : 'norm',
                        nextField : 'driver6'
                    }, {
                        field : "driver6",
                        name : '司機６',
                        width : 100,
                        type : 'norm',
                        nextField : 'memo'
                    }, {
                        field : "memo",
                        name : '備註',
                        width : 150,
                        type : 'norm',
                        nextField : 'enda'
                    }, {
                        field : "enda",
                        name : '結案',
                        width : 50,
                        type : 'norm',
                        nextField : 'enda'
                    }],
                    record : new Array()
                });

                q_getFormat();
                q_langShow();
                q_popAssign();
                q_cur = 2;
                $('#txtBdate').mask('999/99/99');
                $('#txtBdate').datepicker();
                $('#txtEdate').mask('999/99/99');
                $('#txtEdate').datepicker();

                $('#aa').data('info').getData = function(obj) {
                    Lock(1);
                    var cust = $('#txtCustno').val();
                    var bdate = $('#txtBdate').val();
                    var edate = $('#txtEdate').val();
                    $.ajax({
                        obj : obj,
                        url : 'tranvcce_getdata.aspx',
                        headers : {
                            'database' : q_db
                        },
                        type : 'POST',
                        data : JSON.stringify({
                            cust : cust,
                            bdate : bdate,
                            edate : edate
                        }),
                        dataType : 'text',
                        timeout : 10000,
                        success : function(data) {
                            this.obj.data('info').value.record = JSON.parse(data);
                        },
                        complete : function() {
                            this.obj.data('info').setPage(obj, null);
                            Unlock(1);
                        },
                        error : function(jqXHR, exception) {
                            var errmsg = this.url + '資料讀取異常。\n';
                            if (jqXHR.status === 0) {
                                alert(errmsg + 'Not connect.\n Verify Network.');
                            } else if (jqXHR.status == 404) {
                                alert(errmsg + 'Requested page not found. [404]');
                            } else if (jqXHR.status == 500) {
                                alert(errmsg + 'Internal Server Error [500].');
                            } else if (exception === 'parsererror') {
                                alert(errmsg + 'Requested JSON parse failed.');
                            } else if (exception === 'timeout') {
                                alert(errmsg + 'Time out error.');
                            } else if (exception === 'abort') {
                                alert(errmsg + 'Ajax request aborted.');
                            } else {
                                alert(errmsg + 'Uncaught Error.\n' + jqXHR.responseText);
                            }
                        }
                    });
                };
                $('#aa').find('input[name="btnRefresh"]').click();
            }


            jQuery.fn.selectText = function() {
                var doc = document;
                var element = this[0];
                //console.log(this, element);
                if (doc.body.createTextRange) {
                    var range = document.body.createTextRange();
                    range.moveToElementText(element);
                    range.select();
                } else if (window.getSelection) {
                    var selection = window.getSelection();
                    var range = document.createRange();
                    range.selectNodeContents(element);
                    selection.removeAllRanges();
                    selection.addRange(range);
                }
            };
            function MouseWheel() {
                var _addEventListener, wheel_event_name = 'wheel', inverse_wheel_direction = false;
                var wheelHandler = function(evt) {
                    var delta = evt.deltaY || evt.wheelDelta || evt.detail;
                    //處理事件
                    if (!$('.grid').hasClass('edit'))
                        $('.grid').data('info').setPage($('.grid'), delta > 0 ? 1 : -1);
                };

                // detect event model
                if (window.addEventListener) {
                    _addEventListener = "addEventListener";
                } else {
                    _addEventListener = "attachEvent";
                }

                // detect available wheel event
                if (document.onmousewheel === null && window.addEventListener === undefined) {
                    // IE 8, note that it is test onmousewheel strictly equals to null
                    wheel_event_name = 'onmousewheel';
                } else if (Modernizr.hasEvent('wheel') || (!!window.WheelEvent && !!window.MouseWheelEvent)) {
                    // detect if browser has DOM L3 wheel event: Firefox 17 and IE 9 or later version
                    wheel_event_name = 'wheel';
                    inverse_wheel_direction = true;
                } else if (!!window.WheelEvent) {
                    // Safari, Chrome
                    wheel_event_name = 'mousewheel';
                } else {
                    // Firefox 16 and earlier version
                    wheel_event_name = 'DOMMouseScroll';
                    inverse_wheel_direction = true;
                }
                document[_addEventListener](wheel_event_name, wheelHandler);
            };
            MouseWheel();
            $.fn.grid = function(value) {
                $(this).data('info', {
                    headerheight : 50,
                    rowheight : 30,
                    row_count : 10, //每頁顯示筆數
                    value : value,
                    row_color : ['LavenderBlush', 'LightGray'], //grid row color
                    focus_color : 'pink', //grid row color  focus
                    init : function(obj) {
                        obj.addClass('grid').css('background-color', 'pink').css('overflow', 'visible');
                        obj.append('<div style="background-color:PowderBlue;"></div>');
                        obj.append('<div style="background-color:PowderBlue;"><table class="data"></table></div>');
                        obj.append('<div style="background-color:PowderBlue;"><table class="data"></table></div>');

                        obj.children('div').eq(1).css('float', 'left').css('overflow-x', 'hidden').css('overflow-y', 'hidden');
                        obj.children('div').eq(2).css('float', 'left').css('overflow-x', 'scroll').css('overflow-y', 'hidden');

                        obj.children('div').eq(1).children('table.data').css('background-color', 'DarkKhaki');
                        obj.children('div').eq(2).children('table.data').css('background-color', 'DarkKhaki');
                        //control
                        obj.children('div').eq(0).append('<span name="curPage" contenteditable=true style="text-align:center;float:left;display:block;height:25px;width:30px;font-size:16px;">0</span>');
                        obj.children('div').eq(0).append('<span style="float:left;display:block;height:25px;width:10px;font-size:16px;">/</span>');
                        obj.children('div').eq(0).append('<span name="totPage" style="text-align:center;float:left;display:block;height:25px;width:30px;font-size:16px;">0</span>');
                        obj.children('div').eq(0).find('span[name="curPage"]').keydown(function(e) {
                            if (e.which == 13) {
                                e.preventDefault();
                                obj.data('info').setPage(obj, 0);
                            }
                        });
                        obj.children('div').eq(0).append('<span style="float:left;display:block;height:25px;width:20px;font-size:16px;"></span>');
                        obj.children('div').eq(0).append('<span id="lblCustno" style="text-align:center;float:left;display:block;height:25px;width:80px;font-size:16px;">客戶編號：</span>');
                        obj.children('div').eq(0).append('<input type="text" id="txtCustno" style="float:left;width:100px;"/>');
                        obj.children('div').eq(0).append('<span style="text-align:center;float:left;display:block;height:25px;width:50px;font-size:16px;">日期：</span>');
                        obj.children('div').eq(0).append('<input type="text" id="txtBdate" style="float:left;width:100px;"/>');
                        obj.children('div').eq(0).append('<span style="text-align:center;float:left;display:block;height:25px;width:20px;font-size:16px;">~</span>');
                        obj.children('div').eq(0).append('<input type="text" id="txtEdate" style="float:left;width:100px;"/>');
                        obj.children('div').eq(0).append('<span style="float:left;display:block;height:25px;width:40px;font-size:16px;"></span>');
                        obj.children('div').eq(0).append('<input type="button" name="btnRefresh" style="float:left;width:100px;" value="刷新"/>');
                        obj.children('div').eq(0).find('input[name="btnRefresh"]').click(function(e) {
                            var obj = $(this).parent().parent();
                            obj.data('info').getData(obj);
                        });
                        obj.data('info').setPage(obj, 1);
                    },
                    getData : function(obj) {
                    },
                    setPage : function(obj, n) {
                        var totPage = obj.data('info').value.record.length == 0 ? 0 : Math.ceil(obj.data('info').value.record.length / obj.data('info').row_count);
                        var curPage = parseInt(obj.find('span[name="curPage"]').text());
                        if (n == null) {
                            curPage = 1;
                            n = 0;
                        }
                        if (totPage == 0) {
                            curPage = 0;
                        } else {
                            curPage += n;
                            if (curPage <= 0) {
                                curPage = totPage;
                            } else if (curPage > totPage) {
                                curPage = totPage == 0 ? 0 : 1;
                            }
                        }
                        //console.log(curPage+'__'+totPage);
                        obj.find('span[name="totPage"]').text(totPage);
                        obj.find('span[name="curPage"]').text(curPage);
                        obj.data('info').refresh(obj);
                    },
                    getCurData : function(obj) {
                        //將value.record要顯示的資料寫到value.row
                        //當前頁數
                        var curPage = parseInt(obj.find('span[name="curPage"]').text());
                        var begin = (curPage - 1) * obj.data('info').row_count;
                        var end = curPage * obj.data('info').row_count - 1;
                        if (begin < 0 || end < 0)
                            obj.data('info').value.row = new Array();
                        else {
                            end = end >= obj.data('info').value.record.length ? obj.data('info').value.record.length - 1 : end;
                            //console.log(begin+'__'+end);
                            obj.data('info').value.row = obj.data('info').value.record.slice(begin, end + 1);
                        }
                    },
                    refresh : function(obj) {
                        obj.data('info').getCurData(obj);

                        var control_height = 50;
                        var t_height = obj.data('info').headerheight + obj.data('info').value.row.length * obj.data('info').rowheight + 2 * obj.data('info').rowheight;
                        var t_width = obj.data('info').value.width[0] + obj.data('info').value.width[1];

                        var top_table_height = obj.data('info').headerheight;
                        var bottom_table_height = obj.data('info').value.row.length * obj.data('info').rowheight;
                        var t_width1 = obj.data('info').value.width[0];
                        var t_width2 = obj.data('info').value.width[1];

                        obj.css('height', t_height + control_height).css('width', t_width);
                        obj.children('div').eq(0).css('height', control_height).css('width', t_width);
                        obj.children('div').eq(1).css('height', t_height).css('width', t_width1);
                        obj.children('div').eq(2).css('height', t_height).css('width', t_width2);

                        left_table_width = 0;
                        for (var i = 0; i < obj.data('info').value.column1.length; i++) {
                            left_table_width += obj.data('info').value.column1[i].width;
                        }
                        right_table_width = 0;
                        for (var i = 0; i < obj.data('info').value.column2.length; i++) {
                            right_table_width += obj.data('info').value.column2[i].width;
                        }
                        //reset
                        obj.children('div').eq(1).children('table.data').html('').height(bottom_table_height).width(left_table_width);
                        obj.children('div').eq(2).children('table.data').html('').height(bottom_table_height).width(right_table_width);

                        //left
                        obj.children('div').eq(1).children('table.data').append("<tr></tr>");
                        for (var i = 0; i < obj.data('info').value.column1.length; i++) {
                            obj.children('div').eq(1).children('table.data').find('tr').eq(0).append('<th align="center" style="width:' + obj.data('info').value.column1[i].width + 'px;background-color:LightGoldenRodYellow;"><a style="white-space:nowrap;">' + obj.data('info').value.column1[i].name + '</a></th>')
                        }
                        for (var i = 0; i < obj.data('info').value.row.length; i++) {
                            obj.children('div').eq(1).children('table.data').append('<tr></tr>');
                            objtr = obj.children('div').eq(1).children('table.data').find('tr').eq(i + 1);
                            objtr.attr('name', i);
                            //記錄資料行數
                            objtr.height(obj.data('info').rowheight).css('margin', '0px').css('padding', '0px');
                            for (var j = 0; j < obj.data('info').value.column1.length; j++) {
                                //recno  固定為button
                                if (obj.data('info').value.column1[j].field == 'recno') {
                                    objtr.append('<td align="center"><input type="button" style="width:95%"/></td>');
                                    objtd = objtr.find('td').eq(j);
                                    objtd.attr('name', obj.data('info').value.column1[j].field);
                                    objtd.width(obj.data('info').value.column1[j].width).css('background-color', obj.data('info').row_color[i % obj.data('info').row_color.length]);
                                    objtd.find('a').css('background-color', obj.data('info').row_color[i % obj.data('info').row_color.length]);
                                    objtd.find('input').eq(0).attr('value', obj.data('info').value.row[i][obj.data('info').value.column1[j].field]);
                                    //修改  按鈕事件
                                    objtd.find('input').data('parent', obj).click(function(e) {
                                        var obj = $(this).data('parent');
                                        var n = parseInt($(this).parent().parent().attr('name'));
                                        if ($(this).hasClass('edit')) {
                                            //修改確定
                                            obj.removeClass('edit');
                                            $(this).removeClass('edit');
                                            obj.find('input[type="button"]').removeAttr('disabled', 'disabled');

                                            obj.children('div').eq(1).children('table.data').find('tr').eq(n + 1).find('td').css('background-color', obj.data('info').row_color[n % obj.data('info').row_color.length]);
                                            obj.children('div').eq(2).children('table.data').find('tr').eq(n + 1).find('td').css('background-color', obj.data('info').row_color[n % obj.data('info').row_color.length]);
                                            obj.children('div').eq(1).children('table.data').find('tr').eq(n + 1).find('td').find('a').css('background-color', obj.data('info').row_color[n % obj.data('info').row_color.length]);
                                            obj.children('div').eq(2).children('table.data').find('tr').eq(n + 1).find('td').find('a').css('background-color', obj.data('info').row_color[n % obj.data('info').row_color.length]);

                                            obj.find('td').find('a').removeAttr("contenteditable", "true");

                                            // control 解除鎖定
                                            obj.children('div').eq(0).find('[name="curPage"]').attr("contenteditable", "true");
                                            obj.children('div').eq(0).find('[name="btnRefresh"]').removeAttr('disabled');
                                            //回寫資料庫
                                            obj.data('info').save(obj, n);
                                        } else {
                                            //修改
                                            obj.addClass('edit');
                                            $(this).addClass('edit');
                                            obj.find('input[type="button"]').attr('disabled', 'disabled');
                                            $(this).removeAttr('disabled', 'disabled');

                                            obj.children('div').eq(1).children('table.data').find('tr').eq(n + 1).find('td').css('background-color', obj.data('info').focus_color);
                                            obj.children('div').eq(2).children('table.data').find('tr').eq(n + 1).find('td').css('background-color', obj.data('info').focus_color);
                                            obj.children('div').eq(1).children('table.data').find('tr').eq(n + 1).find('td').find('a').css('background-color', obj.data('info').focus_color);
                                            obj.children('div').eq(2).children('table.data').find('tr').eq(n + 1).find('td').find('a').css('background-color', obj.data('info').focus_color);
                                            // control 鎖定
                                            obj.children('div').eq(0).find('[name="curPage"]').attr("contenteditable", "false");
                                            obj.children('div').eq(0).find('[name="btnRefresh"]').attr('disabled', 'disabled');
                                            //欄位變成修改狀態
                                            //left
                                            objtr = obj.children('div').eq(1).children('table.data').find('tr').eq(n + 1);
                                            for (var i = 0; i < obj.data('info').value.column1.length; i++) {
                                                //recno 可以算是保留欄位,  忽略
                                                if (obj.data('info').value.column1[i].field == 'recno') {
                                                    continue;
                                                }
                                                if (obj.data('info').value.column1[i].readonly) {
                                                    continue;
                                                }
                                                objtr.find('td').eq(i).find('a').eq(0).attr("contenteditable", "true");
                                            }
                                            //right
                                            objtr = obj.children('div').eq(2).children('table.data').find('tr').eq(n + 1);
                                            for (var i = 0; i < obj.data('info').value.column2.length; i++) {
                                                if (obj.data('info').value.column2[i].readonly) {
                                                    continue;
                                                }
                                                objtr.find('td').eq(i).find('a').eq(0).attr("contenteditable", "true");
                                            }
                                        }
                                    });
                                } else {
                                    objtr.append('<td><a style="white-space:nowrap;"></a></td>');
                                    objtd = objtr.find('td').eq(j);
                                    obja = objtd.find('a').eq(0);
                                    obja.attr('name', obj.data('info').value.column1[j].field + i);
                                    objtd.width(obj.data('info').value.column1[j].width).css('background-color', obj.data('info').row_color[i % obj.data('info').row_color.length]);
                                    obja.css('background-color', obj.data('info').row_color[i % obj.data('info').row_color.length]);
                                    obja.text(obj.data('info').value.row[i][obj.data('info').value.column1[j].field]);
                                    if(obj.data('info').value.column1[j].readonly)
                                    	objtd.css('color','green');
                                }
                            }
                        }
                        //right
                        obj.children('div').eq(2).children('table.data').append("<tr></tr>");
                        for (var i = 0; i < obj.data('info').value.column2.length; i++) {
                            obj.children('div').eq(2).children('table.data').find('tr').eq(0).append('<th align="center" style="width:' + obj.data('info').value.column2[i].width + 'px;background-color:LightGoldenRodYellow;"><a style="white-space:nowrap;">' + obj.data('info').value.column2[i].name + '</a></th>')
                        }
                        //right
                        for (var i = 0; i < obj.data('info').value.row.length; i++) {
                            obj.children('div').eq(2).children('table.data').append('<tr></tr>');
                            objtr = obj.children('div').eq(2).children('table.data').find('tr').eq(i + 1);
                            objtr.height(obj.data('info').rowheight).css('margin', '0px').css('padding', '0px');
                            for (var j = 0; j < obj.data('info').value.column2.length; j++) {
                                objtr.append('<td><a style="white-space:nowrap;"></a></td>');
                                objtd = objtr.find('td').eq(j);
                                obja = objtd.find('a').eq(0);
                                obja.attr('name', obj.data('info').value.column2[j].field + i);
                                objtd.width(obj.data('info').value.column2[j].width).css('background-color', obj.data('info').row_color[i % obj.data('info').row_color.length]);
                                obja.css('background-color', obj.data('info').row_color[i % obj.data('info').row_color.length]);
                                obja.text(obj.data('info').value.row[i][obj.data('info').value.column2[j].field]);
                            	if(obj.data('info').value.column2[j].readonly)
                                    	objtd.css('color','green');
                            }
                        }
                        //field event
                        for (var i = 0; i < obj.data('info').value.row.length; i++) {
                            objtr_left = obj.children('div').eq(1).children('table.data').find('tr').eq(i + 1);
                            objtr_right = obj.children('div').eq(2).children('table.data').find('tr').eq(i + 1);
                            for (var j = 0; j < obj.data('info').value.column1.length; j++) {
                                if (obj.data('info').value.column1[j].field == 'recno') {
                                    continue;
                                }
                                objtd = objtr_left.find('td').eq(j).find('a').eq(0);
                                if (objtd.length == 0)
                                    continue;
                                nextObjtd = null;
                                for (var k = 0; k < obj.data('info').value.column1.length; k++) {
                                    if (obj.data('info').value.column1[j].nextField == obj.data('info').value.column1[k].field) {
                                        nextObjtd = objtr_left.find('td').eq(k).find('a').eq(0);
                                        break;
                                    }
                                }
                                if (nextObjtd == null) {
                                    for (var k = 0; k < obj.data('info').value.column2.length; k++) {
                                        if (obj.data('info').value.column1[j].nextField == obj.data('info').value.column2[k].field) {
                                            nextObjtd = objtr_right.find('td').eq(k).find('a').eq(0);
                                            break;
                                        }
                                    }
                                }

                                var type = obj.data('info').value.column1[j].type == null ? '' : obj.data('info').value.column1[j].type;
                                switch(obj.data('info').value.column1[j].type) {
                                    case 'date':
                                        //console.log(i+'__'+j+'__'+objtd.attr('name'));
                                        obj.data('info').event_date(objtd, nextObjtd);
                                        break;
                                    default:
                                        //console.log(i+'__'+j+'__'+nextObjtd.attr('name')+'__'+objtd.attr('name'));
                                        obj.data('info').event_norm(objtd, nextObjtd);
                                        break;
                                }

                            }
                            for (var j = 0; j < obj.data('info').value.column2.length; j++) {
                                if (obj.data('info').value.column2[j].field == 'recno') {
                                    continue;
                                }
                                objtd = objtr_right.find('td').eq(j).find('a').eq(0);
                                if (objtd.length == 0)
                                    continue;
                                nextObjtd = null;
                                for (var k = 0; k < obj.data('info').value.column1.length; k++) {
                                    if (obj.data('info').value.column2[j].nextField == obj.data('info').value.column1[k].field) {
                                        nextObjtd = objtr_left.find('td').eq(k).find('a').eq(0);
                                        break;
                                    }
                                }
                                if (nextObjtd == null) {
                                    for (var k = 0; k < obj.data('info').value.column2.length; k++) {
                                        if (obj.data('info').value.column2[j].nextField == obj.data('info').value.column2[k].field) {
                                            nextObjtd = objtr_right.find('td').eq(k).find('a').eq(0);
                                            break;
                                        }
                                    }
                                }

                                var type = obj.data('info').value.column2[j].type == null ? '' : obj.data('info').value.column2[j].type;
                                switch(obj.data('info').value.column2[j].type) {
                                    case 'date':
                                        //console.log(i+'__'+j+'__'+objtd.attr('name'));
                                        obj.data('info').event_date(objtd, nextObjtd);
                                        break;
                                    default:
                                        //console.log(i+'__'+j);
                                        //console.log(i+'__'+j+'__'+nextObjtd.attr('name')+'__'+objtd.attr('name'));
                                        obj.data('info').event_norm(objtd, nextObjtd);
                                        break;
                                }
                            }
                        }
                    },
                    save : function(obj, n) {
                        console.log('save:' + n);

                        //先將畫面上資料寫到陣列中
                        var targetN = -1;
                        for (var i = 0; i < obj.data('info').value.record.length; i++) {
                            if (obj.data('info').value.record[i].recno == obj.data('info').value.row[n].recno) {
                                targetN = i;
                                break;
                            }
                        }
                        //left
                        qdjTd = obj.children('div').eq(1).find('tr').eq(n + 1).find('td');
                        for (var i = 0; i < obj.data('info').value.column1.length; i++) {
                            if (obj.data('info').value.column1[i].field == 'recno' || obj.data('info').value.column1[i].readonly)
                                continue;
                            //console.log(targetN+'_'+i);
                            obj.data('info').value.record[targetN][obj.data('info').value.column1[i].field] = qdjTd.eq(i).find('a').eq(0).text();
                            obj.data('info').value.row[n][obj.data('info').value.column1[i].field] = qdjTd.eq(i).find('a').eq(0).text();
                        }
                        //right
                        qdjTd = obj.children('div').eq(2).find('tr').eq(n + 1).find('td');
                        for (var i = 0; i < obj.data('info').value.column2.length; i++) {
                            if (obj.data('info').value.column2[i].field == 'recno' || obj.data('info').value.column2[i].readonly)
                                continue;
                            //console.log(targetN+'_'+i+'_'+qdjTd.eq(i).find('a').eq(0).text());
                            obj.data('info').value.record[targetN][obj.data('info').value.column2[i].field] = qdjTd.eq(i).find('a').eq(0).text();
                            obj.data('info').value.row[n][obj.data('info').value.column2[i].field] = qdjTd.eq(i).find('a').eq(0).text();
                        }
                        //將陣列資料存到資料庫
                        Lock(1,{opacity:0});
						$.ajax({
		                    url: 'tranvcce_update.aspx',
		                    headers: { 'database': q_db },
		                    type: 'POST',
		                    data: JSON.stringify(obj.data('info').value.row[n]),
		                    dataType: 'text',
		                    timeout: 10000,
		                    success: function(data){
		                        if(data.length>0){
		                        	alert(data)
		                        }
		                    },
		                    complete: function(){ 
		                    	Unlock(1);                
		                    },
		                    error: function(jqXHR, exception) {
		                        var errmsg = this.url+'資料寫入異常 SEQ:'+this.seq+'。\n';
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
                        //必要時刷新畫面資料
                    },
                    event_norm : function(obj, nextObj) {
                        obj.data('nextObj', nextObj);
                        obj.keydown(function(e) {
                            if (e.which == 13) {
                                e.preventDefault();
                                //跳下一格
                                var y = window.scrollY;
                                if (nextObj != null) {
                                    $(this).data('nextObj').focus();
                                    window.scrollTo($(this).data('nextObj').offset().left - 200, y);
                                }
                            }
                            $(this).data('pervData', this.text);
                        }).keyup(function(e) {
                            var prevVal = $(this).data('pervData');
                            var curVal = $(this).text();
                        });
                    },
                    event_date : function(obj, nextObj) {
                        //欄位事件
                        //日期格式
                        obj.data('nextObj', nextObj);
                        obj.focus(function() {
                            $(this).text($(this).text());
                        }).keydown(function(e) {
                            if (e.which == 13)
                                e.preventDefault();
                            $(this).data('pervData', this.text);
                        }).keyup(function(e) {
                            //var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
                            //console.log(e.which);
                            //上下左右  , shift
                            if((e.which>=37 && e.which<=40) || e.which==16)
                            	return;
                            
                            var prevVal = $(this).data('pervData');
                            var curVal = $(this).text();
                            //格式判斷
                            var patt = /(^\d{0,3}$)|(^\d{3}\/$)|(^\d{3}\/\d{0,2}$)|(^\d{3}\/\d{2}\\$)|(^\d{3}\/\d{2}\/\d{0,2}$)/;
                            if (/^\d{3}\d$/.test(curVal)) {
                                $(this).text(curVal.replace(/^(\d{3})(\d)$/, '$1/$2'));
                            } else if (/^\d{3}\/\d{3}$/.test(curVal)) {
                                $(this).text(curVal.replace(/^(\d{3}\/\d{2})(\d)$/, '$1/$2'));
                            } else if (!patt.test(curVal)) {
                                $(this).text(prevVal);
                            }
                            //跳到字尾
                            var doc = document;
                            var element = $(this)[0];
                            if (window.getSelection) {
                                var selection = window.getSelection();
                                var range = document.createRange();
                                range.selectNodeContents(element);
                                selection.removeAllRanges();
                                selection.addRange(range);
                                selection.collapseToEnd();
                            }
                            //跳下一格
                            if (e.which == 13) {
                                $(this).text(prevVal);
                                if (nextObj != null)
                                    $(this).data('nextObj').focus();
                            }
                        });
                    }
                });
                $(this).data('info').init($(this));
            };

		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id='q_menu'></div>
		<div id='q_acDiv'></div>
		<div style="height:40px;">
			<span style="display:block;width:100px;height:20px;float:left;"></span>
			<input type='button' id='btnAuthority' name='btnAuthority' style='font-size:16px;float:left;' value='權限'/>
		</div>
		<div id="aa"></div>
	</body>
</html>
