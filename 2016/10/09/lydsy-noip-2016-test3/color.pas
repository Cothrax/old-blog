uses math;
const md:qword=998244353;
type 
	int=longint;
	mat=array[-1..110,-1..110] of qword;
var 
	f,c,a:mat;
	g:array[-1..110] of qword;
	n,p,q,i,j,k:int;ans,m:qword;

function mul(a,b:mat):mat;
var i,j,k:int;
begin
	fillchar(mul,sizeof(mul),0);
	for i:=1 to p do
		for j:=1 to p do
			for k:=1 to p do
				mul[i,j]:=(mul[i,j]+a[i,k]*b[k,j])mod md;
end;

function mpow(a:mat;k:qword):mat;
var i:int;
begin
	fillchar(mpow,sizeof(mpow),0);
	for i:=1 to p do mpow[i,i]:=1;
	while k>0 do begin
		if k and 1=1 then mpow:=mul(mpow,a);
		a:=mul(a,a);k:=k shr 1;
	end;
end;

function ipow(a,k:qword):qword;
begin
	ipow:=1;
	while k>0 do begin
		if k and 1=1 then ipow:=ipow*a mod md;
		a:=a*a mod md;k:=k shr 1;
	end;
end;

begin
	//assign(input,'color.in');reset(input);
	//assign(output,'color.ans');rewrite(output);
	read(n,m,p,q);
	f[0,0]:=1;
	for i:=1 to n do
		for j:=1 to p do
			f[i,j]:=(f[i-1,j-1]*(p-j+1)+f[i-1,j]*j)mod md;
	c[0,0]:=1;
	for i:=1 to p do
		for j:=0 to i do
			c[i,j]:=(c[i-1,j]+c[i-1,j-1])mod md;
	for i:=1 to p do g[i]:=f[n,i]*ipow(c[p,i],md-2)mod md;
	for i:=1 to p do
		for j:=1 to p do
			for k:=max(max(i,j),q) to p do
				a[i,j]:=(a[i,j]+c[i,i+j-k]*
					(c[p-i,k-i]*g[j]mod md))mod md;
	a:=mpow(a,m-1);
	ans:=0;
	for i:=1 to p do
		for j:=1 to p do
			ans:=(ans+a[i,j]*f[n,i])mod md;
	write(ans);
	//close(input);close(output);
end.
