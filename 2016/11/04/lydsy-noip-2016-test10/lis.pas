uses math;
type int=longint;ll=int64;
const inf=1000000;mx=100000;
var 
	loc:array[0..155] of int;
	seq,f:array[0..mx+10] of int;
	a,b,c,d,k,x,i:int;n:int64;

function bin(x,n:int):int;
var l,r,mid:int;
begin
	l:=0;r:=n;bin:=0;
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
	f[0]:=0;lis:=0;
	for i:=1 to n do begin
		if (seq[b+i]<dn)or(seq[b+i]>up) then continue;
		j:=bin(seq[b+i],lis);
		f[j+1]:=min(f[j+1],seq[b+i]);
		if j=lis then inc(lis);
	end;
end;

procedure solv();
var b,r,l,i,dt:int;ans,m:int64;
begin
	b:=loc[x];l:=k-loc[x]+1;
	m:=(n-b+1)div l;r:=(n-b+1)mod l;
	dt:=l*l;
	for i:=k+1 to k+dt do seq[i]:=seq[i-l];
	ans:=0;
	for i:=b to k do
		ans:=max(ans,ll(lis(-1,seq[i],b-1+dt,0))+
			ll(lis(seq[i],d,r+dt,b-1))+m-2*l);
	write(ans);
end;

begin
	assign(input,'lis.in');reset(input);
	assign(output,'lis.out');rewrite(output);
	read(n,seq[1],a,b,c,d);
	if n<=mx then begin
		for i:=2 to n do
			seq[i]:=(a*sqr(seq[i-1])+b*seq[i-1]+c) mod d;
		write(lis(-1,d,n,0));halt;
	end;
	loc[seq[1]]:=1;k:=1;
	while true do begin
		x:=(a*sqr(seq[k])+b*seq[k]+c) mod d;
		if loc[x]<>0 then break;
		inc(k);seq[k]:=x;loc[x]:=k;
	end;
	solv();
	close(input);close(output);
end.
