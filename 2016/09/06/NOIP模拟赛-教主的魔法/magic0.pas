uses math;
type int=longint;
var 
	a,b,bl,t:array[0..10000010] of int;
	n,q,k,i,l,r,x:int;c:char;
	
procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=b[random(r-l)+l];
	repeat
		while b[i]<x do inc(i);
		while b[j]>x do dec(j);
		if i<=j then begin
			swap(b[i],b[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

procedure sort(i:int);
var j,l,r:int;
begin
	l:=(i-1)*k+1;r:=min(i*k,n);
	for j:=l to r do b[j]:=a[j];
	qsort(l,r);
end;

function bin(i,x:int):int; //max{i|b[i]<x}
var l,r,mid:int;
begin
	l:=(i-1)*k+1;r:=min(i*k,n);
	bin:=l-1;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if b[mid]+t[i]<x then begin bin:=mid;l:=mid+1 end
		else r:=mid-1;
	end;
end;

function query(l,r,x:int):int;
var i:int;
begin
	query:=0;
	for i:=l to min(r,bl[l]*k) do
		if a[i]+t[bl[l]]>=x then inc(query);
	if bl[l]<>bl[r] then
		for i:=(bl[r]-1)*k+1 to r do
			if a[i]+t[bl[r]]>=x then inc(query);
	for i:=bl[l]+1 to bl[r]-1 do
		inc(query,min(i*k,n)-bin(i,x));
end;

procedure modify(l,r,x:int);
var i:int;
begin
	for i:=l to min(r,bl[l]*k) do inc(a[i],x);
	sort(bl[l]);
	if bl[l]<>bl[r] then begin
		for i:=(bl[r]-1)*k+1 to r do inc(a[i],x);
		sort(bl[r]);
	end;
	for i:=bl[l]+1 to bl[r]-1 do inc(t[i],x);
end;

begin
	assign(input,'magic.in');reset(input);
	assign(output,'magic.out');rewrite(output);
	readln(n,q);k:=floor(sqrt(n));
	for i:=1 to n do read(a[i]);readln;
	for i:=1 to n do bl[i]:=(i-1) div k+1;
	for i:=1 to bl[n] do sort(i);
	for i:=1 to q do begin
		read(c);readln(l,r,x);
		case c of 
			'A':writeln(query(l,r,x));
			'M':modify(l,r,x);
		end;
	end;
	close(input);close(output);
end.
