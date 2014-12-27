<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">
        
        public class ParaIn
        {
            public int nstr;
            public int nend;
            public string stype;
            public string bdate;
            public string edate;
        }
        public class ParaOut
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

            //連接字串      
            string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=DC";
            //抓資料
            System.Data.DataTable tranvcce = new System.Data.DataTable();
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString ))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"select recno,seq,ordeaccy,ordeno,ordenoq,datea,custno,cust,straddrno,straddr,vocc,casetype
	                ,containerno1,containerno2
	                ,carno1,cardno1,msg1
	                ,carno2,cardno2,msg2
	                ,carno3,cardno3,msg3
	                ,carno4,cardno4,msg4
	                ,memo,stype,ucr,por,pod,product
                from(
	                select ROW_NUMBER()over(order by ordeaccy desc,ordeno desc,ordenoq) recno
	                ,*
	                from tranvcce
	                where ISNULL(isdel,0)=0
                )a
                where a.recno between @nstr and @nend
                and (len(@stype)=0 or isnull(a.stype,'')=@stype)
                and (len(@bdate)=0 or isnull(a.datea,'')>=@bdate)
                and (len(@edate)=0 or isnull(a.datea,'')<=@edate)
                order by a.recno";
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@nstr", itemIn.nstr);
                cmd.Parameters.AddWithValue("@nend", itemIn.nend);
                cmd.Parameters.AddWithValue("@stype", itemIn.stype);
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
                tmp.isdel = false;
                tmp.recno = (System.Int64)r.ItemArray[0];
                tmp.seq = (System.Int32)r.ItemArray[1];
                tmp.ordeaccy = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                tmp.ordeno = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                tmp.ordenoq = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                tmp.datea = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                tmp.custno = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                tmp.cust = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];
                tmp.straddrno = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                tmp.straddr = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                tmp.vocc = System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10];
                tmp.casetype = System.DBNull.Value.Equals(r.ItemArray[11]) ? "" : (System.String)r.ItemArray[11];
                tmp.containerno1 = System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12];
                tmp.containerno2 = System.DBNull.Value.Equals(r.ItemArray[13]) ? "" : (System.String)r.ItemArray[13];
                tmp.carno1 = System.DBNull.Value.Equals(r.ItemArray[14]) ? "" : (System.String)r.ItemArray[14];
                tmp.cardno1 = System.DBNull.Value.Equals(r.ItemArray[15]) ? "" : (System.String)r.ItemArray[15];
                tmp.msg1 = System.DBNull.Value.Equals(r.ItemArray[16]) ? "" : (System.String)r.ItemArray[16];
                tmp.carno2 = System.DBNull.Value.Equals(r.ItemArray[17]) ? "" : (System.String)r.ItemArray[17];
                tmp.cardno2 = System.DBNull.Value.Equals(r.ItemArray[18]) ? "" : (System.String)r.ItemArray[18];
                tmp.msg2 = System.DBNull.Value.Equals(r.ItemArray[19]) ? "" : (System.String)r.ItemArray[19];
                tmp.carno3 = System.DBNull.Value.Equals(r.ItemArray[20]) ? "" : (System.String)r.ItemArray[20];
                tmp.cardno3 = System.DBNull.Value.Equals(r.ItemArray[21]) ? "" : (System.String)r.ItemArray[21];
                tmp.msg3 = System.DBNull.Value.Equals(r.ItemArray[22]) ? "" : (System.String)r.ItemArray[22];
                tmp.carno4 = System.DBNull.Value.Equals(r.ItemArray[23]) ? "" : (System.String)r.ItemArray[23];
                tmp.cardno4 = System.DBNull.Value.Equals(r.ItemArray[24]) ? "" : (System.String)r.ItemArray[24];
                tmp.msg4 = System.DBNull.Value.Equals(r.ItemArray[25]) ? "" : (System.String)r.ItemArray[25];
                tmp.memo = System.DBNull.Value.Equals(r.ItemArray[26]) ? "" : (System.String)r.ItemArray[26];
                tmp.stype = System.DBNull.Value.Equals(r.ItemArray[27]) ? "" : (System.String)r.ItemArray[27];
                tmp.ucr = System.DBNull.Value.Equals(r.ItemArray[28]) ? "" : (System.String)r.ItemArray[28];
                tmp.por = System.DBNull.Value.Equals(r.ItemArray[29]) ? "" : (System.String)r.ItemArray[29];
                tmp.pod = System.DBNull.Value.Equals(r.ItemArray[30]) ? "" : (System.String)r.ItemArray[30];
                tmp.product = System.DBNull.Value.Equals(r.ItemArray[31]) ? "" : (System.String)r.ItemArray[31];
                pout.Add(tmp);
            }
            Response.Write(serializer.Serialize(pout));
        }    
    </script>
