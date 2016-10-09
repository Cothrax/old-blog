uses math;
type int=longint;
var
	a,b,c:array[0..100010] of double;
	n,i:int;l,r,mid:double;m,cnt:int64;

procedure merge(l,r:int);
var mid,p,q:int;
begin
	if l=r then exit;
	mid:=(l+r) shr 1;
	merge(l,mid);merge(mid+1,r);
	p:=l;q:=mid+1;
	for i:=l to r do
		if (p>mid) or ((q<=r) and (b[q]<b[p])) then begin
			c[i]:=b[q];inc(cnt,mid-p+1);inc(q)
		end else begin
			c[i]:=b[p];inc(p)
		end;
	for i:=l to r do b[i]:=c[i];
end;

function jud(x:double):boolean;
var i:int;
begin
	b[0]:=0;
	for i:=1 to n do b[i]:=a[i]-x+b[i-1];
	cnt:=0;merge(0,n);jud:=cnt>=m;
end;

begin
	read(n,m);l:=maxlongint;r:=0;
	for i:=1 to n do begin
		read(a[i]);
		l:=min(a[i],l);r:=max(a[i],r);
	end;
	while r-l>0.000001 do begin
		mid:=(l+r)/2;
		if jud(mid) then r:=mid else l:=mid;
	end;
	write(l:0:4);
end.
