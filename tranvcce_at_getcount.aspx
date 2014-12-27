<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaOut
        {
            public long count;
        }
        public void Page_Load()
        {
            ParaOut tmp = new ParaOut();
            tmp.count = 0; 
            //參數
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

            //連接字串      
            string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=DC";
            //抓資料
            System.Data.DataTable tranvcce = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString ))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select count(1) n from tranvcce where ISNULL(isdel,0)=0";
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
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
