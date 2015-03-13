 <%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">     
        public class ParaIn
        {
            public int seq;
            public string field, sendtime;
            public string caseno, caseno2,cardno, po,miles,receivetime;
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
                    string queryString = @"SET QUOTED_IDENTIFIER OFF declare @cmd nvarchar(max) 
                        update tranvcces
	                    set caseno=@caseno,caseno2=@caseno2,cardno=@cardno,po=@po,miles=@miles,receivetime=@receivetime
	                    where seq=@seq and field=@field and sendtime=@sendtime";

                    queryString += @"
	                    ------------------------------------------------------------------------------------------------
	                    IF OBJECT_ID('tempdb..#tranvcce_tranvcces')is not null 
	                    BEGIN
		                    drop table #tranvcce_tranvcces
	                    END
	                    create table #tranvcce_tranvcces(
		                    accy nvarchar(20),
		                    noa nvarchar(20),
		                    noq nvarchar(10),
		                    datea nvarchar(10),
		                    trandate nvarchar(10),
		                    custno nvarchar(20),
		                    comp nvarchar(50),
		                    nick nvarchar(20),
		                    straddrno nvarchar(20),
		                    straddr nvarchar(50),
		                    cstype nvarchar(2),
		
		                    carno nvarchar(20),
		                    cardno nvarchar(20),
		                    driverno nvarchar(20),
		                    driver nvarchar(20),
		                    productno nvarchar(20),
		                    product nvarchar(50),
		
		                    carteamno nvarchar(20),
		                    calctype nvarchar(20),
		
		                    inmount float,
		                    price float,
		                    total float,
		
		                    outmount float,
		                    price2 float,
		                    price3 float,
		                    discount float,
		                    total2 float,
		
		                    caseno nvarchar(20),
		                    caseno2 nvarchar(20),
		                    casetype nvarchar(20),
		                    miles float
	                    )
	                    ------------------------------------------------------------------------------------------------
	                    declare @t_carno nvarchar(20)
	                    declare @t_date nvarchar(10)
	                    declare @t_addrno nvarchar(20)
	                    declare @t_custno nvarchar(20)
	                    declare @t_custprice float,@t_driverprice float
	                    declare @t_isoutside bit
	                    declare @t_calctype nvarchar(20)
	                    declare @t_carteamno nvarchar(20) = '01' --貨櫃
	                    declare @t_mount float
	                    declare @t_cardno nvarchar(20)
	                    declare @t_caseno nvarchar(20)
	                    declare @t_caseno2 nvarchar(20)
	                    declare @t_miles float
	
	                    --領
	                    if @field = '領'
	                    begin
		                    insert into #tranvcce_tranvcces(datea,trandate,custno,comp,nick,straddrno,straddr
			                    ,productno,product,casetype)
		                    select a.date1,a.date1,b.custno,b.comp,b.nick,c.straddrno,c.straddr
			                    ,b.productno,b.product,a.casetype
		                    from tranvcce a
		                    left join view_tranorde b on a.ordeaccy=b.accy and a.ordeno=b.noa
		                    left join view_tranordet c on a.ordeaccy=c.accy and a.ordeno=c.noa and a.ordenoq=c.noq
		                    where a.seq = @seq
	                    end	
	                    --送
	                    if @field = '送'
	                    begin
		                    insert into #tranvcce_tranvcces(datea,trandate,custno,comp,nick,straddrno,straddr
			                    ,productno,product,casetype)
		                    select a.date2,a.date2,b.custno,b.comp,b.nick,c.straddrno,c.straddr
			                    ,b.productno,b.product,a.casetype
		                    from tranvcce a
		                    left join view_tranorde b on a.ordeaccy=b.accy and a.ordeno=b.noa
		                    left join view_tranordet c on a.ordeaccy=c.accy and a.ordeno=c.noa and a.ordenoq=c.noq
		                    where a.seq = @seq
	                    end	
	                    --收
	                    if @field = '收'
	                    begin
		                    insert into #tranvcce_tranvcces(datea,trandate,custno,comp,nick,straddrno,straddr
			                    ,productno,product,casetype)
		                    select a.date3,a.date3,b.custno,b.comp,b.nick,c.straddrno,c.straddr
			                    ,b.productno,b.product,a.casetype
		                    from tranvcce a
		                    left join view_tranorde b on a.ordeaccy=b.accy and a.ordeno=b.noa
		                    left join view_tranordet c on a.ordeaccy=c.accy and a.ordeno=c.noa and a.ordenoq=c.noq
		                    where a.seq = @seq
	                    end	
	                    --交
	                    if @field = '交'
	                    begin
		                    insert into #tranvcce_tranvcces(datea,trandate,custno,comp,nick,straddrno,straddr
			                    ,productno,product,casetype)
		                    select a.date4,a.date4,b.custno,b.comp,b.nick,c.straddrno,c.straddr
			                    ,b.productno,b.product,a.casetype
		                    from tranvcce a
		                    left join view_tranorde b on a.ordeaccy=b.accy and a.ordeno=b.noa
		                    left join view_tranordet c on a.ordeaccy=c.accy and a.ordeno=c.noa and a.ordenoq=c.noq
		                    where a.seq = @seq
	                    end
	                    --移1
	                    if @field = '移1'
	                    begin
		                    insert into #tranvcce_tranvcces(datea,trandate,custno,comp,nick,straddrno,straddr
			                    ,productno,product,casetype)
		                    select a.date5,a.date5,b.custno,b.comp,b.nick,c.straddrno,c.straddr
			                    ,b.productno,b.product,a.casetype
		                    from tranvcce a
		                    left join view_tranorde b on a.ordeaccy=b.accy and a.ordeno=b.noa
		                    left join view_tranordet c on a.ordeaccy=c.accy and a.ordeno=c.noa and a.ordenoq=c.noq
		                    where a.seq = @seq
	                    end
	                    --移2
	                    if @field = '移2'
	                    begin
		                    insert into #tranvcce_tranvcces(datea,trandate,custno,comp,nick,straddrno,straddr
			                    ,productno,product,casetype)
		                    select a.date6,a.date6,b.custno,b.comp,b.nick,c.straddrno,c.straddr
			                    ,b.productno,b.product,a.casetype
		                    from tranvcce a
		                    left join view_tranorde b on a.ordeaccy=b.accy and a.ordeno=b.noa
		                    left join view_tranordet c on a.ordeaccy=c.accy and a.ordeno=c.noa and a.ordenoq=c.noq
		                    where a.seq = @seq
	                    end
		
	                    update #tranvcce_tranvcces set carno=b.carid,cardno=b.cardno,driverno=b.driverno,driver=b.driver
	                    from #tranvcce_tranvcces a
	                    outer apply (select * from tranvcces where seq=@seq and field=@field and sendtime=@sendtime) b
	                    ---------------------------------------------------------------------------
	                    select @t_carno='',@t_date='',@t_addrno='',@t_custno=''
		                    ,@t_custprice=null,@t_driverprice=null,@t_isoutside=1,@t_calctype = '',@t_mount=0
		                    ,@t_cardno='',@t_caseno='',@t_caseno2='',@t_miles=0
	
	                    select @t_date=trandate,@t_addrno=straddrno,@t_custno=custno from #tranvcce_tranvcces
	                    select top 1 @t_custprice = custprice,@t_driverprice=driverprice 
	                    from addrs where noa=@t_addrno and datea<=@t_date and custno=@t_custno order by datea
	                    --判斷公司車、外車
	                    select @t_isoutside=case when cartype='2' then 0 else 1 end from car2 where carno=@t_carno
	                    select top 1 @t_calctype=noa+noq from calctypes where isnull(isoutside,0)=@t_isoutside
	                    --櫃數
	                    select @t_mount = case when len(ISNULL(caseno,''))>0 then 1 else 0 end+case when len(ISNULL(caseno2,''))>0 then 1 else 0 end 
		                    ,@t_cardno = cardno,@t_caseno=caseno,@t_caseno2=caseno2,@t_miles=miles
	                    from tranvcces where seq=@seq and field=@field and sendtime=@sendtime
	
	                    --應收先算在領櫃
	                    if @field != '領'
	                    begin
		                    select @t_custprice = 0
	                    end
	                    update #tranvcce_tranvcces set price=@t_custprice
		                    ,price2 = case when @t_isoutside=0 then @t_driverprice else 0 end
		                    ,price3 = case when @t_isoutside=0 then 0 else @t_driverprice end
		                    ,discount=1
		                    ,inmount = @t_mount
		                    ,outmount = @t_mount
		                    ,calctype = @t_calctype
		                    ,carteamno = @t_carteamno
		                    ,cardno=@t_cardno
		                    ,caseno=@t_caseno
		                    ,caseno2=@t_caseno2
		                    ,miles=@t_miles
		                    ,cstype=left(@field,1)
	                    from #tranvcce_tranvcces a
	                    update #tranvcce_tranvcces set total = ROUND(price*inmount,0)
		                    ,total2 = ROUND((ISNULL(price2,0)+isnull(price3,0))*outmount,0)
	                    ------------------------------------------------------------------------------------------
	                    --取得TRANS編號
	                    declare @trankey nvarchar(10)= 'BA'
	                    declare @string nvarchar(max) = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'
	                    declare @n int
	
	                    declare @t_noa nvarchar(20) = null
	                    declare @t_noq nvarchar(10) = null
	
	                    select top 1 @t_noa = noa from view_trans 
	                    where noa like @trankey+REPLACE(@t_date,'/','')+'[0-9,A-Z][0-9][0-9]' order by noa desc
	                    if @t_noa is null
	                    begin
		                    set @t_noa = @trankey+REPLACE(@t_date,'/','')+'001'
	                    end
	                    else
	                    begin
		                    set @n =  cast((charindex(left(RIGHT(@t_noa,3),1),@string)-1)*100+cast(RIGHT(@t_noa,2) as int)+1 as nvarchar)	
		                    set @t_noq = SUBSTRING(@string,floor(@n/100)+1,1)+right('00'+cast(@n%100 as nvarchar),2)
		                    set @t_noa = @trankey+REPLACE(@t_date,'/','')+@t_noq
	                    end
	                    update #tranvcce_tranvcces set accy=LEFT(trandate,3),noa=@t_noa,noq='001'
	
	                    select * from #tranvcce_tranvcces
	
	                    if LEN(ISNULL(@t_date,''))>0
	                    begin
		                    set @cmd =
		                    ""insert into trans""+LEFT(@t_date,3)+""(noa,noq,datea,trandate,custno,comp,nick
			                    ,straddrno,straddr,carno,cardno,driverno,driver,cstype
			                    ,uccno,product,carteamno,calctype,inmount,mount,price,total
			                    ,outmount,mount2,price2,price3,discount,total2
			                    ,caseno,caseno2,casetype,miles,po,ordeno)
		                    select noa,noq,datea,trandate,custno,comp,nick
			                    ,straddrno,straddr,carno,cardno,driverno,driver,cstype
			                    ,productno,product,carteamno,calctype,inmount,inmount,price,total
			                    ,outmount,outmount,price2,price3,discount,total2
			                    ,caseno,caseno2,casetype,miles,@po,cast(@seq as nvarchar)+'_'+@field
		                    from #tranvcce_tranvcces""
		                    execute sp_executesql @cmd,N'@seq int,@field nvarchar(20),@po nvarchar(50)',@seq=@seq,@field=@field,@po=@po
	                    end
	                    drop table #tranvcce_tranvcces";
                    System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                    cmd.Parameters.AddWithValue("@seq", itemIn.seq);
                    cmd.Parameters.AddWithValue("@field", itemIn.field);
                    cmd.Parameters.AddWithValue("@sendtime", itemIn.sendtime);
                    cmd.Parameters.AddWithValue("@caseno", itemIn.caseno);
                    cmd.Parameters.AddWithValue("@caseno2", itemIn.caseno2);
                    cmd.Parameters.AddWithValue("@cardno", itemIn.cardno);
                    cmd.Parameters.AddWithValue("@po", itemIn.po);
                    cmd.Parameters.AddWithValue("@miles", itemIn.miles);
                    cmd.Parameters.AddWithValue("@receivetime", itemIn.receivetime);
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
