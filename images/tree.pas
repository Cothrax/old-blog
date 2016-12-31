type 
	int=longint;
	edge=record t,next:int end;
	arr=array[0..100010] of int;
var 
	n,m,k,i,f0,t0:int;
	g:array[0..200010] of edge;
	head,w,top,par,dep,loc,chd,siz,seg,b:arr;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=b[random(r-l)+l];
	repeat
		while b[i]<x do inc(i);
		while b[j]>x do dec(j);
		if i<=j then begin
			swap(b[i],b[j]);inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if b<j then qsort(b,j);
end;

procedure sort(l,r:int);
begin
	for i:=l to r do 
end;

procedure add(f,t:int);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].t:=t;
	g[m].next:=head[f];head[f]:=m;
end;

procedure dfs1(v,p:int);
var i,u:int;
begin
	i:=head[v];
	par[v]:=p;dep[v]:=dep[p]+1;
	siz[v]:=1;chd[v]:=0;
	while i<>0 do begin
		u:=g[i].t;
		if u<>p then dfs1(u,v);
		inc(siz[v],siz[u]);
		if siz[u]>siz[chd[v]] then chd[v]:=u;
		i:=g[i].next;
	end;	
end;

procedure dfs2(v:int);
var i,u,p:int;
begin
	i:=head[v];p:=par[v];
	if v=chd[p] then top[v]:=top[p] else top[v]:=v;
	inc(k);seg[k]:=v;loc[v]:=k;
	if chd[v]<>0 then dfs2(chd[v],v);
	while i<>0 do begin
		u:=g[i].t;
		if (u<>p) and (u<>chd[v]) then dfs2(u,v);
		i:=g[i].next;
	end;
end;

begin
	read(n,m);
	for i:=1 to n do read(w[i]);
	for i:=1 to n-1 do begin
		read(f0,t0);
		add(f0,t0);add(t0,f0);
	end;
	chd[0]:=0;dep[0]:=0;k:=0;
	dfs1(1,0);dfs2(1);
	for i:=1 to m do begin
		
	
	end;
end.
