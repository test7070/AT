<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">   
        
        public class ParaOut
        {
            public List<Item> car = new System.Collections.Generic.List<Item>();
            public List<Item> card = new System.Collections.Generic.List<Item>();
            public List<Item> yard = new System.Collections.Generic.List<Item>();
        }
        public class Item
        {
            public string noa;
            public string qtime;
            public string memo;
        }
        public void Page_Load()
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            //連接字串      
            string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=" + HttpUtility.UrlDecode(Request.Headers["database"]);
            // action: car、card、yard
            //string action = Request.QueryString["action"];
            //抓資料
            System.Data.DataTable dtCar = new System.Data.DataTable();
            System.Data.DataTable dtCard = new System.Data.DataTable();
            System.Data.DataTable dtYard = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString ))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select a.carno noa,CONVERT(nvarchar, c.qtime, 120) qtime,c.memo
                    from car2 a
                    left join carspec b on a.carspecno=b.noa
                    outer apply(select top 1 * from transtatus where typea='car' and noa=a.carno order by noa,qtime desc) c
                    where cartype='2' and charindex('板台',isnull(b.spec,''))=0
                    order by a.carno";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                adapter.SelectCommand = cmd;
                adapter.Fill(dtCar);

                queryString = @"select a.carno,CONVERT(nvarchar, c.qtime, 120) qtime,c.memo
                    from car2 a
                    left join carspec b on a.carspecno=b.noa
                    outer apply(select top 1 * from transtatus where typea='card' and noa=a.carno order by noa,qtime desc) c
                    where cartype='2' and charindex('板台',isnull(b.spec,''))>0
                    order by a.carno";
                cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                adapter.SelectCommand = cmd;
                adapter.Fill(dtCard);

                queryString = @"select a.noa,CONVERT(nvarchar, c.qtime, 120) qtime,c.memo
                    from tranyard a
                    outer apply(select top 1 * from transtatus where typea='yard1' and noa=a.noa order by noa,qtime desc) c
                    order by a.noa";
                cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                adapter.SelectCommand = cmd;
                adapter.Fill(dtYard);
                connSource.Close();
            }
            ParaOut pout = new ParaOut();
            
            Item tmp;
            foreach (System.Data.DataRow r in dtCar.Rows)
            {
                tmp = new Item();
                tmp.noa = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                tmp.qtime = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                tmp.memo = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pout.car.Add(tmp);
            }
            foreach (System.Data.DataRow r in dtCard.Rows)
            {
                tmp = new Item();
                tmp.noa = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                tmp.qtime = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                tmp.memo = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pout.card.Add(tmp);
            }
            foreach (System.Data.DataRow r in dtYard.Rows)
            {
                tmp = new Item();
                tmp.noa = System.DBNull.Value.Equals(r.ItemArray[0]) ? "" : (System.String)r.ItemArray[0];
                tmp.qtime = System.DBNull.Value.Equals(r.ItemArray[1]) ? "" : (System.String)r.ItemArray[1];
                tmp.memo = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                pout.yard.Add(tmp);
            }
            Response.Write(serializer.Serialize(pout));
        }    
    </script>
