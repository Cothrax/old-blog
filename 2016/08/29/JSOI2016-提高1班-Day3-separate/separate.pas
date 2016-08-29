uses math;
type int=longint;
const inf=1000000000;
var 
	n,m,i,j,k,p,c,t,t0:int;
	a:array[0..5010] of int;
	f:array[0..1,0..5010] of int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(b,e:int);
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
	if i<e then qsort(i,e);
	if b<j then qsort(b,j);
end;

begin
	assign(input,'separate.in');reset(input);
	assign(output,'separate.ans');rewrite(output);
	read(t0);
	for t:=1 to t0 do begin
		read(n,m);
		for i:=1 to n do read(a[i]);
		qsort(1,n);
		filldword(f,sizeof(f) div 4,inf);
		f[0,0]:=0;p:=1;c:=0;
		for i:=1 to m do begin
			swap(p,c);
			filldword(f[c],sizeof(f[c]) div 4,inf);
			for j:=1 to n do 
				for k:=1 to j do
					f[c,j]:=min(f[c,j],f[p,k-1]+sqr(a[k]-a[j]));
		end;
		writeln('Case ',t,': ',f[c,n]);
	end;
	close(input);close(output);
end.

{
2
3 2
1 2 4
4 2
4 7 10 1

7 4
24 8 10 48 9 51 100
}
