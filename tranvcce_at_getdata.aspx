<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">
        //tranvcce_at_getcount 和 tranvcce_at_getdata 要一起改
        //tranvcce_at_getdata 和 tranvcce_at_update 要一起改
        public class ParaIn
        {
            public int nstr;
            public int nend;
            public string stype;
            public string cust;
            public string so;
            public string containerno;
        	public string ordeno;
            public string bdate;
            public string edate;
            public string relay;
            public string finish;
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
            public bool issend1, issend2, issend3, issend4;
            public bool isassign;
            public float mount;
            public string seal1,seal2;
            public string yard1,yard2,yard3,yard4;
            public string vr;
            public string date1,date2,date3,date4;
            public string carno5,cardno5,date5;
            public string carno6,cardno6,date6;
            public string carno7,cardno7,date7;
            public string carno8,cardno8,date8;
            public bool isrelay;
            public string yard5,yard6;
            public bool isfinish;
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
                string queryString = @"
                set @edate = case when LEN(@edate)=0 then CHAR(255) else @edate end
                select recno,seq,ordeaccy,ordeno,ordenoq,datea,custno,cust,straddrno,straddr,vocc,casetype
	                ,containerno1,containerno2
	                ,carno1,cardno1,msg1
	                ,carno2,cardno2,msg2
	                ,carno3,cardno3,msg3
	                ,carno4,cardno4,msg4
	                ,memo,stype,ucr,por,pod,product
                    ,cast(0 as bit),cast(0 as bit),cast(0 as bit),cast(0 as bit)
                    ,isassign,mount,seal1,seal2
                    ,yard1,yard2,yard3,yard4
                    ,vr
                    ,date1,date2,date3,date4
                    ,carno5,cardno5,date5
                    ,carno6,cardno6,date6
                    ,carno7,cardno7,date7
                    ,carno8,cardno8,date8
                    ,isrelay,yard5,yard6,isfinish
                from(
	                select ROW_NUMBER()over(order by ordeaccy desc,ordeno desc,ordenoq) recno
	                ,*
	                from tranvcce
	                where ISNULL(isdel,0)=0
	                and (len(@stype)=0 or isnull(stype,'')=@stype)
	                and (len(@cust)=0 or charindex(@cust,cust)>0)
	                and (len(@so)=0 or charindex(@so,ucr)>0 or charindex(@so,vr)>0)
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
	                and ((@finish='0' and isnull(isfinish,0)=0) or (@finish='1' and isnull(isfinish,0)=1))
                )a
                where a.recno between @nstr and @nend
                
                order by a.recno";
                
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                cmd.Parameters.AddWithValue("@nstr", itemIn.nstr);
                cmd.Parameters.AddWithValue("@nend", itemIn.nend);
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
                tmp.issend1 = System.DBNull.Value.Equals(r.ItemArray[32]) ? false : (System.Boolean)r.ItemArray[32];
                tmp.issend2 = System.DBNull.Value.Equals(r.ItemArray[33]) ? false : (System.Boolean)r.ItemArray[33];
                tmp.issend3 = System.DBNull.Value.Equals(r.ItemArray[34]) ? false : (System.Boolean)r.ItemArray[34];
                tmp.issend4 = System.DBNull.Value.Equals(r.ItemArray[35]) ? false : (System.Boolean)r.ItemArray[35];
                tmp.isassign = System.DBNull.Value.Equals(r.ItemArray[36]) ? false : (System.Boolean)r.ItemArray[36];
                tmp.mount = System.DBNull.Value.Equals(r.ItemArray[37]) ? 0 : (float)(System.Double)r.ItemArray[37];
                tmp.seal1 = System.DBNull.Value.Equals(r.ItemArray[38]) ? "" : (System.String)r.ItemArray[38];
                tmp.seal2 = System.DBNull.Value.Equals(r.ItemArray[39]) ? "" : (System.String)r.ItemArray[39];
                tmp.yard1 = System.DBNull.Value.Equals(r.ItemArray[40]) ? "" : (System.String)r.ItemArray[40];
                tmp.yard2 = System.DBNull.Value.Equals(r.ItemArray[41]) ? "" : (System.String)r.ItemArray[41];
                tmp.yard3 = System.DBNull.Value.Equals(r.ItemArray[42]) ? "" : (System.String)r.ItemArray[42];
                tmp.yard4 = System.DBNull.Value.Equals(r.ItemArray[43]) ? "" : (System.String)r.ItemArray[43];
                tmp.vr = System.DBNull.Value.Equals(r.ItemArray[44]) ? "" : (System.String)r.ItemArray[44];
                tmp.date1 = System.DBNull.Value.Equals(r.ItemArray[45]) ? "" : (System.String)r.ItemArray[45];
                tmp.date2 = System.DBNull.Value.Equals(r.ItemArray[46]) ? "" : (System.String)r.ItemArray[46];
                tmp.date3 = System.DBNull.Value.Equals(r.ItemArray[47]) ? "" : (System.String)r.ItemArray[47];
                tmp.date4 = System.DBNull.Value.Equals(r.ItemArray[48]) ? "" : (System.String)r.ItemArray[48];
                
                tmp.carno5 = System.DBNull.Value.Equals(r.ItemArray[49]) ? "" : (System.String)r.ItemArray[49];
                tmp.cardno5 = System.DBNull.Value.Equals(r.ItemArray[50]) ? "" : (System.String)r.ItemArray[50];
                tmp.date5 = System.DBNull.Value.Equals(r.ItemArray[51]) ? "" : (System.String)r.ItemArray[51];
                tmp.carno6 = System.DBNull.Value.Equals(r.ItemArray[52]) ? "" : (System.String)r.ItemArray[52];
                tmp.cardno6 = System.DBNull.Value.Equals(r.ItemArray[53]) ? "" : (System.String)r.ItemArray[53];
                tmp.date6 = System.DBNull.Value.Equals(r.ItemArray[54]) ? "" : (System.String)r.ItemArray[54];
                tmp.carno7 = System.DBNull.Value.Equals(r.ItemArray[55]) ? "" : (System.String)r.ItemArray[55];
                tmp.cardno7 = System.DBNull.Value.Equals(r.ItemArray[56]) ? "" : (System.String)r.ItemArray[56];
                tmp.date7 = System.DBNull.Value.Equals(r.ItemArray[57]) ? "" : (System.String)r.ItemArray[57];
                tmp.carno8 = System.DBNull.Value.Equals(r.ItemArray[58]) ? "" : (System.String)r.ItemArray[58];
                tmp.cardno8 = System.DBNull.Value.Equals(r.ItemArray[59]) ? "" : (System.String)r.ItemArray[59];
                tmp.date8 = System.DBNull.Value.Equals(r.ItemArray[60]) ? "" : (System.String)r.ItemArray[60];
                tmp.isrelay = System.DBNull.Value.Equals(r.ItemArray[61]) ? false : (System.Boolean)r.ItemArray[61];
                tmp.yard5 = System.DBNull.Value.Equals(r.ItemArray[62]) ? "" : (System.String)r.ItemArray[62];
                tmp.yard6 = System.DBNull.Value.Equals(r.ItemArray[63]) ? "" : (System.String)r.ItemArray[63];
                tmp.isfinish = System.DBNull.Value.Equals(r.ItemArray[64]) ? false : (System.Boolean)r.ItemArray[64];
                pout.Add(tmp);
            }
            Response.Write(serializer.Serialize(pout));
        }    
    </script>
