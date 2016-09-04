uses math;
type int=longint;
const
	inf=100000000;
	maxn=1 shl 20;
var 
	n,k,m,i,j,sz,ans:int;
	a,b:array[0..10010] of int;
	s:array[0..110] of int;
	g:array[0..21,0..21] of int;
	f:array[0..maxn+10] of int;

procedure bfs(x:int);
var 
	h,t,i,v,u:int;
	q,d:array[0..10010] of int;
begin
	filldword(d,sizeof(d) div 4,inf);
	h:=1;t:=2;d[x]:=0;q[h]:=x;
	while h<>t do begin
		v:=q[h];
		for i:=1 to m do 
			for j:=-1 to 1 do begin
				u:=v+s[i]*j;
				if (u<1) or (u>n) then continue;
				if d[u]<>inf then continue;
				d[u]:=d[v]+1;q[t]:=u;
				inc(t);if t>10010 then t:=0;
			end;
		inc(h);if h>10010 then h:=0;
	end;
	for i:=1 to n do
		if b[i]<>0 then
			g[b[x],b[i]]:=d[i];
end;

function dp(s:int):int;
var x,li,i,lj,j:int;
begin
	if s=0 then exit(0);
	if f[s]<>-1 then exit(f[s]);
	f[s]:=inf;
	li:=s and (-s);
	i:=round(ln(li)/ln(2)+1);
	x:=s-li;
	while x<>0 do begin
		lj:=x and (-x);
		j:=round(ln(lj)/ln(2)+1);
		if g[i,j]<>inf then
			f[s]:=min(f[s],dp(s-li-lj)+g[i,j]);
		dec(x,lj);
	end;
	exit(f[s]);
end;

begin
	assign(input,'password.in');reset(input);
	assign(output,'password.out');rewrite(output);
	read(n,k,m);
	for i:=1 to k do begin
		read(j);
		a[j]:=1;
	end;
	for i:=1 to m do read(s[i]);
	inc(n);sz:=0;
	for i:=n downto 1 do b[i]:=a[i] xor a[i-1];
	for i:=1 to n do
		if b[i]=1 then begin
			inc(sz);b[i]:=sz;
		end;
	for i:=1 to n do
		if b[i]<>0 then bfs(i);
	//f[S]=min{f[S-lowbit-(1 shl j)]+d[lb,j]}
	fillchar(f,sizeof(f),255);
	ans:=dp(1 shl sz-1);
	if ans=inf then write(-1) else write(ans);
	close(input);close(output);
end.
