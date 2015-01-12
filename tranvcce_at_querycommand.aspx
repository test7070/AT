<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn {
            public string date = "";
        }    
    
        public class QueryCommandTaskByNBXX
        {
            public string GroupName = "CHITC771";
            public int seq = 0;
            public string field = "";
            public string CarId = "";
            public string NBXX = "";
            public DateTime sendtime;
            public string TaskContent = "";
            public string ErrMsg = "";
            public string url = @"http://115.85.145.34/Service/Service.asmx?op=QueryCommandTaskByNBXX";
            public string  soap= @"<?xml version=""1.0"" encoding=""utf-8""?>
                <soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
                  <soap:Body>
                    <QueryCommandTaskByNBXX xmlns=""http://tempuri.org/"">
                      <GroupName>{0}</GroupName>
                      <CarId>{1}</CarId>
                      <NBXX>{2}</NBXX>
                      <TaskContent>{3}</TaskContent>
                      <ErrMsg>{4}</ErrMsg>
                    </QueryCommandTaskByNBXX>
                  </soap:Body>
                </soap:Envelope>";
            public string getPostData(){
                return this.soap.Replace("{0}", this.GroupName).Replace("{1}", this.CarId).Replace("{2}", this.NBXX).Replace("{3}", this.TaskContent).Replace("{4}", this.ErrMsg); 
            }
            
        }
        public class QueryCommandTaskByNBXXResponse
        { 
            public bool QueryCommandTaskByNBXXResult;
            public string TaskContent;
            public string ErrMsg;
            public int seq = 0;
            public string field = "";
            public string CarId = "";
            public string NBXX = "";
            public DateTime sendtime;
        }
        //連接字串      
        string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=DC";

        public void Page_Load()
        {
            try
            {
                //參數
                System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                Response.ContentEncoding = encoding;
                int formSize = Request.TotalBytes;
                byte[] formData = Request.BinaryRead(formSize);
                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
                //ParaIn itemIn = new ParaIn();
                //itemIn.date = "104/01/06";
                
                System.Data.DataTable tranvcces = new System.Data.DataTable();
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();

                    string query = @"declare @t_sendtime date = dbo.ChineseEraName2AD(@t_date)
                    declare @tmp table(
	                    seq int,
	                    field nvarchar(20),
	                    carid nvarchar(20),
	                    nbxx nvarchar(20),
	                    sendtime datetime
                    )
                    declare @seq int
                    declare @field nvarchar(20)
                    declare @carid nvarchar(20)
                    declare @sendtime datetime
                    declare @nbxx nvarchar(20)

                    declare @taskcontent nvarchar(max)
                    declare @emsg nvarchar(max)
                    declare @receivetime datetime

                    declare cursor_table cursor for
                    select seq,field,carid,sendtime,nbxx from tranvcces where receivetime is null and convert(date,sendtime,111) = convert(date,@t_sendtime,111)
                    open cursor_table
                    fetch next from cursor_table
                    into @seq,@field,@carid,@sendtime,@nbxx
                    while(@@FETCH_STATUS <> -1)
                    begin
	                    begin try		
		                    if not exists(select * from tranvcces where seq=@seq and field=@field and sendtime>@sendtime )
		                    begin	
			                    insert into @tmp(seq,field,carid,sendtime,nbxx)
			                    select @seq,@field,@carid,@sendtime,@nbxx
		                    end
	                    end try
	                    begin catch 
		                    --nothing
	                    end catch
	                    fetch next from cursor_table
	                    into @seq,@field,@carid,@sendtime,@nbxx
                    end
                    close cursor_table
                    deallocate cursor_table
                    select * from @tmp";

                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, connSource);
                    cmd.Parameters.AddWithValue("@t_date", itemIn.date);
                    adapter.SelectCommand = cmd;
                    adapter.Fill(tranvcces);
                }
                System.Collections.Generic.List<QueryCommandTaskByNBXX> pout = new System.Collections.Generic.List<QueryCommandTaskByNBXX>();
                QueryCommandTaskByNBXX tmp;
                foreach (System.Data.DataRow r in tranvcces.Rows)
                {
                    tmp = new QueryCommandTaskByNBXX();
                    tmp.seq = (System.Int32)r.ItemArray[0];
                    tmp.field = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                    tmp.CarId = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                    tmp.NBXX = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                    tmp.sendtime = System.DBNull.Value.Equals(r.ItemArray[4]) ? DateTime.MinValue : (System.DateTime)r.ItemArray[4];
                    pout.Add(tmp);     
                }
                //Response.Write("<BR>pout:" + pout.Count.ToString());
                //發送訊息
                System.Collections.Generic.List<QueryCommandTaskByNBXXResponse> receive = new System.Collections.Generic.List<QueryCommandTaskByNBXXResponse>();
                foreach (QueryCommandTaskByNBXX send in pout)
                {
                   // Response.Write("<BR>"+send.seq);
                    byte[] postData = Encoding.UTF8.GetBytes(send.getPostData());
                    System.Net.HttpWebRequest request = System.Net.HttpWebRequest.Create(send.url) as System.Net.HttpWebRequest;
                    request.Method = "POST";
                    request.ContentType = "text/xml; charset=\"utf-8\"";
                    request.Timeout = 5000;
                    // 寫入 Post Body Message 資料流
                    using (System.IO.Stream st = request.GetRequestStream())
                    {
                        st.Write(postData, 0, postData.Length);
                        st.Close();
                    }
                    string result = "";
                    // 取得回應資料
                    using (System.Net.HttpWebResponse response = request.GetResponse() as System.Net.HttpWebResponse)
                    {
                        using (System.IO.StreamReader sr = new System.IO.StreamReader(response.GetResponseStream()))
                        {
                            result = sr.ReadToEnd();
                        }
                        response.Close();
                    }

                    QueryCommandTaskByNBXXResponse tmp2 = new QueryCommandTaskByNBXXResponse();
                    tmp2.seq = send.seq;
                    tmp2.field = send.field;
                    tmp2.CarId = send.CarId;
                    tmp2.NBXX = send.NBXX;
                    tmp2.sendtime = send.sendtime; 
                    XDocument doc = XDocument.Parse(result);
                    foreach (XElement ew in doc.Elements())
                        foreach (XElement ex in ew.Elements())
                            foreach (XElement ey in ex.Elements())
                                foreach (XElement ez in ey.Elements())
                                {
                                    if (ez.Name.ToString().IndexOf("QueryCommandTaskByNBXXResult") >= 0)
                                        tmp2.QueryCommandTaskByNBXXResult = Boolean.Parse(ez.Value);
                                    if (ez.Name.ToString().IndexOf("TaskContent") >= 0)
                                        tmp2.TaskContent = ez.Value;
                                    if (ez.Name.ToString().IndexOf("ErrMsg") >= 0)
                                        tmp2.ErrMsg = ez.Value;
                                }
                    receive.Add(tmp2);
                }

                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    connSource.Open();

                    string query = @"update tranvcces set taskcontent=@taskcontent,errmsg=@errmsg
                        ,receivetime=getdate() where seq=@seq and field=@field and carid=@carid and sendtime=@sendtime";
                    foreach (QueryCommandTaskByNBXXResponse q in receive)
                    {
                        System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(query, connSource);
                        cmd.Parameters.AddWithValue("@taskcontent", q.TaskContent);
                        cmd.Parameters.AddWithValue("@errmsg", q.ErrMsg);
                        cmd.Parameters.AddWithValue("@seq", q.seq);
                        cmd.Parameters.AddWithValue("@field", q.field);
                        cmd.Parameters.AddWithValue("@carid", q.CarId);
                        cmd.Parameters.AddWithValue("@sendtime", q.sendtime);
                        cmd.ExecuteNonQuery();
                    }

                    connSource.Close();
                }
                Response.Write("done");
            }
            catch (Exception e) {
                Response.Write(e.Message);
            }
        }
        
    </script>
