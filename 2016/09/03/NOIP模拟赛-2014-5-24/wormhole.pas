type 
	int=longint;
	edge=record t,w,next:int end;
var 
	g:array[0..6010] of edge;
	head:array[0..510] of int;
	n,m,k,t,i,f0,t0,w0:int;

procedure add(f,t,w:int);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].t:=t;g[m].w:=w;
	g[m].next:=head[f];head[f]:=m;
end;

function spfa():boolean;
var 
	i,v,u,h,t:int;
	cnt,q,d:array[0..510] of int;
	inq:array[0..510] of boolean;
begin
	fillchar(d,sizeof(d),0);
	filldword(cnt,sizeof(cnt) div 4,1);
	fillchar(inq,sizeof(inq),true);
	for i:=1 to n do q[i]:=i;
	h:=1;t:=n+1;
	while h<>t do begin
		v:=q[h];
		i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if d[u]>d[v]+g[i].w then begin
				d[u]:=d[v]+g[i].w;
				if not inq[u] then begin
					inc(cnt[u]);
					if cnt[u]>n then exit(true);
					q[t]:=u;inq[u]:=true;
					inc(t);if t>510 then t:=0;
				end;
			end;
			i:=g[i].next;
		end;
		inc(h);if h>510 then h:=0;
		inq[v]:=false;
	end;
	spfa:=false;
end;

begin
	assign(input,'wormhole.in');reset(input);
	assign(output,'wormhole.out');rewrite(output);
	read(t);
	repeat
		fillchar(head,sizeof(head),0);
		read(n,m,k);
		for i:=1 to m do begin
			read(f0,t0,w0);
			add(f0,t0,w0);add(t0,f0,w0);
		end;
		for i:=1 to k do begin
			read(f0,t0,w0);add(f0,t0,-w0);
		end;
		if spfa then writeln('YES') else writeln('NO');
		dec(t);
	until t=0;
	close(input);close(output);
end.
