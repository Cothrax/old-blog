uses math;
const eps=0.000000000001;
type 
	int=longint;
	edge=record f,t,next:int;w:double end;
var 
	n,m,i,f0,t0,w0:int;l,r,mid:double;
	g:array[0..10010] of edge;
	head,cnt:array[0..1010] of int;
	q:array[0..10010] of int;
	d:array[0..1010] of double;
	inq:array[0..1010] of boolean;

procedure add(f0,t0:int;w0:double);
var m:int;
begin
	inc(head[0]);m:=head[0];
	g[m].f:=f0;g[m].t:=t0;g[m].w:=w0;
	g[m].next:=head[f0];head[f0]:=m;
end;

function spfa(x:double):boolean;
var i,v,u,h,t:int;
begin
	fillchar(d,sizeof(d),0);
	fillchar(inq,sizeof(inq),true);
	filldword(cnt,sizeof(cnt) shr 1,1);
	for i:=1 to n do q[i]:=i;
	h:=1;t:=n+1;
	while h<>t do begin
		v:=q[h];inq[v]:=false;
		inc(h);if h>10010 then h:=0;
		i:=head[v];
		while i<>0 do begin
			u:=g[i].t;
			if d[u]>d[v]+g[i].w-x then begin
				d[u]:=d[v]+g[i].w-x;
				if not inq[u] then begin
					inq[u]:=true;q[t]:=u;
					inc(t);if t>10010 then t:=0;
					inc(cnt[u]);
					if cnt[u]>n then exit(true);
				end;
			end;
			i:=g[i].next;
		end;
	end;
	spfa:=false;
end;

begin
	assign(input,'B.in');reset(input);
	assign(output,'B.out');rewrite(output);
	read(n,m);
	l:=0;r:=0;
	for i:=1 to m do begin
		read(f0,t0);read(w0);
		r:=max(r,w0);
		add(f0,t0,w0);
	end;
	r:=r+1;
	if not spfa(r) then begin 
		write('PaPaFish is laying egg!');
		halt;
	end;
	while r-l>0.0001 do begin
		mid:=(l+r)/2;
		if spfa(mid) then r:=mid else l:=mid;
	end;
	write(r:0:2);
	close(input);close(output);
end.
