type int=longint;
var 
	l0,m,n,i,l,r,mid,ans:int;
	d:array[0..50010] of int;

function c(x:int):boolean;
var i,last,count:int;
begin
	count:=0;last:=0;i:=1;
	while i<=n do begin
		while (d[i]-d[last]<x) and (i<=n) do begin
			inc(i);inc(count);
		end;
		if count>m then exit(false);
		last:=i;inc(i);
	end;
	c:=true;
end;

begin
	read(l0,n,m);
	for i:=1 to n do read(d[i]);
	d[0]:=0;
	inc(n);d[n]:=l0;

	l:=0;r:=l0;ans:=-1;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if c(mid) then begin ans:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
	write(ans);
end.

