uses math;
type int=longint;
const inf=1000000000;
var
	i,j,n,k:int;
	f:array[0..1010,0..1010,0..1] of int;
	d,w,l,r:array[0..1010] of int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(l,r:int);
var i,j:int;x:int;
begin
	i:=l;j:=r;x:=d[random(r-l)+l];
	repeat
		while d[i]<x do inc(i);
		while d[j]>x do dec(j);
		if i<=j then begin
			if i=k then k:=j;if j=k then k:=i;
			swap(d[i],d[j]);swap(w[i],w[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;	

begin
	assign(input,'czybm.in');reset(input);
	assign(output,'czybm.out');rewrite(output);
	read(n,k);
	for i:=1 to n do read(d[i],w[i]);
	qsort(1,n);l[k-1]:=0;r[n-k]:=0;
	for i:=k-2 downto 0 do l[i]:=l[i+1]+w[k-1-i];
	for i:=n-k-1 downto 0 do r[i]:=r[i+1]+w[k+1+i];
	filldword(f,sizeof(f) div 4,inf);
	f[0,0,0]:=0;f[0,0,1]:=0;
	for i:=0 to k-1 do
		for j:=0 to n-k do begin
			if i>0 then f[i,j,0]:=min(
				f[i-1,j,0]+(l[i-1]+r[j])*(d[k-i+1]-d[k-i]),
				f[i-1,j,1]+(l[i-1]+r[j])*(d[k+j]-d[k-i]));
			if j>0 then f[i,j,1]:=min(
				f[i,j-1,1]+(l[i]+r[j-1])*(d[k+j]-d[k+j-1]),
				f[i,j-1,0]+(l[i]+r[j-1])*(d[k+j]-d[k-i]));
		end;
	write(min(f[k-1,n-k,0],f[k-1,n-k,1]));
	close(input);close(output);
end.
