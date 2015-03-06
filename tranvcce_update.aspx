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
                    
                    //更新資料
                    //car
                    string queryString = @"update tranvcce
	                    set edittime=getdate(),datea=@datea,straddrno=@straddrno,straddr=@straddr
	                    ,casetype=@casetype,containerno1=@containerno1,containerno2=@containerno2
	                    ,date1=@date1,date2=@date2,date3=@date3,date4=@date4,date5=@date5,date6=@date6
	                    ,driver1=@driver1,driver2=@driver2,driver3=@driver3,driver4=@driver4,driver5=@driver5,driver6=@driver6
	                    ,carno1=@carno1,carno2=@carno2,carno3=@carno3,carno4=@carno4,carno5=@carno5,carno6=@carno6
	                    ,cardno1=@cardno1,cardno2=@cardno2,cardno3=@cardno3,cardno4=@cardno4,cardno5=@cardno5,cardno6=@cardno6
	                    ,msg1=@msg1,msg2=@msg2,msg3=@msg3,msg4=@msg4,msg5=@msg5,msg6=@msg6
	                    ,memo=@memo,enda=@enda,chk1=@chk1,chk2=@chk2 where seq=@seq and isnull(isdel,0)=0 and len(isnull(enda,''))=0";
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