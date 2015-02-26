 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public long recno;
            public int seq;
            public bool isdel;
            public string stype,ucr,por,pod,product;
            public string ordeaccy,ordeno,ordenoq;
            public string datea;
            public string custno,cust;
            public string straddrno,straddr;
            public string vocc;
            public string casetype;
	        public string containerno1,containerno2;
	        public string carno1,cardno1,msg1;
	        public string carno2,cardno2,msg2;
	        public string carno3,cardno3,msg3;
	        public string carno4,cardno4,msg4;
            public string memo;
            public bool issend1, issend2, issend3, issend4;
            public bool isassign;
            public float mount;
            public string seal1,seal2;
            public string yard1,yard2,yard3,yard4;
        }
        public class SendCommand
        { 
            public string SendCommandResult;
            public string CommandId;
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
                //string aa= "{\"recno\":4,\"seq\":3,\"isdel\":false,\"stype\":\"出口\",\"ucr\":\"\",\"por\":\"\",\"pod\":\"\",\"product\":\"\",\"ordeaccy\":\"104\",\"ordeno\":\"BB1040129001\",\"ordenoq\":\"002\",\"datea\":\"\",\"custno\":\"A001\",\"cust\":\"誼友交通事業股份有限公司\",\"straddrno\":\"C003-001\",\"straddr\":\"W-橋頭\",\"vocc\":\"\",\"casetype\":\"\",\"containerno1\":\"c\",\"containerno2\":\"\",\"carno1\":\"\",\"cardno1\":\"\",\"msg1\":\"\",\"carno2\":\"\",\"cardno2\":\"\",\"msg2\":\"\",\"carno3\":\"\",\"cardno3\":\"\",\"msg3\":\"\",\"carno4\":\"\",\"cardno4\":\"\",\"msg4\":\"\",\"memo\":\"\",\"issend1\":false,\"issend2\":false,\"issend3\":false,\"issend4\":false,\"isassign\":false,\"mount\":\"0\",\"seal1\":\"\",\"seal2\":\"\",\"edittime\":\"\"}";   
                //var itemIn = serializer.Deserialize<ParaIn>(aa);
                //資料寫入
                
                System.Data.DataTable tranvcce = new System.Data.DataTable();
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();
                    
                    //更新資料
                    //car
                    string queryString = @"insert into transtatus(typea,noa,qtime,memo)
                        select 'car',@carno1,getdate(),'領：'+@straddr+' '+@msg1
                        from tranvcce
                        where seq=@seq and carno1!=@carno1 and len(@carno1)>0";
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'car',@carno2,getdate(),'送：'+@straddr+' '+@msg2
                        from tranvcce
                        where seq=@seq and carno2!=@carno2 and len(@carno2)>0";
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'car',@carno3,getdate(),'收：'+@straddr+' '+@msg3
                        from tranvcce
                        where seq=@seq and carno3!=@carno3 and len(@carno3)>0";
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'car',@carno4,getdate(),'交：'+@straddr+' '+@msg4
                        from tranvcce
                        where seq=@seq and carno4!=@carno4 and len(@carno4)>0";
                    //card
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'card',@cardno1,getdate(),'領：'+@carno1+' '+@msg1
                        from tranvcce
                        where seq=@seq and ((cardno1!=@cardno1 and len(@cardno1)>0) or (carno1!=@carno1 and len(@carno1)>0))";
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'card',@cardno2,getdate(),'送：'+@carno2+' '+@msg2
                        from tranvcce
                        where seq=@seq and ((cardno2!=@cardno2 and len(@cardno2)>0) or (carno2!=@carno2 and len(@carno2)>0))"; 
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'card',@cardno3,getdate(),'收：'+@carno3+' '+@msg3
                        from tranvcce
                        where seq=@seq and ((cardno3!=@cardno3 and len(@cardno3)>0) or (carno3!=@carno3 and len(@carno3)>0))";    
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'card',@cardno4,getdate(),'交：'+@carno4+' '+@msg4
                        from tranvcce
                        where seq=@seq and ((cardno4!=@cardno4 and len(@cardno4)>0) or (carno4!=@carno4 and len(@carno4)>0))";    
                    //yard
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'yard',@yard1,getdate()
                        ,'領：'+@cust
                        	+case when len(@msg1)>0 then '，'+@msg1 else '' end
                        	+case when len(@containerno1)>0 then '，'+@containerno1 else '' end
                        	+case when len(@containerno2)>0 then '、'+@containerno2 else '' end	
                        from tranvcce
                        where seq=@seq and (isnull(yard1,'')!=@yard1 and len(@yard1)>0)";
                    
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'yard',@yard2,getdate()
                        ,'領：'+@cust
                        	+case when len(@msg2)>0 then '，'+@msg2 else '' end
                        	+case when len(@containerno1)>0 then '，'+@containerno1 else '' end
                        	+case when len(@containerno2)>0 then '、'+@containerno2 else '' end	
                        from tranvcce
                        where seq=@seq and (isnull(yard2,'')!=@yard2 and len(@yard2)>0)";
                    
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'yard',@yard3,getdate()
                        ,'領：'+@cust
                        	+case when len(@msg3)>0 then '，'+@msg3 else '' end
                        	+case when len(@containerno1)>0 then '，'+@containerno1 else '' end
                        	+case when len(@containerno2)>0 then '、'+@containerno2 else '' end	
                        from tranvcce
                        where seq=@seq and (isnull(yard3,'')!=@yard3 and len(@yard3)>0)";
                    
                    queryString += @" insert into transtatus(typea,noa,qtime,memo)
                        select 'yard',@yard4,getdate()
                        ,'領：'+@cust
                        	+case when len(@msg4)>0 then '，'+@msg4 else '' end
                        	+case when len(@containerno1)>0 then '，'+@containerno1 else '' end
                        	+case when len(@containerno2)>0 then '、'+@containerno2 else '' end	
                        from tranvcce
                        where seq=@seq and (isnull(yard4,'')!=@yard4 and len(@yard4)>0)";
                        
                    queryString += @" update tranvcce set
                        datea=@datea,straddrno=@straddrno,straddr=@straddr,vocc=@vocc,casetype=@casetype
	                    ,containerno1=@containerno1,containerno2=@containerno2
	                    ,carno1=@carno1,cardno1=@cardno1,msg1=@msg1
	                    ,carno2=@carno2,cardno2=@cardno2,msg2=@msg2
	                    ,carno3=@carno3,cardno3=@cardno3,msg3=@msg3
                        ,carno4=@carno4,cardno4=@cardno4,msg4=@msg4
	                    ,memo=@memo,edittime=getDate(),isassign=@isassign
	                    ,mount=@mount,seal1=@seal1,seal2=@seal2
	                    ,yard1=@yard1,yard2=@yard2,yard3=@yard3,yard4=@yard4
	                     where seq=@seq and isnull(isdel,0)=0";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@seq", itemIn.seq);
                    cmd.Parameters.AddWithValue("@datea", itemIn.datea);
                    cmd.Parameters.AddWithValue("@custno", itemIn.custno);
                    cmd.Parameters.AddWithValue("@cust", itemIn.cust);
                    cmd.Parameters.AddWithValue("@straddrno", itemIn.straddrno);
                    cmd.Parameters.AddWithValue("@straddr", itemIn.straddr);
                    cmd.Parameters.AddWithValue("@vocc", itemIn.vocc);
                    cmd.Parameters.AddWithValue("@casetype", itemIn.casetype);
                    cmd.Parameters.AddWithValue("@containerno1", itemIn.containerno1);
                    cmd.Parameters.AddWithValue("@containerno2", itemIn.containerno2);
                    cmd.Parameters.AddWithValue("@carno1", itemIn.carno1);
                    cmd.Parameters.AddWithValue("@cardno1", itemIn.cardno1);
                    cmd.Parameters.AddWithValue("@msg1", itemIn.msg1);
                    cmd.Parameters.AddWithValue("@carno2", itemIn.carno2);
                    cmd.Parameters.AddWithValue("@cardno2", itemIn.cardno2);
                    cmd.Parameters.AddWithValue("@msg2", itemIn.msg2);
                    cmd.Parameters.AddWithValue("@carno3", itemIn.carno3);
                    cmd.Parameters.AddWithValue("@cardno3", itemIn.cardno3);
                    cmd.Parameters.AddWithValue("@msg3", itemIn.msg3);
                    cmd.Parameters.AddWithValue("@carno4", itemIn.carno4);
                    cmd.Parameters.AddWithValue("@cardno4", itemIn.cardno4);
                    cmd.Parameters.AddWithValue("@msg4", itemIn.msg4);
                    cmd.Parameters.AddWithValue("@memo", itemIn.memo);
                    cmd.Parameters.AddWithValue("@isassign", itemIn.isassign?1:0);
                    cmd.Parameters.AddWithValue("@mount", itemIn.mount);
                    cmd.Parameters.AddWithValue("@seal1", itemIn.seal1);
                    cmd.Parameters.AddWithValue("@seal2", itemIn.seal2);
                    cmd.Parameters.AddWithValue("@yard1", itemIn.yard1);
                    cmd.Parameters.AddWithValue("@yard2", itemIn.yard2);
                    cmd.Parameters.AddWithValue("@yard3", itemIn.yard3);
                    cmd.Parameters.AddWithValue("@yard4", itemIn.yard4);
                    cmd.ExecuteNonQuery();
                    //--------------------------送資料給長輝--------------------------------------
                    bool isdelay = false;
                    if (itemIn.issend1 && itemIn.carno1.Length>0)
                    {
                        sendCommand(connSource, itemIn, itemIn.carno1, itemIn.msg1, "card1");
                    }
                    if (itemIn.issend2 && itemIn.carno2.Length > 0)
                    {
                        if(isdelay)
                            System.Threading.Thread.Sleep(1000);
                        sendCommand(connSource, itemIn, itemIn.carno2, itemIn.msg2, "card2");
                    }
                    if (itemIn.issend3 && itemIn.carno3.Length > 0)
                    {
                        if (isdelay)
                            System.Threading.Thread.Sleep(1000);
                        sendCommand(connSource, itemIn, itemIn.carno3, itemIn.msg3, "card3");
                    }
                    if (itemIn.issend4 && itemIn.carno4.Length > 0)
                    {
                        if (isdelay)
                            System.Threading.Thread.Sleep(1000);
                        sendCommand(connSource, itemIn, itemIn.carno4, itemIn.msg4, "card4");
                    }
                    
                    connSource.Close();
                }
                Response.Write("");
            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
        public void sendCommand(System.Data.SqlClient.SqlConnection connSource,ParaIn item, string carno, string memo,string field)
        {
            
            //取得發訊息的序號 : sendno
            System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
            System.Data.DataTable maxSendno = new System.Data.DataTable();
            
            string queryString = "declare @t_sendno int=0 " +
                    "select @t_sendno = sendno from tranvcces where seq=@t_seq and carid=@t_carno and field=@t_field " +
                    "if(ISNULL(@t_sendno,0)=0) begin " +
                    "select @t_sendno = MAX(sendno) from tranvcces where carid = @t_carno " +
                    "set @t_sendno=isnull(@t_sendno,0)+1 " +
                    "end " +
                    "select @t_sendno";
            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
            cmd.Parameters.AddWithValue("@t_seq", item.seq);
            cmd.Parameters.AddWithValue("@t_carno", carno);
            cmd.Parameters.AddWithValue("@t_field", field);
            adapter.SelectCommand = cmd;
            adapter.Fill(maxSendno);
            int sendno = (System.Int32)maxSendno.Rows[0].ItemArray[0];
            string nbxx = "00" + sendno.ToString();
            nbxx = nbxx.Substring(nbxx.Length - 2, 2);
            nbxx = "NB" + nbxx;
            string message = nbxx;  
            //取得訂單資料
            System.Data.DataTable orde = new System.Data.DataTable();
            queryString = @"select stype,comp,vocc,casetype,0 mount
                ,so,do1,vessel,voyage,port
                ,port2,etc,freetime,do2,option01
                ,trackno,vr,manifest,casepresent
                 from view_tranorde where accy=@accy and noa=@noa ";
            cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
            cmd.Parameters.AddWithValue("@noa", item.ordeno);
            cmd.Parameters.AddWithValue("@accy", item.ordeaccy);
            adapter.SelectCommand = cmd;
            adapter.Fill(orde);
            string stype = "";
            if(orde.Rows.Count>0){
                //出口
                if (item.stype == "出口")
                {
                    message += " 貨主：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[1]) ? "" : (System.String)orde.Rows[0].ItemArray[1]);
                    message += " 船公司：" + item.vocc;
                    message += " 櫃型：" + item.casetype;
                    //message += " 櫃數：" + item.mount.ToString();
                    message += " SO：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[5]) ? "" : (System.String)orde.Rows[0].ItemArray[5]);
                    message += " 領櫃代號：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[6]) ? "" : (System.String)orde.Rows[0].ItemArray[6]);
                    message += " 船名：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[7]) ? "" : (System.String)orde.Rows[0].ItemArray[7]);
                    message += " 航次：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[8]) ? "" : (System.String)orde.Rows[0].ItemArray[8]);
                    message += " 卸貨港：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[9]) ? "" : (System.String)orde.Rows[0].ItemArray[9]);
                    message += " 領櫃場：" + item.por;
                    message += " 結關日：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[11]) ? "" : (System.String)orde.Rows[0].ItemArray[11]);
                }
                else { 
                    message += " 貨主："+ (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[1]) ? "" : (System.String)orde.Rows[0].ItemArray[1]);
                    message += " 貨櫃號碼："+item.containerno1+(item.containerno2.Length>0?".":item.containerno2);
                    message += " 船公司：" + item.vocc;
                    message += " 櫃型：" + item.casetype;
                    //message += " 櫃數：" + item.mount.ToString();
                    message += " FREETIME："+ (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[12]) ? "" : (System.String)orde.Rows[0].ItemArray[12]);
                    message += " 領櫃場："+ item.por;
                    message += " 狀態："+(item.isassign?"指定":"任一");
                    message += " 提單號碼："+ (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[13]) ? "" : (System.String)orde.Rows[0].ItemArray[13]);
                    message += " 領櫃號碼："+ (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[14]) ? "" : (System.String)orde.Rows[0].ItemArray[14]);
                    message += " 追蹤號碼："+ item.ucr;
                    message += " 代表櫃號：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[17]) ? "" : (System.String)orde.Rows[0].ItemArray[17]);              
                    message += " 掛號：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[16]) ? "" : (System.String)orde.Rows[0].ItemArray[16]);
                    message += " 艙號：" + (System.DBNull.Value.Equals(orde.Rows[0].ItemArray[15]) ? "" : (System.String)orde.Rows[0].ItemArray[15]);
                }
            }
            message+=" 注意事項："+memo;
            //發送訊息
            SendCommand tmp = new SendCommand();
            string targetUrl = "http://115.85.145.34/Service/Service.asmx?op=SendCommand";
            string parame = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">" +
                        " <soap:Body>" +
                        " <SendCommand xmlns=\"http://tempuri.org/\">" +
                        " <GroupName>CHITC771</GroupName>" +
                        " <CarId>" + carno + "</CarId>" +
                        " <Message>" + message + "</Message>" +
                        " <CommandId>1</CommandId>" +
                        " </SendCommand>" +
                    " </soap:Body>" +
                    " </soap:Envelope>";
            byte[] postData = Encoding.UTF8.GetBytes(parame);
            System.Net.HttpWebRequest request = System.Net.HttpWebRequest.Create(targetUrl) as System.Net.HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "text/xml; charset=\"utf-8\"";
            request.Timeout = 5000;
            //request.ContentLength = postData.Length;
            // 寫入 Post Body Message 資料流
            using (System.IO.Stream st = request.GetRequestStream())
            {
                st.Write(postData, 0, postData.Length);
                st.Close();
            }
            string result = "";
            System.Threading.Thread.Sleep(1000);
            // 取得回應資料
            using (System.Net.HttpWebResponse response = request.GetResponse() as System.Net.HttpWebResponse)
            {
                using (System.IO.StreamReader sr = new System.IO.StreamReader(response.GetResponseStream()))
                {
                    result = sr.ReadToEnd();
                }
                response.Close();
            }
            
            XDocument doc = XDocument.Parse(result);
            foreach (XElement ew in doc.Elements())
                foreach (XElement ex in ew.Elements())
                    foreach (XElement ey in ex.Elements())
                        foreach (XElement ez in ey.Elements())
                        {
                            if (ez.Name.ToString().IndexOf("SendCommandResult") >= 0)
                                tmp.SendCommandResult = ez.Value;
                            if (ez.Name.ToString().IndexOf("CommandId") >= 0)
                                tmp.CommandId = ez.Value;
                        }
            
            //--記錄送了什麼
            queryString = @"insert into tranvcces(seq,field,carid,[message],commandid,sendcommandresult,sendtime,sendno,nbxx)
                        values(@seq,@field,@carid,@message,@commandid,@sendcommandresult,GETDATE(),@sendno,@nbxx)";
            cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
            cmd.Parameters.AddWithValue("@field", field);
            cmd.Parameters.AddWithValue("@seq", item.seq);
            cmd.Parameters.AddWithValue("@carid", carno);
            cmd.Parameters.AddWithValue("@message", message);
            cmd.Parameters.AddWithValue("@commandid", tmp.CommandId);
            cmd.Parameters.AddWithValue("@sendcommandresult", tmp.SendCommandResult);
            cmd.Parameters.AddWithValue("@sendno", sendno);
            cmd.Parameters.AddWithValue("@nbxx", nbxx);
            cmd.ExecuteNonQuery();              
        }
    </script>
