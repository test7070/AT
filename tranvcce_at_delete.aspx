 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public int seq;
            public string user;
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

               // string aa = "{\"seq\":2206,\"user\":\"xxxx\"}";   
               // var itemIn = serializer.Deserialize<ParaIn>(aa);
                //資料寫入
                
                System.Data.DataTable tranvcce = new System.Data.DataTable();
                using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString))
                {
                    System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                    connSource.Open();
                    
                    //更新資料
                    string queryString = @"insert into transtatus(typea,noa,qtime,memo)values('del',@user,getdate(),cast(@seq as nvarchar))";
                    queryString += @"update tranvcce set isdel=1 where seq=@seq";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@seq", itemIn.seq);
                    cmd.Parameters.AddWithValue("@user", itemIn.user);
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
