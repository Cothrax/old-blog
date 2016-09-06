const inf=10000000;
type 
	edge=record
		f,t,next,w:longint;
	end;
var 
	n,m,i,tmp,k,a,b,c:longint;
	g:array[0..40010] of edge;
	head,d:array[0..10010] of longint;
	flag:array[0..10010] of boolean;
	
procedure add(f0,t0,w0:longint);
begin
	inc(m);
	g[m].f:=f0;g[m].t:=t0;g[m].w:=w0;
	g[m].next:=head[f0];
	head[f0]:=m;
end;

procedure spfa(x:longint);
var i,v:longint;
begin
	i:=head[x];
	while i<>0 do begin
		v:=g[i].t;
		if d[x]+g[i].w<d[v] then
			if flag[v] then begin
				write('No');
				halt;
			end else begin
				d[v]:=d[x]+g[i].w;
				flag[v]:=true;
				spfa(v);
			end;
		i:=g[i].next;
	end;
	flag[x]:=false;
end;


begin
	fillchar(head,sizeof(head),0);
	read(n,tmp);
	m:=0;
	for i:=1 to tmp do begin
		read(k,a,b);
		case k of 
			1:begin read(c);add(a,b,-c) end;
			2:begin read(c);add(b,a,c) end;
			3:begin add(a,b,0);add(b,a,0) end;
		end;
	end;
	for i:=1 to n do add(0,i,0);
	fillchar(flag,sizeof(flag),false);
	filldword(d,sizeof(d) div 4,inf);
	d[0]:=0;flag[0]:=true;
	spfa(0);
	write('Yes');
end.