uses math;
const inf=1000000000;
type 
	int=longint;
	mat=array[0..155,0..155] of int64;
var 
	a,b,c,d,k,i,j,x,til,len,rst:int;
	l,r,f,s,loc:array[0..2240] of int;
	g:mat;n,m,ans:int64;

function bin(x,n:int):int;
var l,r,mid:int;
begin
	//max_j{f[j]<=x}
	l:=1;r:=n;bin:=0;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if f[mid]<=x then begin bin:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
end;

function lis(dn,up,n,b:int):int;
var i,j:int;
begin
	for i:=1 to n do f[i]:=inf;
	lis:=0;f[0]:=0;
	for i:=1 to n do begin
		if (s[b+i]<dn)or(s[b+i]>up) then continue;
		j:=bin(s[b+i],lis);
		f[j+1]:=min(f[j+1],s[b+i]);
		if j=lis then inc(lis);
	end;
end;

function _lis(n,b:int):int;
var i,j,len:int;
begin
	for i:=1 to n do f[i]:=inf;
	f[1]:=s[b+1];len:=1;
	for i:=2 to n do begin
		j:=bin(s[b+i],len);
		if j>0 then f[j+1]:=min(f[j+1],s[b+i]);
		if j=len then inc(len);
	end;
	_lis:=j+1;
end;

function mul(var a,b:mat):mat;
var i,j,k:int;
begin
	fillchar(mul,sizeof(mul),224);
	for i:=1 to len do
		for j:=1 to len do
			for k:=1 to len do if min(a[i,k],b[k,j])>=0 then
				mul[i,j]:=max(mul[i,j],a[i,k]+b[k,j]-1);
end;

function mpow(var a:mat;p:int64):mat;
var i:int;
begin
	fillchar(mpow,sizeof(mpow),224);
	for i:=1 to len do mpow[i,i]:=1;
	while p>0 do begin
		if p and 1=1 then mpow:=mul(mpow,a);
		a:=mul(a,a);
		p:=p shr 1;
	end;
end;

begin
	assign(input,'lis.in');reset(input);
	assign(output,'lis.out');rewrite(output);
	read(n,s[1],a,b,c,d);k:=1;
	//找循环节
	while true do begin
		x:=(a*sqr(s[k])+b*s[k]+c)mod d;
		if loc[x]>0 then break;
		inc(k);s[k]:=x;loc[x]:=k;
	end;
	til:=loc[x]-1;len:=k-loc[x]+1;
	rst:=(n-til)mod len;m:=(n-til)div len;
	if n<=k then //不足一个周期特判
		begin write(lis(-1,d,n,0));halt end;
	if len=1 then //周期为1特判
		begin write(m+lis(-1,s[til+1],til,0));halt end;
	for i:=k+1 to k+len do s[i]:=s[i-len];
	//预处理
	for i:=1 to len do begin
		l[i]:=lis(-1,s[til+i],til,0);
		r[i]:=lis(s[til+i],d,rst,til);
	end;
	//矩阵快速幂
	//g[n,i,j]=max(g[n-1,i,j]+g[1,j,k]) a[i]<=a[j]<=a[k]
	for i:=1 to len do
		for j:=1 to len do
			if s[til+i]>s[til+j] then g[i,j]:=-inf
			else g[i,j]:=_lis(len-i+j+1,til-1+i);
	g:=mpow(g,m-1);ans:=0;
	//统计答案
	for i:=1 to len do
		for j:=1 to len do
			ans:=max(ans,l[i]+r[j]+g[i,j]);
	write(ans);
	close(input);close(output);
end.
