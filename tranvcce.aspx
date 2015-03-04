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
		<script src="http://59.125.143.170/html2canvas.js"></script>
		<script type="text/javascript">
			jQuery.fn.selectText = function(){
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
            $.fn.grid = function(value) {
                $(this).data('info', {
                	headerheight : 50,
                	rowheight : 30,
                    value : value,
                    row_color : ['LavenderBlush','LightGray'],//grid row color
                    focus_color : 'pink',//grid row color  focus
                    init : function(obj) {
                        obj.css('background-color', 'pink').css('overflow','visible');
                        obj.append('<div style="background-color:PowderBlue;"><table class="header"></table><table class="data"></table></div>');
                        obj.append('<div style="background-color:BurlyWood;"><table class="header"></table><table class="data"></table></div>');
                        obj.children('div').eq(0).css('float', 'left').css('overflow-x','hidden').css('overflow-y','hidden');
                        obj.children('div').eq(1).css('float', 'left').css('overflow-x','scroll').css('overflow-y','hidden');

                        obj.children('div').eq(0).children('table.header').css('background-color', 'AntiqueWhite');
                        obj.children('div').eq(0).children('table.data').css('background-color', 'CornflowerBlue');
                        obj.children('div').eq(1).children('table.header').css('background-color', 'DarkGoldenRod');
                        obj.children('div').eq(1).children('table.data').css('background-color', 'DarkKhaki');
                        //left
                        obj.children('div').eq(0).children('table.header').append("<tr></tr>");
                        for (var i = 0; i < obj.data('info').value.column1.length; i++) {
                            obj.children('div').eq(0).children('table.header').find('tr').eq(0).append('<td align="center" style="width:' + obj.data('info').value.column1[i].width + 'px;background-color:LightGoldenRodYellow;">' + obj.data('info').value.column1[i].name + '</td>')
                        }
                        //right
                        obj.children('div').eq(1).children('table.header').append("<tr></tr>");
                        for (var i = 0; i < obj.data('info').value.column2.length; i++) {
                            obj.children('div').eq(1).children('table.header').find('tr').eq(0).append('<td align="center" style="width:' + obj.data('info').value.column2[i].width + 'px;background-color:LightGoldenRodYellow;">' + obj.data('info').value.column2[i].name + '</td>')
                        }
                        obj.data('info').refresh(obj);
                    },
                    refresh : function(obj) {
                    	var t_height = obj.data('info').headerheight+obj.data('info').value.row.length*obj.data('info').rowheight + 2*obj.data('info').rowheight;
                    	var t_width = obj.data('info').value.width[0]+obj.data('info').value.width[1];
                    	
                    	var top_table_height = obj.data('info').headerheight;
                    	var bottom_table_height = obj.data('info').value.row.length*obj.data('info').rowheight;
                    	var t_width1 = obj.data('info').value.width[0];
                    	var t_width2 = obj.data('info').value.width[1];
                    	
                    	obj.css('height', t_height).css('width', t_width);
                    	obj.children('div').eq(0).css('height', t_height).css('width',t_width1);
                        obj.children('div').eq(1).css('height', t_height).css('width',t_width2);
                        
                        left_table_width = 0;
                        for(var i=0;i<obj.data('info').value.column1.length;i++){
                        	left_table_width += obj.data('info').value.column1[i].width; 	
                        }
                        right_table_width = 0;
                        for(var i=0;i<obj.data('info').value.column2.length;i++){
                        	right_table_width += obj.data('info').value.column2[i].width; 	
                        }
                        //reset
                        obj.children('div').eq(0).children('table.header').height(top_table_height).width(left_table_width);
                        obj.children('div').eq(0).children('table.data').html('').height(bottom_table_height).width(left_table_width);
                        obj.children('div').eq(1).children('table.header').height(top_table_height).width(right_table_width);
                        obj.children('div').eq(1).children('table.data').html('').height(bottom_table_height).width(right_table_width);

						//left
						for(var i=0;i<obj.data('info').value.row.length;i++){
							obj.children('div').eq(0).children('table.data').append('<tr></tr>');
							objtr = obj.children('div').eq(0).children('table.data').find('tr').eq(i);
							objtr.attr('name',i);//記錄資料行數
							objtr.height(obj.data('info').rowheight).css('margin','0px').css('padding','0px');
							for(var j=0;j<obj.data('info').value.column1.length;j++){
								//recno  固定為button
								if(obj.data('info').value.column1[j].field == 'recno'){
									objtr.append('<td align="center"><input type="button" style="width:95%"/></td>');
									objtd = objtr.find('td').eq(j);
									objtd.attr('name',obj.data('info').value.column1[j].field);
									objtd.width(obj.data('info').value.column1[j].width).css('background-color',obj.data('info').row_color[i%obj.data('info').row_color.length]);
									objtd.find('a').css('background-color',obj.data('info').row_color[i%obj.data('info').row_color.length]);
									objtd.find('input').eq(0).attr('value',obj.data('info').value.row[i][obj.data('info').value.column1[j].field]);
									//修改  按鈕事件
									objtd.find('input').data('parent',obj).click(function(e){
										var obj = $(this).data('parent');
										var n = parseInt($(this).parent().parent().attr('name'));
										if($(this).hasClass('edit')){
											//修改確定
											$(this).removeClass('edit');
											obj.find('input[type="button"]').removeAttr('disabled','disabled');
											
											obj.children('div').eq(0).children('table.data').find('tr').eq(n).find('td').css('background-color',obj.data('info').row_color[n%obj.data('info').row_color.length]);
											obj.children('div').eq(1).children('table.data').find('tr').eq(n).find('td').css('background-color',obj.data('info').row_color[n%obj.data('info').row_color.length]);
											obj.children('div').eq(0).children('table.data').find('tr').eq(n).find('td').find('a').css('background-color',obj.data('info').row_color[n%obj.data('info').row_color.length]);
											obj.children('div').eq(1).children('table.data').find('tr').eq(n).find('td').find('a').css('background-color',obj.data('info').row_color[n%obj.data('info').row_color.length]);
											
											obj.find('td').find('a').removeAttr("contenteditable","true");
											//回寫資料庫
											obj.data('info').save(n);
										}else{
											//修改
											$(this).addClass('edit');
											obj.find('input[type="button"]').attr('disabled','disabled');
											$(this).removeAttr('disabled','disabled');
											
											obj.children('div').eq(0).children('table.data').find('tr').eq(n).find('td').css('background-color',obj.data('info').focus_color);
											obj.children('div').eq(1).children('table.data').find('tr').eq(n).find('td').css('background-color',obj.data('info').focus_color);
											obj.children('div').eq(0).children('table.data').find('tr').eq(n).find('td').find('a').css('background-color',obj.data('info').focus_color);
											obj.children('div').eq(1).children('table.data').find('tr').eq(n).find('td').find('a').css('background-color',obj.data('info').focus_color);					
											//欄位變成修改狀態
											//left
											objtr = obj.children('div').eq(0).children('table.data').find('tr').eq(n);
											for(var i=0;i<obj.data('info').value.column1.length;i++){
												//recno 可以算是保留欄位,  忽略
												if(obj.data('info').value.column1[i].field == 'recno'){
													continue;
												}
												objtr.find('td').eq(i).find('a').eq(0).attr("contenteditable","true");
											}
											//right
											objtr = obj.children('div').eq(1).children('table.data').find('tr').eq(n);
											for(var i=0;i<obj.data('info').value.column2.length;i++){
												objtr.find('td').eq(i).find('a').eq(0).attr("contenteditable","true");
											}
										}
									});
								}else{
									objtr.append('<td><a></a></td>');
									objtd = objtr.find('td').eq(j);
									obja = objtd.find('a').eq(0);
									obja.attr('name',obj.data('info').value.column1[j].field+i);
									objtd.width(obj.data('info').value.column1[j].width).css('background-color',obj.data('info').row_color[i%obj.data('info').row_color.length]);
									obja.css('background-color',obj.data('info').row_color[i%obj.data('info').row_color.length]);
									obja.text(obj.data('info').value.row[i][obj.data('info').value.column1[j].field]);
								}
							}
						}
						//right
						for(var i=0;i<obj.data('info').value.row.length;i++){
							obj.children('div').eq(1).children('table.data').append('<tr></tr>');
							objtr = obj.children('div').eq(1).children('table.data').find('tr').eq(i);
							objtr.height(obj.data('info').rowheight).css('margin','0px').css('padding','0px');
							for(var j=0;j<obj.data('info').value.column2.length;j++){
								objtr.append('<td><a></a></td>');
								objtd = objtr.find('td').eq(j);
								obja = objtd.find('a').eq(0);
								obja.attr('name',obj.data('info').value.column2[j].field+i);
								objtd.width(obj.data('info').value.column2[j].width).css('background-color',obj.data('info').row_color[i%obj.data('info').row_color.length]);
								obja.css('background-color',obj.data('info').row_color[i%obj.data('info').row_color.length]);
								obja.text(obj.data('info').value.row[i][obj.data('info').value.column2[j].field]);
							}
						}
						//field event
						for(var i=0;i<obj.data('info').value.row.length;i++){
							objtr_left = obj.children('div').eq(0).children('table.data').find('tr').eq(i);
							objtr_right = obj.children('div').eq(1).children('table.data').find('tr').eq(i);
							for(var j=0;j<obj.data('info').value.column1.length;j++){
								if(obj.data('info').value.column1[j].field == 'recno'){
									continue;
								}
								objtd = objtr_left.find('td').eq(j).find('a').eq(0);
								if(objtd.length==0)
									continue;
								nextObjtd = null;
								for(var k=0;k<obj.data('info').value.column1.length;k++){
									if(obj.data('info').value.column1[j].nextField == obj.data('info').value.column1[k].field){
										nextObjtd = objtr_left.find('td').eq(k).find('a').eq(0);
										break;
									}
								} 
								if(nextObjtd == null){
									for(var k=0;k<obj.data('info').value.column2.length;k++){
										if(obj.data('info').value.column1[j].nextField == obj.data('info').value.column2[k].field){
											nextObjtd = objtr_right.find('td').eq(k).find('a').eq(0);
											break;
										}
									} 
								}
								
								var type = obj.data('info').value.column1[j].type==null?'':obj.data('info').value.column1[j].type;
								switch(obj.data('info').value.column1[j].type){
									case 'date':
											//console.log(i+'__'+j+'__'+objtd.attr('name'));
											obj.data('info').event_date(objtd,nextObjtd);
										break;
									default:
											//console.log(i+'__'+j+'__'+nextObjtd.attr('name')+'__'+objtd.attr('name'));
											obj.data('info').event_norm(objtd,nextObjtd);
										break;
								}	
								
							}
							for(var j=0;j<obj.data('info').value.column2.length;j++){
								if(obj.data('info').value.column2[j].field == 'recno'){
									continue;
								}
								objtd = objtr_right.find('td').eq(j).find('a').eq(0);
								if(objtd.length==0)
									continue;
								nextObjtd = null;
								for(var k=0;k<obj.data('info').value.column1.length;k++){
									if(obj.data('info').value.column2[j].nextField == obj.data('info').value.column1[k].field){
										nextObjtd = objtr_left.find('td').eq(k).find('a').eq(0);
										break;
									}
								} 
								if(nextObjtd == null){
									for(var k=0;k<obj.data('info').value.column2.length;k++){
										if(obj.data('info').value.column2[j].nextField == obj.data('info').value.column2[k].field){
											nextObjtd = objtr_right.find('td').eq(k).find('a').eq(0);
											break;
										}
									} 
								}
								
								var type = obj.data('info').value.column2[j].type==null?'':obj.data('info').value.column2[j].type;
								switch(obj.data('info').value.column2[j].type){
									case 'date':
											//console.log(i+'__'+j+'__'+objtd.attr('name'));
											obj.data('info').event_date(objtd,nextObjtd);
										break;
									default:
									console.log(i+'__'+j);
											console.log(i+'__'+j+'__'+nextObjtd.attr('name')+'__'+objtd.attr('name'));
											obj.data('info').event_norm(objtd,nextObjtd);
										break;
								}	
								
							}
						}
                   },
                   save : function(n){
                   	//先將畫面上資料寫到陣列中
                   	
                   	//將陣列資料存到資料庫
                   	
                   	//必要時刷新畫面資料	
                   },
                   event_norm:function(obj,nextObj){
                   	obj.data('nextObj',nextObj);
                   	obj.keydown(function(e){
                   		if(e.which==13){
							e.preventDefault();
							//跳下一格
							var y = window.scrollY;
							if(nextObj!=null){
								$(this).data('nextObj').focus();
								window.scrollTo($(this).data('nextObj').offset().left - 200, y);
							}
						}
						$(this).data('pervData',this.text);
					}).keyup(function(e) {
						var prevVal = $(this).data('pervData');
						var curVal = $(this).text();
					});
                   },
                   event_date:function(obj,nextObj){
                   	//欄位事件
                   	//日期格式
                   	obj.data('nextObj',nextObj);
                   	obj.focus(function() {
						$(this).text($(this).text());
					}).keydown(function(e){
						if(e.which==13)
							e.preventDefault();
						$(this).data('pervData',this.text);
					}).keyup(function(e) {
						//var n = $(this).attr('id').replace(/^.*_(\d+)$/,'$1');
						var prevVal = $(this).data('pervData');
						var curVal = $(this).text();
						//格式判斷
						var patt = /(^\d{0,3}$)|(^\d{3}\/$)|(^\d{3}\/\d{0,2}$)|(^\d{3}\/\d{2}\\$)|(^\d{3}\/\d{2}\/\d{0,2}$)/;
						if(/^\d{3}\d$/.test(curVal)){
							$(this).text(curVal.replace(/^(\d{3})(\d)$/,'$1/$2'));
						}else if(/^\d{3}\/\d{3}$/.test(curVal)){
							$(this).text(curVal.replace(/^(\d{3}\/\d{2})(\d)$/,'$1/$2'));
						}else if(!patt.test(curVal)){
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
			            if(e.which==13){
			            	$(this).text(prevVal);
			            	if(nextObj!=null)
			            		$(this).data('nextObj').focus();
			            }
					});
                   }
                });
                $(this).data('info').init($(this));
            };

            $(document).ready(function() {
                $('#aa').grid({
                    width : [300, 500],
                    column1 : [{
                        field : "recno",
                        name : '序',
                        width : 50
                    }, {
                        field : "datea",
                        name : '日期',
                        width : 100,
                        type : 'date',
                        nextField : 'noa'
                    }, {
                        field : "noa",
                        name : '單號',
                        width : 150,
                        type : 'norm',
                        nextField : 'addrno'
                    }],
                    column2 : [{
                        field : "addrno",
                        name : '起迄地點',
                        width : 200,
                        type : 'norm',
                        nextField : 'containerno1'
                    }, {
                        field : "containerno1",
                        name : '櫃號一',
                        width : 200,
                        type : 'norm',
                        nextField : 'containerno2'
                    }, {
                        field : "containerno2",
                        name : '櫃號二',
                        width : 200,
                        type : 'norm',
                        nextField : 'containerno2'
                    }],
                    row:[{recno:1,datea:'104/01/05',noa:'AA1040105001',addrno:"A->B",containerno1:'WDSU1234567',containerno2:'WDSU3234567'}
                    	,{recno:2,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:3,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:4,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:5,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:6,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:7,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:8,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:9,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:10,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}
                    	,{recno:11,datea:'104/02/01',noa:'AA1040201013',addrno:"C->B",containerno1:'WDSU8234567',containerno2:'WDSU4234567'}]
                });
            });

		</script>
		<style type="text/css">
		</style>
	</head>
	<body>
		<div id="aa"></div>
	</body>
</html>
