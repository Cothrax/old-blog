type 
	int=longint;
	edge=record f,t,w:int end;
var 
	g:array[0..50010] of edge;
	par:array[0..20010] of int;
	n,m,r,i,t:int;ans:int64;

procedure qsort(l,r:int);
var i,j,x:int;tmp:edge;
begin
	i:=l;j:=r;x:=g[random(r-l)+l].w;
	repeat
		while g[i].w>x do inc(i);
		while g[j].w<x do dec(j);
		if i<=j then begin
			tmp:=g[i];g[i]:=g[j];g[j]:=tmp;
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

function find(x:int):int;
begin
	if par[x]=x then find:=x
	else begin
		par[x]:=find(par[x]);
		find:=par[x];
	end;
end;

procedure union(x,y:int);
begin x:=find(x);y:=find(y);par[x]:=y end;

function same(x,y:int):boolean;
begin same:=find(x)=find(y) end;

begin
	read(t);
	repeat
		
		read(n,m,r);
		for i:=1 to r do begin
			read(g[i].f,g[i].t,g[i].w);
			inc(g[i].t,n);
		end;
		for i:=0 to n+m-1 do par[i]:=i;
		qsort(1,r);ans:=0;
		for i:=1 to r do
			if not same(g[i].f,g[i].t) then begin
				union(g[i].f,g[i].t);
				inc(ans,g[i].w);
			end;
		writeln((n+m)*10000-ans);
		dec(t);
	until t=0;
end.
{
最大生成树
注意：
1. 编号
2. 最小生成树不行
}

{
2
5 5 8
4 3 6831
1 3 4583
0 0 6592
0 1 3063
3 3 4975
1 3 2049
4 2 2104
2 2 781

5 5 10
2 4 9820
3 2 6236
3 1 8864
2 4 8326
2 0 5156
2 0 1463
4 1 2439
0 4 4373
3 4 8889
2 4 3133
}
