{$inline on}
uses math;
type int=longint;
var 
	n,m,i,j,h,t,t0,t1,p,c:int;
	a,q:array[0..5010] of int;
	x,y:array[0..5010] of qword;
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

function better(i,j,k:int):boolean;inline;
begin
	//i>j>k, g[i,j]<=g[j,k]
	better:=(y[i]-y[j])*(x[j]-x[k])<=(y[j]-y[k])*(x[i]-x[j]);
end;

function check(i,j,k:int):boolean;inline;
begin
	//j>k,g[j,k]<=2*a[i]
	check:=(y[j]-y[k])<=2*a[i]*(x[j]-x[k]);
end;

begin
	assign(input,'separate.in');reset(input);
	assign(output,'separate.out');rewrite(output);
	read(t0);
	for t1:=1 to t0 do begin
		read(n,m);
		for i:=1 to n do read(a[i]);
		qsort(1,n);
		for i:=1 to n do f[1,i]:=sqr(a[i]-a[1]);
		p:=0;c:=1;
		for i:=2 to m do begin
			p:=1-p;c:=1-c;
			h:=0;t:=0;q[h]:=i-1;
			for j:=i to n do begin
				x[j]:=a[j];
				y[j]:=f[p,j-1]+sqr(a[j]);
				while (h<t) and better(j,q[t],q[t-1]) do dec(t);
				inc(t);q[t]:=j;
				while (h<t) and check(j,q[h+1],q[h]) do inc(h);
				f[c,j]:=f[p,q[h]-1]+sqr(a[q[h]]-a[j]);
			end;
		end;
		writeln('Case ',t1,': ',f[c,n]);
	end;
	close(input);close(output);
end.
