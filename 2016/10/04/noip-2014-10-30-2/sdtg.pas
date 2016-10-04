uses math;
type 
	int=longint;ll=int64;
	edge=record v,next:int end;
var
	g:array[0..200010] of edge;
	par:array[0..100010,0..20] of int;
	a:array[0..52] of int;
	head,dep,w:array[0..100010] of int;
	sz,n,m,lg,i,j,d,p,u,v:int;

procedure add(u,v:int);
begin
	inc(sz);g[sz].v:=v;
	g[sz].next:=head[u];head[u]:=sz;
end;

procedure dfs(u,p:int);
var v,i:int;
begin
	par[u,0]:=p;dep[u]:=dep[p]+1;
	i:=head[u];
	while i<>0 do begin
		v:=g[i].v;
		if v<>p then dfs(v,u);
		i:=g[i].next;
	end;
end;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

function lca(u,v:int):int;
var i:int;
begin
	if dep[u]<dep[v] then swap(u,v);
	for i:=lg downto 0 do
		if dep[par[u,i]]>=dep[v] then
			u:=par[u,i];
	if u=v then exit(u);
	for i:=lg downto 0 do
		if par[u,i]<>par[v,i] then begin
			u:=par[u,i];v:=par[v,i];
		end;
	lca:=par[u,0];
end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=a[random(r-l)+l];
	repeat
		while a[i]<x do inc(i);
		while a[j]>x do dec(j);
		if i<=j then begin
			swap(a[i],a[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

function calc(u,v,p:int):char;
var i,k:int;
begin
	k:=0;
	while u<>p do begin
		inc(k);a[k]:=w[u];u:=par[u,0];
	end;
	while v<>p do begin
		inc(k);a[k]:=w[v];v:=par[v,0];
	end;
	inc(k);a[k]:=w[p];
	qsort(1,k);
	for i:=1 to k-2 do
		if ll(a[i])+ll(a[i+1])>ll(a[i+2]) then exit('Y');
	calc:='N';
end;

begin
	assign(input,'sdtg.in');reset(input);
	assign(output,'sdtg.out');rewrite(output);
	read(n,m);lg:=floor(ln(n)/ln(2));
	for i:=1 to n do read(w[i]);
	for i:=1 to n-1 do begin
		read(u,v);add(u,v);add(v,u);	
	end;
	dfs(1,0);
	for j:=1 to lg do
		for i:=1 to n do
			par[i,j]:=par[par[i,j-1],j-1];
	for i:=1 to m do begin
		read(j,u,v);
		if j=0 then begin
			p:=lca(u,v);
			d:=dep[u]+dep[v]-2*dep[p];
			if d>52 then writeln('Y')
			else writeln(calc(u,v,p));
		end else w[u]:=v;
	end;
	close(input);close(output);
end.
