uses math;
type int=longint;ll=int64;
const mx=10000000;md=1000000007;
var 
	f,g,a,p:array[0..mx+5] of int;
	flg:array[0..mx+5] of boolean;
	n,i,j,ans:int64;

procedure siev(n:int);
var i,j,k,x:int;
begin
	k:=0;
	for i:=2 to n do begin
		if not flg[i] then begin
			inc(k);p[k]:=i;a[i]:=1;
		end;
		j:=1;x:=p[j]*i;
		while x<=n do begin
			flg[x]:=true;
			if i mod p[j]=0 then 
				begin a[x]:=a[i];break end;
			a[x]:=a[i]+1;
			inc(j);x:=p[j]*i;
		end;
	end;
	f[0]:=0;
	for i:=1 to n do
		f[i]:=(f[i-1]+(1 shl a[i]))mod md;
end;

function calc(x:int64):int64;
var i,y,j:int64;
begin
	if x<=mx then exit(f[x]);
	y:=trunc(n/x);
	if g[y]<>-1 then exit(g[y]);
	g[y]:=0;i:=1;
	while i<=x do begin
		j:=trunc(x/trunc(x/i));
		g[y]:=(g[y]+trunc(x/i)*(j-i+1))mod md;
		i:=j+1;
	end;
	i:=2;
	while i*i<=x do begin
		g[y]:=(g[y]-calc(trunc(x/(i*i)))+md)mod md;
		inc(i);
	end;
	calc:=g[y];
end;

begin
	assign(input,'ra.in');reset(input);
	assign(output,'ra.out');rewrite(output);
	fillchar(g,sizeof(g),255);
	read(n);siev(min(n,mx));i:=1;ans:=0;
	while i<=n do begin
		j:=trunc(n/trunc(n/i));
		ans:=(ans+calc(trunc(n/i))*(j-i+1))mod md;
		i:=j+1;
	end;
	n:=n mod md;ans:=(n*n-ans+md)mod md;
	write(ans);
	close(input);close(output);
end.
