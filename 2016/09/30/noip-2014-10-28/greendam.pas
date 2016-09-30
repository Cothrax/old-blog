uses math;
type 
	int=longint;
	edge=record f,t,w,next:int end;
	graph=array[0..1000010] of edge;
	arr=array[0..1010] of int;
const inf=100000000;
var
	g0,g:graph;q,d,df,dt,h0,l,iter,head:arr;
	h:array[0..1010,0..1] of int;
	n,m,sz,i,f0,t0,f,t,w:int;

//heap begin
procedure swap(x,y:int);
var tmp:int;
begin
	l[h[x,1]]:=y;l[h[y,1]]:=x;
	tmp:=h[x,0];h[x,0]:=h[y,0];h[y,0]:=tmp;
	tmp:=h[x,1];h[x,1]:=h[y,1];h[y,1]:=tmp;
end;

procedure heapify(i:int);
var l,r,s:int;
begin
	l:=i shl 1;r:=l or 1;
	if (l<=sz) and (h[l,0]<h[i,0]) then s:=l else s:=i;
	if (r<=sz) and (h[r,0]<h[s,0]) then s:=r;
	if i<>s then begin
		swap(i,s);heapify(s);
	end;
end;

procedure extract();
begin
	swap(1,sz);dec(sz);heapify(1);
end;

procedure reduceto(x,k:int);
var i:int;
begin
	h[x,0]:=k;i:=x;
	while (i>1) and (h[i,0]<h[i shr 1,0]) do begin
		swap(i,i shr 1);i:=i shr 1;
	end;
end;

procedure insert(i,k:int);
begin
	inc(sz);l[i]:=sz;
	h[sz,0]:=inf;h[sz,1]:=i;
	reduceto(sz,k);
end;
//heap end

procedure dijkstra(s:int;var d:arr);
var i,v,u:int;
begin
	sz:=0;
	for i:=1 to n do
		if i=s then insert(i,0) else insert(i,inf);
	while sz>0 do begin
		v:=h[1,1];d[v]:=h[1,0];extract;
		i:=h0[v];
		while i<>0 do begin
			u:=g0[i].t;
			if (l[u]<=sz) and (h[l[u],0]>d[v]+g0[i].w) then
				reduceto(l[u],d[v]+g0[i].w);
			i:=g0[i].next;
		end;
	end;
end;

procedure add(var g:graph;var head:arr;f,t,w:int);
var sz:int;
begin
	inc(head[0]);sz:=head[0];
	g[sz].f:=f;g[sz].t:=t;g[sz].w:=w;
	g[sz].next:=head[f];head[f]:=sz;
end;

//maxflow begin
function bfs(s,t0:int):boolean;
var h,t,i,v,u:int;
begin
	fillchar(d,sizeof(d),255);
	h:=1;t:=2;q[h]:=s;d[s]:=0;
	while h<>t do begin
		v:=q[h];inc(h);if h>1010 then h:=0;
		i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if (d[u]=-1) and (g[i].w>0) then begin
				d[u]:=d[v]+1;
				q[t]:=u;inc(t);if t>1010 then t:=0;
			end;
			i:=g[i].next;
		end;
	end;
	bfs:=d[t0]<>-1;
end;

function dfs(v,t,f:int):int;
var i,u,tmp:int;
begin
	if v=t then exit(f);
	i:=iter[v];dfs:=0;
	while i<>0 do begin
		u:=g[i].t;
		if (g[i].w>0) and (d[u]=d[v]+1) then begin
			tmp:=dfs(u,t,min(f-dfs,g[i].w));
			dec(g[i].w,tmp);
			inc(g[i xor 1].w,tmp);
			inc(dfs,tmp);
			if g[i].w>0 then iter[v]:=i;
			if f=dfs then exit(f);
		end;
		i:=g[i].next;
	end;
	if dfs=0 then d[v]:=-1;
end;

function maxflow(s,t:int):int;
var i:int;
begin
	maxflow:=0;
	while bfs(s,t) do begin
		for i:=1 to n do iter[i]:=head[i];
		inc(maxflow,dfs(s,t,inf));
	end;
end;
//maxflow end

begin {main}
	assign(input,'greendam.in');reset(input);
	assign(output,'greendam.out');rewrite(output);
	read(n,m,f0,t0);
	fillchar(h0,sizeof(h0),0);
	for i:=1 to m do begin
		read(f,t,w);
		add(g0,h0,f,t,w);add(g0,h0,t,f,w);
	end;
	dijkstra(f0,df);dijkstra(t0,dt);
	fillchar(head,sizeof(head),0);
	head[0]:=1;
	for i:=1 to 2*m do
		if df[g0[i].f]+g0[i].w+dt[g0[i].t]=df[t0] then begin
			add(g,head,g0[i].f,g0[i].t,1);
			add(g,head,g0[i].t,g0[i].f,0);
		end;
	writeln(maxflow(f0,t0));
	close(input);close(output);
end.
