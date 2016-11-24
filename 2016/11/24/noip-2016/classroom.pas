uses math;
type int=longint;
const inf=1000000000;
var
	g:array[0..310,0..310] of int;
	c,d:array[0..2010] of int;
	a:array[0..2010] of double;
	f:array[0..2010,0..2010,0..1] of double;
	n,m,p,q,u,v,w,i,j,k:int;x,y,z,ans:double;

{procedure print(x:double);
begin
	if x>inf-0.001 then write(-1.0:0:3) else write(x:0:3);
end;}

begin
	read(n,m,p,q);
	filldword(g,sizeof(g)shr 2,inf);
	for i:=1 to n do read(c[i]);
	for i:=1 to n do read(d[i]);
	for i:=1 to n do read(a[i]);
	for i:=1 to q do begin
		read(u,v,w);
		g[u,v]:=min(g[u,v],w);g[v,u]:=g[u,v];
	end;
	for k:=1 to p do
		for i:=1 to p do
			for j:=1 to p do
				g[i,j]:=min(g[i,j],g[i,k]+g[k,j]);
	for i:=1 to p do g[i,i]:=0;
	for i:=1 to p do g[0,i]:=0;
	{for i:=1 to p do begin
		for j:=1 to p do write(g[i,j]:3);
		writeln;
	end;}
	f[0,0,0]:=0;
	for i:=1 to n do
		for j:=i+1 to m do
			begin f[i,j,0]:=inf;f[i,j,1]:=inf end;
	for i:=1 to n do begin
		x:=a[i-1]*g[d[i-1],c[i]]+(1-a[i-1])*g[c[i-1],c[i]];
		y:=a[i]*g[c[i-1],d[i]]+(1-a[i])*g[c[i-1],c[i]];
		z:=a[i]*(a[i-1]*g[d[i-1],d[i]]+(1-a[i-1])*g[c[i-1],d[i]])+(1-a[i])*x;
		f[i,0,0]:=f[i-1,0,0]+g[c[i-1],c[i]];
		//writeln(i,'::',x:0:3,' ',y:0:3,' ',z:0:3);
		f[i,0,1]:=inf;
		for j:=1 to min(i,m) do begin
			f[i,j,0]:=min(f[i-1,j,0]+g[c[i-1],c[i]],f[i-1,j,1]+x);
			f[i,j,1]:=min(f[i-1,j-1,0]+y,f[i-1,j-1,1]+z);
		end;
	end;
	{for i:=1 to n do begin
		for j:=0 to m do begin
			print(f[i,j,0]);write(':');print(f[i,j,1]);write(' ');
		end;
		writeln;
	end;}
	ans:=inf;
	for i:=0 to min(n,m) do ans:=min(ans,min(f[n,i,0],f[n,i,1]));
	write(ans:0:2);
end.
