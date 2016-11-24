uses math;
type 
	int=longint;
	node=record l,r,w,s,cnt,rnd:int end;
const inf=maxlongint;
var
	tp:array[0..100010] of node;
	sz,rt,i,n,op,x:int;

procedure upd(k:int); //更新tp[k].s即子树规模
begin tp[k].s:=tp[tp[k].l].s+tp[tp[k].r].s+tp[k].cnt end;

procedure lturn(var k:int); //左旋
var t:int;
begin
	t:=tp[k].r;tp[k].r:=tp[t].l;tp[t].l:=k;
	tp[t].s:=tp[k].s;upd(k);k:=t;
end;

procedure rturn(var k:int); //右旋
var t:int;
begin
	t:=tp[k].l;tp[k].l:=tp[t].r;tp[t].r:=k;
	tp[t].s:=tp[k].s;upd(k);k:=t;
end;

procedure ins(var k:int;x:int); //插入
begin
	if k=0 then begin
		inc(sz);k:=sz;tp[sz].w:=x;tp[sz].cnt:=1;
		tp[k].s:=1;tp[sz].rnd:=random(inf);exit;
	end;
	if x=tp[k].w then begin inc(tp[k].cnt);upd(k) end //bug:缺upd(k)
	else if x<tp[k].w then begin
		ins(tp[k].l,x);upd(k);
		if tp[k].rnd<tp[tp[k].l].rnd then rturn(k);
	end else begin
		ins(tp[k].r,x);upd(k);
		if tp[k].rnd<tp[tp[k].r].rnd then lturn(k);
	end;
end;

procedure del(var k:int;x:int); //堆式删除
begin
	if k=0 then exit;
	if x<tp[k].w then del(tp[k].l,x)
	else if x>tp[k].w then del(tp[k].r,x)
	else begin
		if tp[k].cnt>1 then dec(tp[k].cnt)
		else if tp[k].l*tp[k].r=0 then k:=max(tp[k].l,tp[k].r)
		else if tp[tp[k].l].rnd<tp[tp[k].r].rnd then
			begin lturn(k);del(tp[k].l,x) end
		else begin rturn(k);del(tp[k].r,x) end;
	end;
	if k<>0 then upd(k);
end;

function low(k,x:int):int; //查询比x小的数的个数
begin
	if k=0 then exit(0)
	else if x=tp[k].w then exit(tp[tp[k].l].s)
	else if x<tp[k].w then exit(low(tp[k].l,x))
	else exit(tp[tp[k].l].s+tp[k].cnt+low(tp[k].r,x)); //考虑cnt
end;

function kth(k,x:int):int; //查询第k个树
begin
	if k=0 then exit(0)
	else if tp[tp[k].l].s+tp[k].cnt<x then
		exit(kth(tp[k].r,x-tp[tp[k].l].s-tp[k].cnt))
	else if tp[tp[k].l].s>=x then exit(kth(tp[k].l,x))
	else exit(tp[k].w);
end;

function _min(k:int):int; //查询子树k中的最小值
begin
	if k=0 then exit(inf)
	else if tp[k].l=0 then exit(tp[k].w)
	else exit(_min(tp[k].l));
end;

function _max(k:int):int; //查询子树k中的最大值
begin
	if k=0 then exit(-inf)
	else if tp[k].r=0 then exit(tp[k].w)
	else exit(_max(tp[k].r));
end;

function pvs(k,x:int):int; //求树中比x小的最大的数
var tmp:int;
begin
	tmp:=_min(tp[k].r);
	if tp[k].w>=x then exit(pvs(tp[k].l,x))
	else if tmp>=x then exit(tp[k].w)
	else exit(pvs(tp[k].r,x));
end;

function nxt(k,x:int):int; //求树中比x大的最小的数
var tmp:int;
begin
	tmp:=_max(tp[k].l);
	if tp[k].w<=x then exit(nxt(tp[k].r,x))
	else if tmp<=x then exit(tp[k].w)
	else exit(nxt(tp[k].l,x));
end;

procedure walk(k,d:int); //debug-output
var i:int;
begin
	if k=0 then exit;
	walk(tp[k].l,d+1);
	for i:=1 to d*7 do write(' ');
	writeln(tp[k].w,':',tp[k].cnt,':',tp[k].s);
	walk(tp[k].r,d+1);
end;

begin
	randomize;read(n);sz:=0;rt:=0;
	for i:=1 to n do begin
		read(op,x);
		case op of 
			1:ins(rt,x);
			2:del(rt,x);
			3:writeln(low(rt,x)+1);
			4:writeln(kth(rt,x));
			5:writeln(pvs(rt,x));
			6:writeln(nxt(rt,x));
		end;
		//walk(rt,1);
	end;
end.
