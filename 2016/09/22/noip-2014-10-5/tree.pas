uses math;
type 
	int=longint;
	edge=record t,next:int end;
var 
	g:array[0..80010] of edge;
	head,dep:array[0..40010] of int;
	par:array[0..40010,0..20] of int;
	n,m,logn,k,sz,i,j,r,f,t:int;

procedure add(f,t:int);
begin
	inc(sz);g[sz].t:=t;
	g[sz].next:=head[f];head[f]:=sz;
end;

procedure dfs(v,p:int);
var i,u:int;
begin
	dep[v]:=dep[p]+1;par[v,0]:=p;
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if u<>p then dfs(u,v);
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
	for i:=logn downto 0 do
		if dep[par[u,i]]>=dep[v] then
			u:=par[u,i];
	if v=u then exit(u);
	for i:=logn downto 0 do
		if par[u,i]<>par[v,i] then begin
			u:=par[u,i];v:=par[v,i];
		end;
	lca:=par[u,0];
end;

begin
	assign(input,'tree.in');reset(input);
	assign(output,'tree.out');rewrite(output);
	read(n);k:=0;
	for i:=1 to n do begin
		read(f,t);
		k:=max(k,max(f,t));
		if t=-1 then r:=f
		else begin add(f,t);add(t,f) end;
	end;
	dep[0]:=0;dfs(r,0);
	logn:=floor(ln(n)/ln(2));
	for i:=1 to logn do
		for j:=1 to k do
			par[j,i]:=par[par[j,i-1],i-1];
	read(m);
	for i:=1 to m do begin
		read(f,t);
		//if f=t then begin writeln(0);continue end;
		j:=lca(f,t);
		if j=f then writeln(1)
		else if j=t then writeln(2)
		else writeln(0);
	end;
	close(input);close(output);
end.
