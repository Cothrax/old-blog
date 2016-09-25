uses math;
type 
	int=longint;
	edge=record f,t,next:int;v:boolean end;
	arr=array[0..200010] of int;
	st=array[0..200010,0..1] of int;
	pst=^st;
var
	g:array[0..800010] of edge;
	head,dep,par,dfn,low,dcc,s:arr;
	tr,bl:st;
	ins:array[0..200010] of boolean;
	n,m,q,sz,i,f,t,cc,tim:int;

procedure add(f,t:int);
begin
	inc(sz);
	g[sz].f:=f;g[sz].t:=t;g[sz].v:=true;
	g[sz].next:=head[f];head[f]:=sz;	
end;

procedure tarjan(v,p:int);
var i,u:int;
begin
	inc(tim);dfn[v]:=tim;low[v]:=tim;
	inc(t);s[t]:=v;ins[v]:=true;
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if g[i].v then begin
			g[i xor 1].v:=false;
			if dfn[u]=0 then begin
				tarjan(u,v);
				low[v]:=min(low[v],low[u]);
			end else if ins[u] then
				low[v]:=min(low[v],dfn[u]);
		end;
		i:=g[i].next;
	end;
	if low[v]=dfn[v] then begin
		inc(cc);bl[cc,1]:=0;
		while s[t+1]<>v do begin
			ins[s[t]]:=false;
			inc(bl[cc,1]);dcc[s[t]]:=cc;
			dec(t);
		end;
	end;
end;

function find(p:pst;x:int):int;
begin
	if x=p^[x,0] then find:=x
	else begin
		p^[x,0]:=find(p,p^[x,0]);
		find:=p^[x,0];
	end;
end;

procedure union(p:pst;x,y:int);
begin
	x:=find(p,x);y:=find(p,y);
	if x=y then exit;
	inc(p^[y,1],p^[x,1]);p^[x,1]:=0;
	p^[x,0]:=y;
end;

function same(p:pst;x,y:int):boolean;
begin same:=find(p,x)=find(p,y) end;

procedure dfs(v,p:int);
var i,u:int;
begin
	if p<>0 then union(@tr,v,p);
	par[v]:=p;dep[v]:=dep[p]+1;
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

procedure lca(u,v:int);
begin
	if dep[u]<dep[v] then swap(u,v);
	while dep[u]>dep[v] do begin
		union(@bl,u,par[u]);
		u:=par[u];
	end;
	while u<>v do begin
		union(@bl,u,par[u]);u:=par[u];
		union(@bl,v,par[v]);v:=par[v];
	end;
end;

procedure merge(u,v:int);
begin
	if tr[find(@tr,u),1]>tr[find(@tr,v),1] then swap(u,v);
	add(v,u);add(u,v);dfs(u,v);
end;

begin
	//input
	read(n,m,q);sz:=1;
	for i:=1 to m do begin
		read(f,t);add(f,t);add(t,f);
	end;
	//tarjan
	tim:=0;t:=0;cc:=0;
	for i:=1 to n do if dfn[i]=0 then tarjan(i,0);
	//init set
	for i:=1 to cc do begin
		tr[i,0]:=i;tr[i,1]:=1;bl[i,0]:=i;
	end;
	//build tree
	f:=sz;sz:=0;
	fillchar(head,sizeof(head),0);
	for i:=0 to f do
		if dcc[g[i].f]<>dcc[g[i].t] then 
			add(dcc[g[i].f],dcc[g[i].t]);
	for i:=1 to cc do
		if dep[i]=0 then dfs(i,0);
	//query
	for i:=1 to q do begin
		read(f,t);
		f:=dcc[f];t:=dcc[t];
		if not same(@tr,f,t) then begin
			merge(f,t);
			writeln('No');
		end else begin
			if not same(@bl,f,t) then lca(f,t);
			writeln(bl[find(@bl,f),1]);
		end;
	end;
end.
