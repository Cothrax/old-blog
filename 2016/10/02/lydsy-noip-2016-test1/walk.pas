type 
	int=longint;
	edge=record t,next:int end;
	graph=array[0..500010] of edge;
	arr=array[0..1300010] of int;
const mx=1 shl 20;inf=maxlongint shr 2;
var 
	g0,g1:graph;h0,h1,d,q:arr;
	n,m,i,j,f,t,h:int;

procedure add(var g:graph;var head:arr;f,t:int);
var sz:int;
begin
	inc(head[0]);sz:=head[0];
	g[sz].t:=t;
	g[sz].next:=head[f];head[f]:=sz;
end;

procedure dfs(v,w:int);
var i,j,x,u:int;
begin
	d[v]:=w;q[t]:=v;inc(t);
	i:=h0[v];
	while i<>0 do begin
		u:=g0[i].t;
		if d[u]=inf then dfs(u,w);
		i:=g0[i].next;
	end;
	if v>mx then exit;
	j:=v;
	while j>0 do begin
		x:=j and (-j);
		if (v<>x) and (d[v-x]=inf) then dfs(v-x,w);
		dec(j,x);
	end;
end;

procedure bfs();
var i,v,u:int;
begin
	filldword(d,sizeof(d) div 4,inf);
	h:=1;t:=2;q[h]:=mx+1;
	d[mx+1]:=0;
	while h<>t do begin
		v:=q[h];inc(h);i:=h1[v];
		while i<>0 do begin
			u:=g1[i].t;
			if d[u]=inf then dfs(u,d[v]+1);
			i:=g1[i].next;
		end;
	end;
end;

begin
	read(n,m);
	for i:=1 to n do begin
		read(j);
		add(g1,h1,i+mx,j);
		add(g0,h0,j,i+mx);
	end;
	for i:=1 to m do begin
		read(f,t);
		add(g1,h1,f+mx,t+mx);
	end;
	bfs();
	for i:=mx+1 to mx+n do
		if d[i]=inf then writeln(-1) else writeln(d[i]);
end.

{
5 2
5 4 2 3 7
1 4
2 3
}
