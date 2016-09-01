uses math;
type 
	int=longint;
	edge=record t,w,next:int end;
const inf=100000000;
var 
	g:array[0..150010] of edge;
	head,s,w,a,q,dist:array[0..10010] of int;
	inq:array[0..10010] of boolean;
	n,m,i,f0,t0,w0,d:int;

procedure add(f,t,w:int);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].t:=t;g[m].w:=w;
	g[m].next:=head[f];head[f]:=m;
end;

procedure spfa(x:int);
var u,v,i,h,t:int;
begin
	filldword(dist,sizeof(dist) div 4,inf);
	fillchar(inq,sizeof(inq),false);
	h:=1;t:=2;q[h]:=x;inq[x]:=true;dist[x]:=0;
	while h<>t do begin
		v:=q[h];
		i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if dist[v]+g[i].w<dist[u] then begin
				dist[u]:=dist[v]+g[i].w;
				if not inq[u] then begin
					inq[u]:=true;q[t]:=u;
					inc(t);if t>10010 then t:=0;
				end;
			end;
			i:=g[i].next;
		end;
		inc(h);if h>10010 then h:=0;
		inq[v]:=false;
	end;
end;

begin
	assign(input,'holes.in');reset(input);
	assign(output,'holes.out');rewrite(output);
	read(n,m);
	for i:=1 to n do read(a[i]);
	for i:=1 to n do read(w[i]);
	//i white i+n black
	for i:=1 to n do begin
		read(s[i]);
		add(i,i+n,0);
		add(i+n,i,s[i]);
	end;
	for i:=1 to m do begin
		read(f0,t0,w0);
		if a[f0]=a[t0] then begin
			add(f0,t0+n,w0);
			add(f0+n,t0,w0);
		end else begin
			d:=abs(w[f0]-w[t0]);
			add(f0,t0,max(w0-d,0));
			add(f0+n,t0+n,w0+d);
		end;
	end;
	spfa(a[1]*n+1);
	write(min(dist[n],dist[2*n]));
	close(input);close(output);
end.
