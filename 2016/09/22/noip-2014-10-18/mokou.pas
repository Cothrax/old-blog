type 
	int=longint;
	edge=record t,next:int;w:double end;
	e1=record f,t:int;w:double end;
const eps=0.0000000001;
var
	e:array[0..200010] of e1;
	g:array[0..80010] of edge;
	head,par,rnk,cnt:array[0..40010] of int;
	len:array[0..40010] of double;
	n,m,sz,i,ans:int;tmp,sum,mn:double;

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

function dfs(v,p:int):double;
var i,u:int;
begin
	len[v]:=0;cnt[v]:=0;
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;inc(cnt[v]);
		if u<>p then len[v]:=len[v]+dfs(u,v)+g[i].w;
		i:=g[i].next;
	end;
	dfs:=len[v];
end;

function cal(v:int):double;
var i,u:int;avg:double;
begin
	if cnt[v]=1 then exit(-1);
	avg:=sum/cnt[v];cal:=0;
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if len[u]<len[v] then
			cal:=cal+sqr(len[u]+g[i].w-avg);
		i:=g[i].next;
	end;
	if v<>1 then begin
		cal:=cal+sqr(sum-len[v]-avg);
	end;
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
	mn:=-1;dfs(1,0);
	for i:=1 to n do begin
		tmp:=cal(i);if tmp+1<eps then continue;
		if (mn=-1) or (tmp<mn) then begin
			mn:=tmp;ans:=i;
		end;
	end;
	write(ans);
	close(input);close(output);
end.
