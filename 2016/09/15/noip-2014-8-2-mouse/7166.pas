uses math;
var 
	n,m,i,j,ans:longint;
	t,w:array[0..101] of longint;
	f:array[0..1010] of longint;

procedure qsort(b,e:longint);
var i,j,x,tmp:longint;
begin
	i:=b;j:=e;x:=t[random(e-b)+b];
	repeat
		while t[i]<x do inc(i);
		while t[j]>x do dec(j);
		if i<=j then begin
			tmp:=t[i];t[i]:=t[j];t[j]:=tmp;
			tmp:=w[i];w[i]:=w[j];w[j]:=tmp;
			inc(i);dec(j);
		end;
	until i>j;
	if i<e then qsort(i,e);
	if b<j then qsort(b,j);
end;

begin
	read(n);
	for i:=1 to n do read(t[i]);
	for i:=1 to n do read(w[i]);
	qsort(1,n);m:=t[n];
	fillchar(f,sizeof(f),0);
	for i:=1 to n do
		for j:=t[i] downto 1 do
			f[j]:=max(f[j],f[j-1]+w[i]);
	ans:=0;
	for i:=1 to m do ans:=max(ans,f[i]);
	write(ans);
end.
