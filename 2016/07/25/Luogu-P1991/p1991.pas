uses math;
const inf=200000;
type 
	edge=record
		f,t:longint;
		d:real;
	end;
var 
	n,p,m,i,j,count:longint;
	x,y,par,rank:array[0..510] of longint;
	g:array[0..250010] of edge;
	ans:real;
	
procedure qsort(b,e:longint);
var i,j:longint;x:real;tmp:edge;
begin
	i:=b;j:=e;x:=g[random(e-b)+b].d;
	repeat
		while g[i].d<x do inc(i);
		while g[j].d>x do dec(j);
		if i<=j then begin
			tmp:=g[i];g[i]:=g[j];g[j]:=tmp;
			inc(i);dec(j);
		end;
	until i>j;
	if i<e then qsort(i,e);
	if b<j then qsort(b,j);
end;

function find(x:longint):longint;
begin
	if par[x]=x then find:=x
	else begin
		par[x]:=find(par[x]);
		find:=par[x];
	end;
end;

procedure union(x,y:longint);
begin
	x:=find(x);y:=find(y);
	if rank[x]<rank[y] then par[x]:=y
	else begin
		par[y]:=x;
		if rank[y]=rank[x] then inc(rank[x]);
	end;
end;

function same(x,y:longint):boolean;
begin same:=(find(x)=find(y)) end;

begin
	read(p,n);
	for i:=1 to n do read(x[i],y[i]);
	m:=0;
	for i:=1 to n do
		for j:=i+1 to n do begin
			inc(m);
			g[m].f:=i;g[m].t:=j;
			g[m].d:=sqrt(sqr(x[i]-x[j])+sqr(y[i]-y[j]));
		end;
	for i:=1 to n do par[i]:=i;
	fillchar(rank,sizeof(rank),0);
	qsort(1,m);
	count:=0;ans:=0;
	for i:=1 to m do
		if not same(g[i].f,g[i].t) then begin
			union(g[i].f,g[i].t);
			ans:=max(ans,g[i].d);
			inc(count);
			if count=n-p then break;
		end;
	write(ans:0:2);
end.