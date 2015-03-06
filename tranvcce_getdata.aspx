<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">
        
        public class ParaIn
        {
            public string cust;
            public string bdate;
            public string edate;
        }
        public class ParaOut
        {
            public long recno;
            public int seq;
            public string datea,ordeno,custno,cust,straddrno,straddr;
	        public string casetype,containerno1,containerno2;
	        public string date1,date2,date3,date4,date5,date6;
	        public string driver1,driver2,driver3,driver4,driver5,driver6;
	        public string carno1,carno2,carno3,carno4,carno5,carno6;
	        public string cardno1,cardno2,cardno3,cardno4,cardno5,cardno6;
	        public string msg1,msg2,msg3,msg4,msg5,msg6;
            public string memo,enda,chk1,chk2;
        }
        public void Page_Load()
        {   
            //參數
            System.Text.Encoding encoding = System.Text.Encoding.UTF8;
            Response.ContentEncoding = encoding;
            int formSize = Request.TotalBytes;
            byte[] formData = Request.BinaryRead(formSize);
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            var itemIn = serializer.Deserialize<ParaIn>(encoding.GetString(formData));
            /*ParaIn itemIn = new ParaIn();
            itemIn.nstr = 0;
            itemIn.nend = 10;
            itemIn.stype = "";
            itemIn.bdate = "";
            itemIn.edate = "";*/
            
            //連接字串      
            string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database="+HttpUtility.UrlDecode(Request.Headers["database"]);
            //抓資料
            System.Data.DataTable tranvcce = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString ))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select recno,seq,datea,ordeno,custno,cust,straddrno,straddr
	                ,casetype,containerno1,containerno2
	                ,date1,date2,date3,date4,date5,date6
	                ,driver1,driver2,driver3,driver4,driver5,driver6
	                ,carno1,carno2,carno3,carno4,carno5,carno6
	                ,cardno1,cardno2,cardno3,cardno4,cardno5,cardno6
	                ,msg1,msg2,msg3,msg4,msg5,msg6
	                ,memo,enda,chk1,chk2
                from(
	                select ROW_NUMBER()over(order by ordeaccy desc,ordeno desc,ordenoq) recno
	                ,*
	                from tranvcce
	                where ISNULL(isdel,0)=0 and len(isnull(enda,''))=0
	                and (len(@cust)=0 or charindex(@cust,cust)>0)
	                and (len(@bdate)=0 or isnull(datea,'')>=@bdate)
	                and (len(@edate)=0 or isnull(datea,'')<=@edate)
                )a
                order by a.recno";
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@cust", itemIn.cust);
                cmd.Parameters.AddWithValue("@bdate", itemIn.bdate);
                cmd.Parameters.AddWithValue("@edate", itemIn.edate);
                adapter.SelectCommand = cmd;
                adapter.Fill(tranvcce);
                connSource.Close();
            }
            System.Collections.Generic.List<ParaOut> pout = new System.Collections.Generic.List<ParaOut>();
            ParaOut tmp;
            foreach (System.Data.DataRow r in tranvcce.Rows)
            {
                tmp = new ParaOut();
                tmp.recno = (System.Int64)r.ItemArray[0];
                tmp.seq = (System.Int32)r.ItemArray[1];
                tmp.datea = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                tmp.ordeno = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                tmp.custno = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                tmp.cust = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                tmp.straddrno = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                tmp.straddr = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];
	            tmp.casetype = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                tmp.containerno1 = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                tmp.containerno2 = System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10];
	            tmp.date1 = System.DBNull.Value.Equals(r.ItemArray[11]) ? "" : (System.String)r.ItemArray[11];
                tmp.date2 = System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12];
                tmp.date3 = System.DBNull.Value.Equals(r.ItemArray[13]) ? "" : (System.String)r.ItemArray[13];
                tmp.date4 = System.DBNull.Value.Equals(r.ItemArray[14]) ? "" : (System.String)r.ItemArray[14];
                tmp.date5 = System.DBNull.Value.Equals(r.ItemArray[15]) ? "" : (System.String)r.ItemArray[15];
                tmp.date6 = System.DBNull.Value.Equals(r.ItemArray[16]) ? "" : (System.String)r.ItemArray[16];
	            tmp.driver1 = System.DBNull.Value.Equals(r.ItemArray[17]) ? "" : (System.String)r.ItemArray[17];
                tmp.driver2 = System.DBNull.Value.Equals(r.ItemArray[18]) ? "" : (System.String)r.ItemArray[18];
                tmp.driver3 = System.DBNull.Value.Equals(r.ItemArray[19]) ? "" : (System.String)r.ItemArray[19];
                tmp.driver4 = System.DBNull.Value.Equals(r.ItemArray[20]) ? "" : (System.String)r.ItemArray[20];
                tmp.driver5 = System.DBNull.Value.Equals(r.ItemArray[21]) ? "" : (System.String)r.ItemArray[21];
                tmp.driver6 = System.DBNull.Value.Equals(r.ItemArray[22]) ? "" : (System.String)r.ItemArray[22];
	            tmp.carno1 = System.DBNull.Value.Equals(r.ItemArray[23]) ? "" : (System.String)r.ItemArray[23];
                tmp.carno2 = System.DBNull.Value.Equals(r.ItemArray[24]) ? "" : (System.String)r.ItemArray[24];
                tmp.carno3 = System.DBNull.Value.Equals(r.ItemArray[25]) ? "" : (System.String)r.ItemArray[25];
                tmp.carno4 = System.DBNull.Value.Equals(r.ItemArray[26]) ? "" : (System.String)r.ItemArray[26];
                tmp.carno5 = System.DBNull.Value.Equals(r.ItemArray[27]) ? "" : (System.String)r.ItemArray[27];
                tmp.carno6 = System.DBNull.Value.Equals(r.ItemArray[28]) ? "" : (System.String)r.ItemArray[28];
	            tmp.cardno1 = System.DBNull.Value.Equals(r.ItemArray[29]) ? "" : (System.String)r.ItemArray[29];
                tmp.cardno2 = System.DBNull.Value.Equals(r.ItemArray[30]) ? "" : (System.String)r.ItemArray[30];
                tmp.cardno3 = System.DBNull.Value.Equals(r.ItemArray[31]) ? "" : (System.String)r.ItemArray[31];
                tmp.cardno4 = System.DBNull.Value.Equals(r.ItemArray[32]) ? "" : (System.String)r.ItemArray[32];
                tmp.cardno5 = System.DBNull.Value.Equals(r.ItemArray[33]) ? "" : (System.String)r.ItemArray[33];
                tmp.cardno6 = System.DBNull.Value.Equals(r.ItemArray[34]) ? "" : (System.String)r.ItemArray[34];
	            tmp.msg1 = System.DBNull.Value.Equals(r.ItemArray[35]) ? "" : (System.String)r.ItemArray[35];
                tmp.msg2 = System.DBNull.Value.Equals(r.ItemArray[36]) ? "" : (System.String)r.ItemArray[36];
                tmp.msg3 = System.DBNull.Value.Equals(r.ItemArray[37]) ? "" : (System.String)r.ItemArray[37];
                tmp.msg4 = System.DBNull.Value.Equals(r.ItemArray[38]) ? "" : (System.String)r.ItemArray[38];
                tmp.msg5 = System.DBNull.Value.Equals(r.ItemArray[39]) ? "" : (System.String)r.ItemArray[39];
                tmp.msg6 = System.DBNull.Value.Equals(r.ItemArray[40]) ? "" : (System.String)r.ItemArray[40];
                tmp.memo = System.DBNull.Value.Equals(r.ItemArray[41]) ? "" : (System.String)r.ItemArray[41];
                tmp.enda = System.DBNull.Value.Equals(r.ItemArray[42]) ? "" : (System.String)r.ItemArray[42];
                tmp.chk1 = System.DBNull.Value.Equals(r.ItemArray[43]) ? "" : (System.String)r.ItemArray[43];
                tmp.chk2 = System.DBNull.Value.Equals(r.ItemArray[44]) ? "" : (System.String)r.ItemArray[44];
                pout.Add(tmp);
            }
            Response.Write(serializer.Serialize(pout));
        }    
    </script>
