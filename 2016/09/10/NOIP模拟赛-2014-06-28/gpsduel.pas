uses math;
const inf=1000000000;
type 
	int=longint;
	edge=record f,t,w,next:int end;
	graph=array[0..50010] of edge;
	arr=array[0..10010] of int;
var 
	ga,gb,g:graph;
	ha,hb,head,da,db,q:arr;
	inq:array[0..10010] of boolean;
	n,m,i,cnt,f0,t0,a0,b0:int;

procedure add(var g:graph;var head:arr;f0,t0,w0:int);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].f:=f0;g[m].t:=t0;g[m].w:=w0;
	g[m].next:=head[f0];head[f0]:=m;
end;

procedure spfa(g:graph;head:arr;x:int;var d:arr);
var h,t,i,v,u:int;
begin
	fillchar(inq,sizeof(inq),false);
	filldword(d,sizeof(d) div 4,inf);
	h:=1;t:=2;q[h]:=x;d[x]:=0;inq[x]:=true;
	while h<>t do begin
		v:=q[h];i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if d[u]>d[v]+g[i].w then begin
				d[u]:=d[v]+g[i].w;
				if not inq[u] then begin
					inq[u]:=true;q[t]:=u;
					inc(t);if t>10010 then t:=0;
				end;
			end;
			i:=g[i].next;
		end;
		inq[v]:=false;
		inc(h);if h>10010 then h:=0;
	end;
end;

begin
	assign(input,'gpsduel.in');reset(input);
	assign(output,'gpsduel.out');rewrite(output);
	read(n,m);
	for i:=1 to m do begin
		read(f0,t0,a0,b0);
		add(ga,ha,t0,f0,a0);
		add(gb,hb,t0,f0,b0);
	end;
	spfa(ga,ha,n,da);spfa(gb,hb,n,db);
	for i:=1 to m do begin
		cnt:=2;
		if da[ga[i].t]=da[ga[i].f]+ga[i].w then dec(cnt);
		if db[gb[i].t]=db[gb[i].f]+gb[i].w then dec(cnt);
		add(g,head,ga[i].t,gb[i].f,cnt);
	end;
	spfa(g,head,1,da);
	write(da[n]);
	close(input);close(output);
end.
