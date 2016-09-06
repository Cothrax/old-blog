type 
	int=longint;
	edge=record t,next:int end;
var 
	g:array[0..100010] of edge;
	head,t,ind:array[0..100010] of int;
	i,n,m,k,f0,t0,tim:int;

procedure add(f0,t0:int);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].t:=t0;
	g[m].next:=head[f0];head[f0]:=m;
end;

procedure topo(v:int);
var i,u:int;
begin
	inc(tim);t[v]:=tim;
	i:=head[v];
	while i<>0 do begin
		u:=g[i].t;
		if t[u]=0 then topo(u);
		i:=g[i].next;
	end;
end;

begin
	assign(input,'dizzy.in');reset(input);
	assign(output,'dizzy.out');rewrite(output);
	read(n,m,k);
	for i:=1 to m do begin
		read(f0,t0);add(f0,t0);inc(ind[t0]);
	end;
	tim:=0;
	for i:=1 to n do
		if ind[i]=0 then topo(i);
	for i:=1 to k do begin
		read(f0,t0);
		if t[f0]<t[t0] then writeln(f0,' ',t0)
		else writeln(t0,' ',f0);
	end;
	close(input);close(output);
end.
