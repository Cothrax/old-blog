type 
	int=longint;
	edge=record t,next:int;w:double end;
	e1=record f,t:int;w:double end;
const eps=0.0000000001;
var
	e:array[0..200010] of e1;
	g:array[0..80010] of edge;
	head,par,rnk:array[0..40010] of int;
	len:array[0..40010] of double;
	n,m,sz,i,ans:int;sum,mn:double;

procedure add(f,t:int;w:double);
begin
	inc(sz);g[sz].t:=t;g[sz].w:=w;
	g[sz].next:=head[f];head[f]:=sz;
end;

procedure swap(var a,b:e1);
var tmp:e1;
begin tmp:=a;a:=b;b:=tmp end;
procedure qsort(l,r:int);
var i,j:int;x:double;
begin
	i:=l;j:=r;x:=e[random(r-l)+l].w;
	repeat
		while e[i].w<x do inc(i);
		while e[j].w>x do dec(j);
		if i<=j then begin
			swap(e[i],e[j]);inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

function find(x:int):int;
begin
	if par[x]=x then find:=x
	else begin
		par[x]:=find(par[x]);find:=par[x];
	end;
end;
procedure union(x,y:int);
begin
	x:=find(x);y:=find(y);
	if x=y then exit;
	if rnk[x]<rnk[y] then par[x]:=y
	else begin
		par[y]:=x;
		if rnk[x]=rnk[y] then inc(rnk[x]);
	end;
end;
function same(x,y:int):boolean;
begin same:=find(x)=find(y) end;

procedure dfs(v,p:int);
var i,u,cnt:int;sq,cur:double;
begin
	len[v]:=0;sq:=0;cnt:=0;
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if u<>p then begin
			dfs(u,v);inc(cnt);
			len[v]:=len[v]+len[u]+g[i].w;
			if v=3 then writeln(len[u]+g[i].w:0:2);
			sq:=sq+sqr(len[u]+g[i].w);
		end;
		i:=g[i].next;
	end;
	if (cnt=0) or ((cnt=1) and (p=0)) then exit;
	if p<>0 then begin
		inc(cnt);
		sq:=sq+sqr(sum-len[v]);
		if v=3 then writeln(sum-len[v]:0:2);
		cur:=sq-sqr(sum)/cnt;
	end;
	if (mn+1<eps) or (cur<mn) or 
		((abs(mn-cur)<eps) and (v<ans)) then begin
		mn:=cur;ans:=v;
	end;
	if (v<20) then writeln(v,' ',len[v]:0:2,' ',cur:0:2,' ',cnt);
end;


begin
	assign(input,'mokou.in');reset(input);
	assign(output,'mokou.out');rewrite(output);
	read(n,m);
	for i:=1 to m do read(e[i].f,e[i].t,e[i].w);
	qsort(1,m);
	for i:=1 to n do begin
		par[i]:=i;rnk[i]:=0;
	end;
	sz:=0;sum:=0;
	for i:=1 to m do
		if not same(e[i].f,e[i].t) then begin
			union(e[i].f,e[i].t);
			sum:=sum+e[i].w;
			add(e[i].f,e[i].t,e[i].w);
			add(e[i].t,e[i].f,e[i].w);
		end;
	mn:=-1;
	dfs(1,0);
	write(ans);
	close(input);close(output);
end.
