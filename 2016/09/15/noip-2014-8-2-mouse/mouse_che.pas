type int=longint;
var 
	a,t:array[0..100010] of int;
	used:array[0..50010] of boolean;
	n,i,j:int;ans:int64;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=a[random(r-l)+r];
	repeat
		while a[i]>x do inc(i);
		while a[j]<x do dec(j);
		if i<=j then begin
			swap(t[i],t[j]);swap(a[i],a[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;
	
begin
	assign(input,'mouse.in');reset(input);
	assign(output,'mouse.out');rewrite(output);
	read(n);
	for i:=1 to n do read(t[i]);
	for i:=1 to n do read(a[i]);
	qsort(1,n);ans:=0;
	for i:=1 to n do begin
		j:=t[i];
		while (j>0) and used[j] do dec(j);
		if j<>0 then begin 
			inc(ans,a[i]);used[j]:=true;
		end;
	end;
	write(ans);
end.
