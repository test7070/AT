<%@ Page Language="C#" Debug="true"%>
    <script language="c#" runat="server">   
        
        public class ParaOut
        {
            public List<Item> car = new System.Collections.Generic.List<Item>();
            public List<Item2> yard = new System.Collections.Generic.List<Item2>();
        }
        public class Item
        {
            public int sel,seq;
            public string carno,cardno,datea,status,cust,addr,containerno,ordeaccy,ordeno,ordenoq,stype;
        }
        public class Item2
        {
            public int sel, seq;
            public string yardno, yard, cardno, cust, containerno, stype, status, ordeaccy, ordeno, ordenoq, addr;
        }
        public void Page_Load()
        {
            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            //連接字串      
            string DCConnectionString = "Data Source=127.0.0.1,1799;Persist Security Info=True;User ID=sa;Password=artsql963;Database=DC";

            // action: car、card、yard
            //string action = Request.QueryString["action"];
            //抓資料
            System.Data.DataTable dtCar = new System.Data.DataTable();
            System.Data.DataTable dtYard = new System.Data.DataTable();
            
            using (System.Data.SqlClient.SqlConnection connSource = new System.Data.SqlClient.SqlConnection(DCConnectionString ))
            {
                System.Data.SqlClient.SqlDataAdapter adapter = new System.Data.SqlClient.SqlDataAdapter();
                connSource.Open();
                string queryString = @"declare @tmp table(
		sel int identity(1,1)
        ,seq int
		,carno nvarchar(20)
		,cardno nvarchar(20)
		,datea nvarchar(20)
		,[status] nvarchar(20)
		,cust nvarchar(max)
		,addr nvarchar(max)
		,containerno nvarchar(20)
		,ordeaccy nvarchar(10)
		,ordeno nvarchar(20)
		,ordenoq nvarchar(10)
		,stype nvarchar(20)
	)
	insert into @tmp(carno)
	select carno1 from tranvcce where len(ISNULL(carno1,''))>0 and LEFT(carno1,1) like '[0-9,A-Z]' group by carno1
	union
	select carno2 from tranvcce where len(ISNULL(carno2,''))>0 and LEFT(carno2,1) like '[0-9,A-Z]' group by carno2
	union
	select carno3 from tranvcce where len(ISNULL(carno3,''))>0 and LEFT(carno3,1) like '[0-9,A-Z]' group by carno3
	union
	select carno4 from tranvcce where len(ISNULL(carno4,''))>0 and LEFT(carno4,1) like '[0-9,A-Z]' group by carno4
	union
	select carno5 from tranvcce where len(ISNULL(carno5,''))>0 and LEFT(carno5,1) like '[0-9,A-Z]' group by carno5
	union
	select carno6 from tranvcce where len(ISNULL(carno6,''))>0 and LEFT(carno6,1) like '[0-9,A-Z]' group by carno6
	union
	select carno7 from tranvcce where len(ISNULL(carno7,''))>0 and LEFT(carno7,1) like '[0-9,A-Z]' group by carno7
	union
	select carno8 from tranvcce where len(ISNULL(carno8,''))>0 and LEFT(carno8,1) like '[0-9,A-Z]' group by carno8

    delete @tmp
	from @tmp a
	left join car2 b on a.carno=b.carno
	where b.noa is null

	declare @carno nvarchar(20)
	declare @cardno nvarchar(20)
	declare @seq int
	declare @date nvarchar(20)
	declare @status nvarchar(20)
	declare @tmpseq int
	declare @tmpdate nvarchar(20)
	declare @tmpcardno nvarchar(20)
	
	declare cursor_table cursor for
	select carno from @tmp
	open cursor_table
	fetch next from cursor_table
	into @carno
	while(@@FETCH_STATUS <> -1)
	begin
		select @seq=-1,@date='',@status='',@cardno=''
		
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date4,@tmpcardno=cardno4 from tranvcce where carno4=@carno order by date4 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='交',@cardno=@tmpcardno
		end
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date8,@tmpcardno=cardno8 from tranvcce where carno8=@carno order by date8 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='轉收',@cardno=@tmpcardno
		end
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date3,@tmpcardno=cardno3 from tranvcce where carno3=@carno order by date3 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='收',@cardno=@tmpcardno
		end
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date7,@tmpcardno=cardno7 from tranvcce where carno7=@carno order by date7 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='移收',@cardno=@tmpcardno
		end
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date6,@tmpcardno=cardno6 from tranvcce where carno6=@carno order by date6 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='移送',@cardno=@tmpcardno
		end
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date2,@tmpcardno=cardno2 from tranvcce where carno2=@carno order by date2 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='送',@cardno=@tmpcardno
		end
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date5,@tmpcardno=cardno5 from tranvcce where carno5=@carno order by date5 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='轉送',@cardno=@tmpcardno
		end	
		select @tmpseq=-1, @tmpdate='', @tmpcardno=''
		select top 1 @tmpseq=seq,@tmpdate=date1,@tmpcardno=cardno1 from tranvcce where carno1=@carno order by date1 desc,edittime desc
		if @tmpdate>@date
		begin
			select @seq=@tmpseq,@date=@tmpdate,@status='領',@cardno=@tmpcardno
		end	
			
		update @tmp set seq=@seq,datea=@date,[status]=@status,cardno=@cardno where carno=@carno

		fetch next from cursor_table
		into @carno
	end
	close cursor_table
	deallocate cursor_table
	
	update @tmp set cust=b.cust,addr=b.straddr,containerno=b.containerno1
		,ordeaccy=b.ordeaccy,ordeno=b.ordeno,ordenoq=b.ordenoq,stype=b.stype
	from @tmp a
	left join tranvcce b on a.seq=b.seq
	where a.seq!=-1
	
	--太久的不顯示
	delete @tmp where DATEDIFF(DD,GETDATE(),dbo.ChineseEraName2AD(datea))<-31
	
	select * from @tmp where seq!=-1";
                System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(queryString, connSource);
                adapter.SelectCommand = cmd;
                adapter.Fill(dtCar);

                //YARD
                queryString = @"declare @carno1 nvarchar(20)
	declare @carno2 nvarchar(20)
	declare @carno3 nvarchar(20)
	declare @carno4 nvarchar(20)
	declare @carno5 nvarchar(20)
	declare @carno6 nvarchar(20)
	declare @carno7 nvarchar(20)
	declare @carno8 nvarchar(20)
	
	declare @cardno1 nvarchar(20)
	declare @cardno2 nvarchar(20)
	declare @cardno3 nvarchar(20)
	declare @cardno4 nvarchar(20)
	declare @cardno5 nvarchar(20)
	declare @cardno6 nvarchar(20)
	declare @cardno7 nvarchar(20)
	declare @cardno8 nvarchar(20)
	
	declare @date1 nvarchar(10)
	declare @date2 nvarchar(10)
	declare @date3 nvarchar(10)
	declare @date4 nvarchar(10)
	declare @date5 nvarchar(10)
	declare @date6 nvarchar(10)
	declare @date7 nvarchar(10)
	declare @date8 nvarchar(10)
	
	declare @yard1 nvarchar(20)
	declare @yard2 nvarchar(20)
	declare @yard3 nvarchar(20)
	declare @yard4 nvarchar(20)
	declare @yard5 nvarchar(20)
	declare @yard6 nvarchar(20)
	
	declare @yardno nvarchar(20)
	declare @yard nvarchar(20)
	declare @seq int
	
	declare @tmpa table(
		sel int identity(1,1)
		,yardno nvarchar(20)
		,yard nvarchar(20)
	)
	insert into @tmpa(yardno,yard)
	select noa,memo from tranyard

	declare @tmpb table(
		sel int identity(1,1)
		,yardno nvarchar(20)
		,yard nvarchar(20)
		,cardno nvarchar(20)
		,seq int
		,[status] nvarchar(20)
	)
	declare @tmpc table(
		sel int identity(1,1)
		,seq int
		,yardno nvarchar(20)
		,yard nvarchar(20)
		,cardno nvarchar(max)
		,cust nvarchar(max)
		,containerno nvarchar(max)
		,stype nvarchar(max)
		,[status] nvarchar(max)
		,ordeaccy nvarchar(max)
		,ordeno nvarchar(max)
		,ordenoq nvarchar(max)
        ,addr nvarchar(max)
	)
	
	declare @cardno nvarchar(max)
	declare @cust nvarchar(max)
	declare @containerno nvarchar(max)
	declare @stype nvarchar(max)
	declare @status nvarchar(max)
	declare @ordeno nvarchar(max)
	
	
	declare cursor_table cursor for
	select yardno,yard from @tmpa
	open cursor_table
	fetch next from cursor_table
	into @yardno,@yard
	while(@@FETCH_STATUS <> -1)
	begin
		--已交代表結束
		--領、轉送、移收、收 代表入車場	
		declare cursor_table2 cursor for
		select seq,carno1,carno2,carno3,carno4,carno5,carno6,carno7,carno8 
			,date1,date2,date3,date4,date5,date6,date7,date8
			,cardno1,cardno2,cardno3,cardno4,cardno5,cardno6,cardno7,cardno8
			,yard1,yard2,yard3,yard4,yard5,yard6
		from tranvcce
		where (yard1=@yardno or yard2=@yardno or yard3=@yardno or yard4=@yardno or yard5=@yardno or yard6=@yardno)
			and len(isnull(carno4,''))=0
		open cursor_table2
		fetch next from cursor_table2
		into @seq,@carno1,@carno2,@carno3,@carno4,@carno5,@carno6,@carno7,@carno8 
			,@date1,@date2,@date3,@date4,@date5,@date6,@date7,@date8
			,@cardno1,@cardno2,@cardno3,@cardno4,@cardno5,@cardno6,@cardno7,@cardno8
			,@yard1,@yard2,@yard3,@yard4,@yard5,@yard6
		while(@@FETCH_STATUS <> -1)
		begin
			--轉收
			--收
			if LEN(@carno3)>0
			begin
				if LEN(@cardno3)>0 and @yard3=@yardno
					insert into @tmpb(yardno,yard,cardno,seq,[status])
					values(@yardno,@yard,@cardno3,@seq,'收')
			end
			--移收
			else if LEN(@carno7)>0
			begin
				if LEN(@cardno7)>0 and @yard6=@yardno
					insert into @tmpb(yardno,yard,cardno,seq,[status])
					values(@yardno,@yard,@cardno7,@seq,'移收')
			end
			--移送
			--送
			--轉送
			else if LEN(@carno5)>0
			begin
				if LEN(@cardno5)>0 and @yard5=@yardno
					insert into @tmpb(yardno,yard,cardno,seq,[status])
					values(@yardno,@yard,@cardno5,@seq,'轉送')
			end
			--領
			else if LEN(@carno1)>0
			begin
				if LEN(@cardno1)>0 and @yard1=@yardno
					insert into @tmpb(yardno,yard,cardno,seq,[status])
					values(@yardno,@yard,@cardno1,@seq,'領')
			end

			fetch next from cursor_table2
			into @seq,@carno1,@carno2,@carno3,@carno4,@carno5,@carno6,@carno7,@carno8 
			,@date1,@date2,@date3,@date4,@date5,@date6,@date7,@date8
			,@cardno1,@cardno2,@cardno3,@cardno4,@cardno5,@cardno6,@cardno7,@cardno8
			,@yard1,@yard2,@yard3,@yard4,@yard5,@yard6
		end
		close cursor_table2
		deallocate cursor_table2
		
		fetch next from cursor_table
		into @yardno,@yard
	end
	close cursor_table
	deallocate cursor_table
	
	insert into @tmpc(seq,yardno,yard,cardno,cust,containerno,stype,[status],ordeaccy,ordeno,ordenoq,addr)
	select a.seq,a.yardno,a.yard,a.cardno,b.cust,b.containerno1,b.stype,a.[status],b.ordeaccy,b.ordeno,b.ordenoq,b.straddr
	from @tmpb a
	left join tranvcce b on a.seq=b.seq
	where b.seq is not null
	
	select * from @tmpc order by yardno,sel";
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
                tmp.sel = System.DBNull.Value.Equals(r.ItemArray[0]) ? 0 : (System.Int32)r.ItemArray[0];
                tmp.seq = System.DBNull.Value.Equals(r.ItemArray[1]) ? 0 : (System.Int32)r.ItemArray[1];
                tmp.carno = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];
                tmp.cardno = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                tmp.datea = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                tmp.status = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                tmp.cust = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                tmp.addr = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];
                tmp.containerno = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                tmp.ordeaccy = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                tmp.ordeno = System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10];
                tmp.ordenoq = System.DBNull.Value.Equals(r.ItemArray[11]) ? "" : (System.String)r.ItemArray[11];
                tmp.stype = System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12];
                pout.car.Add(tmp);
            }
            Item2 tmp2;
            foreach (System.Data.DataRow r in dtYard.Rows)
            {
                tmp2 = new Item2();
                tmp2.sel = System.DBNull.Value.Equals(r.ItemArray[0]) ? 0 : (System.Int32)r.ItemArray[0];
                tmp2.seq = System.DBNull.Value.Equals(r.ItemArray[1]) ? 0 : (System.Int32)r.ItemArray[1];
                tmp2.yardno = System.DBNull.Value.Equals(r.ItemArray[2]) ? "" : (System.String)r.ItemArray[2];

                tmp2.yard = System.DBNull.Value.Equals(r.ItemArray[3]) ? "" : (System.String)r.ItemArray[3];
                tmp2.cardno = System.DBNull.Value.Equals(r.ItemArray[4]) ? "" : (System.String)r.ItemArray[4];
                tmp2.cust = System.DBNull.Value.Equals(r.ItemArray[5]) ? "" : (System.String)r.ItemArray[5];
                tmp2.containerno = System.DBNull.Value.Equals(r.ItemArray[6]) ? "" : (System.String)r.ItemArray[6];
                tmp2.stype = System.DBNull.Value.Equals(r.ItemArray[7]) ? "" : (System.String)r.ItemArray[7];
                tmp2.status = System.DBNull.Value.Equals(r.ItemArray[8]) ? "" : (System.String)r.ItemArray[8];
                tmp2.ordeaccy = System.DBNull.Value.Equals(r.ItemArray[9]) ? "" : (System.String)r.ItemArray[9];
                tmp2.ordeno = System.DBNull.Value.Equals(r.ItemArray[10]) ? "" : (System.String)r.ItemArray[10];
                tmp2.ordenoq = System.DBNull.Value.Equals(r.ItemArray[11]) ? "" : (System.String)r.ItemArray[11];
                tmp2.addr = System.DBNull.Value.Equals(r.ItemArray[12]) ? "" : (System.String)r.ItemArray[12];
                pout.yard.Add(tmp2);
            }
            
            Response.Write(serializer.Serialize(pout));
        }    
    </script>
