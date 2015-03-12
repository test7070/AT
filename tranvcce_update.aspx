 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public long recno;
            public int seq;
            public string datea, ordeno, custno, cust, straddrno, straddr;
            public string casetype, containerno1, containerno2;
            public string date1, date2, date3, date4, date5, date6;
            public string driver1, driver2, driver3, driver4, driver5, driver6;
            public string carno1, carno2, carno3, carno4, carno5, carno6;
            public string cardno1, cardno2, cardno3, cardno4, cardno5, cardno6;
            public string msg1, msg2, msg3, msg4, msg5, msg6;
            public string memo,enda,chk1,chk2;
            public string time1,time2,time3,time4,time5,time6;
            public string stype;
        }
        
        //連接字串   
        string DCConnectionString = "";   
        public void Page_Load()
        {
        	DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + HttpUtility.UrlDecode(Request.Headers["database"]);
            try
            {
                //參數
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
                //資料寫入
                
                System.Data.DataTable tranvcce = new System.Data.DataTable();
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();
                    string queryString = "";
                    //取得訂單資料
                    System.Data.DataTable orde = new System.Data.DataTable();
                    queryString = @"
	                    declare @t_containerno1 nvarchar(20)
					    declare @t_containerno2 nvarchar(20)
					
					    declare @t_carno1 nvarchar(20)=''
					    declare @t_carno2 nvarchar(20)=''
					    declare @t_carno3 nvarchar(20)=''
					    declare @t_carno4 nvarchar(20)=''
					    declare @t_carno5 nvarchar(20)=''
					    declare @t_carno6 nvarchar(20)=''
					
					    declare @t_driverno nvarchar(20)
				
					    declare @t_date1 nvarchar(max)
					    declare @t_date2 nvarchar(max)
					    declare @t_date3 nvarchar(max)
					    declare @t_date4 nvarchar(max)
					    declare @t_date5 nvarchar(max)
					    declare @t_date6 nvarchar(max)

                        declare @t_addr nvarchar(max)
                        declare @t_nick nvarchar(max)
					    -------------------------------------------
					    --以派車單上的資料為主，不足再從訂單找
					
					    select @t_carno1 = isnull(a.carno1,''),@t_carno2 = isnull(a.carno2,''),@t_carno3 = isnull(a.carno3,'')
					    	,@t_carno4 = isnull(a.carno4,''),@t_carno5 = isnull(a.carno5,''),@t_carno6 = isnull(a.carno6,'')
                            ,@t_addr = isnull(c.straddr,''),@t_nick = isnull(b.comp,'')
					    from tranvcce a
					    left join view_tranorde b on a.ordeaccy=b.accy and a.ordeno=b.noa
					    left join view_tranordet c on a.ordeaccy=c.accy and a.ordeno=c.noa and a.ordenoq=c.noq
					    where a.seq = @seq
					    --領
					    if(@carno1!=@t_carno1 and len(@carno1)>0)
					    begin
					        set @t_driverno = ''
					        select @t_driverno=noa from driver where namea=@driver1

					        set @t_date1 = @date1 + case when len(ISNULL(@time1,''))>0 then '_'+@time1 else '' end
					        insert into tranvcces(seq,field,carid,driverno,driver,[message],sendtime)
					        select @seq,'領',@carno1,@t_driverno,@driver1
								,'貨主：'+@t_nick+' 地點：'+@t_addr+' 領櫃日期：'+@t_date1+case when len(isnull(@msg1,''))>0 then '注意事項：'+@msg1 else '' end
								,getdate()
					    end
					    --送
					    if(@carno2!=@t_carno2 and len(@carno2)>0)
					    begin
					        set @t_driverno = ''
					        select @t_driverno=noa from driver where namea=@driver2
					        
                            set @t_date2 = @date2 + case when len(ISNULL(@time2,''))>0 then '_'+@time2 else '' end
					        insert into tranvcces(seq,field,carid,driverno,driver,[message],sendtime)
					        select @seq,'送',@carno2,@t_driverno,@driver2
								,'貨主：'+@t_nick+' 地點：'+@t_addr+' 送櫃日期：'+@t_date2+case when len(isnull(@msg2,''))>0 then '注意事項：'+@msg2 else '' end
								,getdate()
					    end
					    --收
					    if(@carno3!=@t_carno3 and len(@carno3)>0)
					    begin
					        set @t_driverno = ''
					        select @t_driverno=noa from driver where namea=@driver3
					        
                            set @t_date3 = @date3 + case when len(ISNULL(@time3,''))>0 then '_'+@time3 else '' end
					        insert into tranvcces(seq,field,carid,driverno,driver,[message],sendtime)
					        select @seq,'收',@carno3,@t_driverno,@driver3
								,'貨主：'+@t_nick+' 地點：'+@t_addr+' 收櫃日期：'+@t_date3+case when len(isnull(@msg3,''))>0 then '注意事項：'+@msg3 else '' end
								,getdate()
					    end
					    --交
					    if(@carno4!=@t_carno4 and len(@carno4)>0)
					    begin
					        set @t_driverno = ''
					        select @t_driverno=noa from driver where namea=@driver4
					        
                            set @t_date4 = @date4 + case when len(ISNULL(@time4,''))>0 then '_'+@time4 else '' end
					        insert into tranvcces(seq,field,carid,driverno,driver,[message],sendtime)
					        select @seq,'交',@carno4,@t_driverno,@driver4
								,'貨主：'+@t_nick+' 地點：'+@t_addr+' 交櫃日期：'+@t_date4+case when len(isnull(@msg4,''))>0 then '注意事項：'+@msg4 else '' end
								,getdate()
					    end
					    --移1
					    if(@carno5!=@t_carno5 and len(@carno5)>0)
					    begin
					        set @t_driverno = ''
					        select @t_driverno=noa from driver where namea=@driver5
					        
                            set @t_date5 = @date5 + case when len(ISNULL(@time5,''))>0 then '_'+@time5 else '' end
					        insert into tranvcces(seq,field,carid,driverno,driver,[message],sendtime)
					        select @seq,'移1',@carno5,@t_driverno,@driver5
								,'貨主：'+@t_nick+' 地點：'+@t_addr+' 移櫃日期：'+@t_date5+case when len(isnull(@msg5,''))>0 then '注意事項：'+@msg5 else '' end
								,getdate()
					    end
					    --移2
					    if(@carno6!=@t_carno6 and len(@carno6)>0)
					    begin
					        set @t_driverno = ''
					        select @t_driverno=noa from driver where namea=@driver6
					        
                            set @t_date6 = @date6 + case when len(ISNULL(@time6,''))>0 then '_'+@time6 else '' end
					        insert into tranvcces(seq,field,carid,driverno,driver,[message],sendtime)
					        select @seq,'移2',@carno6,@t_driverno,@driver6
								,'貨主：'+@t_nick+' 地點：'+@t_addr+' 移櫃日期：'+@t_date6+case when len(isnull(@msg6,''))>0 then '注意事項：'+@msg6 else '' end
								,getdate()
					    end";                   
                    //更新資料
                    queryString += @" update tranvcce
	                    set edittime=getdate(),datea=@datea,straddrno=@straddrno,straddr=@straddr
	                    ,casetype=@casetype,containerno1=@containerno1,containerno2=@containerno2
	                    ,date1=@date1,date2=@date2,date3=@date3,date4=@date4,date5=@date5,date6=@date6
	                    ,driver1=@driver1,driver2=@driver2,driver3=@driver3,driver4=@driver4,driver5=@driver5,driver6=@driver6
	                    ,carno1=@carno1,carno2=@carno2,carno3=@carno3,carno4=@carno4,carno5=@carno5,carno6=@carno6
	                    ,cardno1=@cardno1,cardno2=@cardno2,cardno3=@cardno3,cardno4=@cardno4,cardno5=@cardno5,cardno6=@cardno6
	                    ,msg1=@msg1,msg2=@msg2,msg3=@msg3,msg4=@msg4,msg5=@msg5,msg6=@msg6
	                    ,memo=@memo,enda=@enda,chk1=@chk1,chk2=@chk2 
	                    ,time1=@time1,time2=@time2,time3=@time3
	                    ,time4=@time4,time5=@time5,time6=@time6 
	                     where seq=@seq and isnull(isdel,0)=0 and len(isnull(enda,''))=0";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@seq", itemIn.seq);
                    cmd.Parameters.AddWithValue("@datea", itemIn.datea);
                    cmd.Parameters.AddWithValue("@straddrno", itemIn.straddrno);
                    cmd.Parameters.AddWithValue("@straddr", itemIn.straddr);
                    cmd.Parameters.AddWithValue("@casetype", itemIn.casetype);
                    cmd.Parameters.AddWithValue("@containerno1", itemIn.containerno1);
                    cmd.Parameters.AddWithValue("@containerno2", itemIn.containerno2);
                    cmd.Parameters.AddWithValue("@date1", itemIn.date1);
                    cmd.Parameters.AddWithValue("@date2", itemIn.date2);
                    cmd.Parameters.AddWithValue("@date3", itemIn.date3);
                    cmd.Parameters.AddWithValue("@date4", itemIn.date4);
                    cmd.Parameters.AddWithValue("@date5", itemIn.date5);
                    cmd.Parameters.AddWithValue("@date6", itemIn.date6);
                    cmd.Parameters.AddWithValue("@driver1", itemIn.driver1);
                    cmd.Parameters.AddWithValue("@driver2", itemIn.driver2);
                    cmd.Parameters.AddWithValue("@driver3", itemIn.driver3);
                    cmd.Parameters.AddWithValue("@driver4", itemIn.driver4);
                    cmd.Parameters.AddWithValue("@driver5", itemIn.driver5);
                    cmd.Parameters.AddWithValue("@driver6", itemIn.driver6);
                    cmd.Parameters.AddWithValue("@carno1", itemIn.carno1);
                    cmd.Parameters.AddWithValue("@carno2", itemIn.carno2);
                    cmd.Parameters.AddWithValue("@carno3", itemIn.carno3);
                    cmd.Parameters.AddWithValue("@carno4", itemIn.carno4);
                    cmd.Parameters.AddWithValue("@carno5", itemIn.carno5);
                    cmd.Parameters.AddWithValue("@carno6", itemIn.carno6);
                    cmd.Parameters.AddWithValue("@cardno1", itemIn.cardno1);
                    cmd.Parameters.AddWithValue("@cardno2", itemIn.cardno2);
                    cmd.Parameters.AddWithValue("@cardno3", itemIn.cardno3);
                    cmd.Parameters.AddWithValue("@cardno4", itemIn.cardno4);
                    cmd.Parameters.AddWithValue("@cardno5", itemIn.cardno5);
                    cmd.Parameters.AddWithValue("@cardno6", itemIn.cardno6);
                    cmd.Parameters.AddWithValue("@msg1", itemIn.msg1);
                    cmd.Parameters.AddWithValue("@msg2", itemIn.msg2);
                    cmd.Parameters.AddWithValue("@msg3", itemIn.msg3);
                    cmd.Parameters.AddWithValue("@msg4", itemIn.msg4);
                    cmd.Parameters.AddWithValue("@msg5", itemIn.msg5);
                    cmd.Parameters.AddWithValue("@msg6", itemIn.msg6);
                    cmd.Parameters.AddWithValue("@memo", itemIn.memo);
                    cmd.Parameters.AddWithValue("@enda", itemIn.enda);
                    cmd.Parameters.AddWithValue("@chk1", itemIn.chk1);
                    cmd.Parameters.AddWithValue("@chk2", itemIn.chk2);
                    cmd.Parameters.AddWithValue("@time1", itemIn.time1);
                    cmd.Parameters.AddWithValue("@time2", itemIn.time2);
                    cmd.Parameters.AddWithValue("@time3", itemIn.time3);
                    cmd.Parameters.AddWithValue("@time4", itemIn.time4);
                    cmd.Parameters.AddWithValue("@time5", itemIn.time5);
                    cmd.Parameters.AddWithValue("@time6", itemIn.time6);
                    cmd.Parameters.AddWithValue("@stype", itemIn.stype);
                    cmd.ExecuteNonQuery();
                    connSource.Close();
                }
                Response.Write("");
            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
       
    </script>
