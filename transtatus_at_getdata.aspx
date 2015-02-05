<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">   
        public class ParaOut
        {
            public string carno;
            public string qtime;
            public string memo;
        }
        public void Page_Load()
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            //連接字串      
            string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + HttpUtility.UrlDecode(Request.Headers["database"]);
            // action: car、card、yard
            string action = Request.QueryString["action"];
            //抓資料
            System.Data.DataTable data = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString ))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select a.carno,CONVERT(nvarchar, b.qtime, 120),b.memo
                    from car2 a
                    outer apply(select top 1 * from transtatus where carno=a.carno order by carno,qtime desc) b
                    where cartype='2'
                    order by a.carspecno";
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                adapter.SelectCommand = cmd;
                adapter.Fill(data);
                connSource.Close();
            }
            System.Collections.Generic.List<ParaOut> pout = new System.Collections.Generic.List<ParaOut>();
            ParaOut tmp;
            foreach (System.Data.DataRow r in data.Rows)
            {
                tmp = new ParaOut();
 
                tmp.carno = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                tmp.qtime = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                tmp.memo = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pout.Add(tmp);
            }
            Response.Write(serializer.Serialize(pout));
        }    
    </script>
