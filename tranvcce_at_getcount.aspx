
<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">   
    	//tranvcce_at_getcount 和 tranvcce_at_getdata 要一起改  
        public class ParaIn
        {
        	public string stype;
        	public string cust;
        	public string so;//追蹤 OR S/O
        	public string containerno;
        	public string ordeno;
            public string bdate;
            public string edate;
            public string relay;
            public string finish;
        }
        public class ParaOut
        {
        	public string version = "20160304";
            public long count;
        }
        public void Page_Load()
        {
            ParaOut tmp = new ParaOut();
            tmp.count = 0; 
            //參數
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));

            //連接字串      
            string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + HttpUtility.UrlDecode(Request.Headers["database"]);
            //抓資料
            System.Data.DataTable tranvcce = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString ))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"set @edate = case when LEN(@edate)=0 then CHAR(255) else @edate end
select count(1) n from tranvcce where ISNULL(isdel,0)=0 
and (len(@stype)=0 or isnull(stype,'')=@stype)
and (len(@cust)=0 or charindex(@cust,cust)>0)
and (len(@so)=0 or charindex(@so,ucr)>0 or charindex(@so,vr)>0)
and (len(@containerno)=0 or charindex(@containerno,containerno1)>0 or charindex(@containerno,containerno2)>0)
and (len(@ordeno)=0 or charindex(@ordeno,ordeno)>0)
and (case when len(ISNULL(date4,''))>0 then date4  
	when len(ISNULL(date8,''))>0 then date8 
	when len(ISNULL(date3,''))>0 then date3
	when len(ISNULL(date7,''))>0 then date7
	when len(ISNULL(date6,''))>0 then date6
	when len(ISNULL(date2,''))>0 then date2
	when len(ISNULL(date5,''))>0 then date5
	when len(ISNULL(date1,''))>0 then date1
	else datea end) between @bdate and @edate
and (len(@relay)=0 or (@relay='0' and isnull(isrelay,0)=0) or (@relay='1' and isnull(isrelay,0)=1))
and ((@finish='0' and isnull(isfinish,0)=0) or (@finish='1' and isnull(isfinish,0)=1))";
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@stype", itemIn.stype);
                cmd.Parameters.AddWithValue("@cust", itemIn.cust);
                cmd.Parameters.AddWithValue("@so", itemIn.so);
                cmd.Parameters.AddWithValue("@containerno", itemIn.containerno);
                cmd.Parameters.AddWithValue("@ordeno", itemIn.ordeno);
                cmd.Parameters.AddWithValue("@bdate", itemIn.bdate);
                cmd.Parameters.AddWithValue("@edate", itemIn.edate);
                cmd.Parameters.AddWithValue("@relay", itemIn.relay);
                cmd.Parameters.AddWithValue("@finish", itemIn.finish);
                adapter.SelectCommand = cmd;
                adapter.Fill(tranvcce);
                connSource.Close();
            }
            foreach (System.Data.DataRow r in tranvcce.Rows)
            {
                tmp.count = (System.Int32)r.ItemArray[0];
                break;
            }
            Response.Write(serializer.Serialize(tmp));
        }    
    </script>
