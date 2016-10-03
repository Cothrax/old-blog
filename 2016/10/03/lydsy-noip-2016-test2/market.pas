uses math;
type int=longint;
const inf=1000000010;
var
	v,t,c,sum:array[0..310] of int;
	f:array[0..310,0..90010] of int;
	n,m,i:int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=t[random(r-l)+l];
	repeat
		while t[i]<x do inc(i);
		while t[j]>x do dec(j);
		if i<=j then begin
			swap(t[i],t[j]);swap(v[i],v[j]);swap(c[i],c[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

procedure dp();
var i,j:int;
begin
	sum[0]:=0;
	for i:=1 to n do sum[i]:=sum[i-1]+v[i];
	filldword(f,sizeof(f) div 4,inf);
	f[0,0]:=0;
	for i:=1 to n do
		for j:=0 to sum[i] do begin
			f[i,j]:=f[i-1,j];
			if j>=v[i] then 
				f[i,j]:=min(f[i,j],f[i-1,j-v[i]]+c[i]);
		end;
	for i:=1 to n do
		for j:=sum[i]-1 downto 0 do
			f[i,j]:=min(f[i,j],f[i,j+1]);
end;

function calc():int;
var l,r,mid,x,t0,m0:int;
begin
	read(t0,m0);
	l:=1;r:=n;x:=-1;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if t[mid]<=t0 then begin x:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
	if x=-1 then exit(0);
	l:=0;r:=sum[x];calc:=0;
	//max_v{f[x,v]<=m0}
	while l<=r do begin
		mid:=(l+r) shr 1;
		if f[x,mid]<=m0 then begin calc:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
end;

begin
	//assign(input,'market.in');reset(input);
	//assign(output,'market.ans');rewrite(output);
	read(n,m);
	for i:=1 to n do read(c[i],v[i],t[i]);
	qsort(1,n);dp();
	for i:=1 to m do writeln(calc());
	//close(input);close(output);
end.
