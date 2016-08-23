type 
	int=longint;
	arr=array[0..1010] of int;
var 
	n,i:int;
	a,b:arr;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(var a:arr;b,e:int);
var i,j,x:int;
begin
	i:=b;j:=e;x:=a[random(e-b)+b];
	repeat
		while a[i]<x do inc(i);
		while a[j]>x do dec(j);
		if i<=j then begin
			swap(a[i],a[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<e then qsort(a,i,e);
	if b<j then qsort(a,b,j);
end;

function solve(a,b:arr):int;
var la,lb,ra,rb,ans:int;
begin
	la:=1;lb:=1;ra:=n;rb:=n;ans:=0;
	while (la<=ra) and (lb<=rb) do begin
		if a[la]<b[lb] then begin inc(ans,3);inc(la);inc(lb) end
		else if a[ra]<b[rb] then begin inc(ans,3);dec(ra);dec(rb) end
		else if a[ra]=b[lb] then begin inc(ans,2);dec(ra);inc(lb) end
		else begin inc(ans);dec(ra);inc(lb) end;
	end;
	solve:=ans;
end;

begin
	read(n);
	while n<>0 do begin
		for i:=1 to n do read(a[i]);
		for i:=1 to n do read(b[i]);
		qsort(a,1,n);
		qsort(b,1,n);
		writeln(solve(a,b),' ',4*n-solve(b,a));
		read(n);
	end;
end.
