uses math;
type int=longint;
const eps=0.000001;
var 
	t,n,m,i,j,k:int;
	x,y:array[0..20] of double;
	s:array[0..20,0..20] of int;
	f:array[0..1 shl 18+10] of int;

{procedure print(x:int);
var i:int;
begin
	for i:=n-1 downto 0 do
		write(1 and (x shr i));
	writeln;
end;}

function calc(u,v:int):int;
var a,b,p:double;i:int;
begin
	p:=x[u]/x[v];
	if abs(x[u]-x[v])<eps then exit(0);
	a:=(y[u]-y[v]*p)/(sqr(x[u])-sqr(x[v])*p);
	b:=(y[u]-a*sqr(x[u]))/x[u];
	if (a>0)or(abs(a)<eps) then exit(0);
	calc:=0;
	for i:=0 to n-1 do
		if abs(y[i]-(a*sqr(x[i])+b*x[i]))<eps then
			calc:=calc or (1 shl i);
	{writeln('>>',a:0:3,' ',b:0:3);
	write(u,',',v,'::',calc,'  ');print(calc);}
end;

begin
	//assign(input,'angrybirds.in');reset(input);
	//assign(output,'angrybirds.out');rewrite(output);
	read(t);
	repeat
		read(n,m);m:=1 shl n-1;
		for i:=0 to n-1 do read(x[i],y[i]);
		for i:=0 to n-1 do
			for j:=i+1 to n-1 do s[i,j]:=calc(i,j);
		for i:=0 to n-1 do s[i,i]:=1 shl i;
		{for i:=0 to n-1 do begin
			for j:=0 to n-1 do write(s[i,j],' ');writeln;
		end;}
		f[0]:=0;
		for i:=1 to m do begin
			j:=i;f[i]:=maxlongint;
			for j:=0 to n-1 do if i and(1 shl j)>0 then
				for k:=j to n-1 do if i and(1 shl k)>0 then
					f[i]:=min(f[i],f[i xor(i and s[j,k])]+1);
		end;
		writeln(f[m]);
		dec(t);
	until t=0;
	//close(input);close(output);
end.
