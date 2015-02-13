 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        string connString;
        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        
        public class Tranmsg { 
            public int seq;
            public string carno;
            public string sender;
            public string sendtime;
            public string sendmsg;
            public string sendcommandresult;
            public string commandid;
            public string querycommandstatusresult;
            public string statuscode;
        }
        public class ParaIn {
            public string sender;
            public string carno;
            public string sendmsg;
        }
        
        public void Page_Load()
        {
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;

            string groupName = "CHITC771";
             string action = HttpUtility.UrlDecode(Request.Headers["action"]);
             string database = HttpUtility.UrlDecode(Request.Headers["database"]);
             string carno = HttpUtility.UrlDecode(Request.Headers["carno"]);
             connString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + database;

            try {
                switch (action)
                {
                    case "setdata":
                        int formSize = Request.TotalBytes;
                        byte[] formData = Request.BinaryRead(formSize);
                        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        var pin = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
                        setData(pin);
                        break;
                    case "getdata":
                        getData(carno);
                        break;
                    default:
                        break;

                }
            }
            catch(Exception e){
                Response.Write(e.Message);
            }
        }
        public void setData(ParaIn pin) {
            string queryString;
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                queryString = @"insert into tranmsg(sender,carno,sendmsg,sendtime) select @sender,@carno,@sendmsg,GETDATE()";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@sender", pin.sender);
                cmd.Parameters.AddWithValue("@carno", pin.carno);
                cmd.Parameters.AddWithValue("@sendmsg", pin.sendmsg);
                cmd.ExecuteNonQuery();
                connSource.Close();
            }
            Response.Write("send done!");
        }

        public void getData(string carno) {
            //抓資料
            System.Data.DataTable dtMsg = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(connString))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select top 10 seq,carno,sender,CONVERT(nvarchar,sendtime,120),sendmsg
                    ,sendcommandresult,commandid,querycommandstatusresult,statuscode
                    from tranmsg where carno=@carno order by carno,seq desc";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@carno", carno);
                adapter.SelectCommand = cmd;
                adapter.Fill(dtMsg);

                connSource.Close();
            }
            List<Tranmsg> pout = new List<Tranmsg>();
            Tranmsg tmp;
            foreach (System.Data.DataRow r in dtMsg.Rows)
            {
                tmp = new Tranmsg();
                tmp.seq = (System.Int32)r.ItemArray[0];
                tmp.carno = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                tmp.sender = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                tmp.sendtime = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                tmp.sendmsg = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                tmp.sendcommandresult = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                tmp.commandid = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                tmp.querycommandstatusresult = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];
                tmp.statuscode = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                pout.Add(tmp);
            }
            Response.Write(serializer.Serialize(pout));
        }
        
        public void SendCommand(string groupName,string carId,string message)
        {
            string targetUrl = "http://115.85.145.34/Service/Service.asmx?op=SendCommand";
            string parame = @"<?xml version=""1.0"" encoding=""utf-8""?>
                <soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
                  <soap:Body>
                    <SendCommand xmlns=""http://tempuri.org/"">
                      <GroupName>"+groupName+@"</GroupName>
                      <CarId>"+carId+@"</CarId>
                      <Message>"+message+@"</Message>
                      <CommandId></CommandId>
                    </SendCommand>
                  </soap:Body>
                </soap:Envelope>";
            byte[] postData = Encoding.UTF8.GetBytes(parame);
            System.Net.HttpWebRequest request = System.Net.HttpWebRequest.Create(targetUrl) as System.Net.HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "text/xml; charset=\"utf-8\"";
            request.Timeout = 5000;
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
                                Response.Write("SendCommandResult:" + ez.Value + "<br>");
                            if (ez.Name.ToString().IndexOf("CommandId") >= 0)
                                Response.Write("CommandId:" + ez.Value + "<br>");
                        }
        }

        public void QueryCommandStatus(string groupName, string commandId)
        {
            string targetUrl = "http://115.85.145.34/Service/Service.asmx?op=QueryCommandStatus";
            string parame = @"<?xml version=""1.0"" encoding=""utf-8""?>
                <soap:Envelope xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"" xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"">
                  <soap:Body>
                    <QueryCommandStatus xmlns=""http://tempuri.org/"">
                      <GroupName>" + groupName + @"</GroupName>
                      <CommandId>" + commandId + @"</CommandId>
                      <StatusCode></StatusCode>
                    </QueryCommandStatus>
                  </soap:Body>
                </soap:Envelope>";
            byte[] postData = Encoding.UTF8.GetBytes(parame);
            System.Net.HttpWebRequest request = System.Net.HttpWebRequest.Create(targetUrl) as System.Net.HttpWebRequest;
            request.Method = "POST";
            request.ContentType = "text/xml; charset=\"utf-8\"";
            request.Timeout = 5000;
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
                            if (ez.Name.ToString().IndexOf("QueryCommandStatusResult") >= 0)
                                Response.Write("QueryCommandStatusResult:" + ez.Value + "<br>");
                            if (ez.Name.ToString().IndexOf("StatusCode") >= 0)
                                Response.Write("StatusCode:" + ez.Value + "<br>");
                        }
        } 
      
    </script>
