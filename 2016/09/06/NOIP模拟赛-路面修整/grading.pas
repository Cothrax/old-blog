uses math;
type int=longint;
const inf:int64=1000000000000;
var
	a:array[0..2010,0..1] of int64;
	//b[i]:a[i]离散后的值;l[i]:i对应的离散值;
	b:array[0..2010] of int; 
	l:array[0..2010] of int64;
	f:array[0..1,0..2010] of int64;
	i,i0,i1,j,n,m:int;p,ans:int64;

procedure swap(var a,b:int64);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(b,e:int);
var i,j:int;x:int64;
begin
	i:=b;j:=e;x:=a[random(e-b)+b,0];
	repeat
		while a[i,0]<x do inc(i);
		while a[j,0]>x do dec(j);
		if i<=j then begin
			swap(a[i,0],a[j,0]);
			swap(a[i,1],a[j,1]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<e then qsort(i,e);
	if b<j then qsort(b,j);
end;

begin
	assign(input,'grading.in');reset(input);
	assign(output,'grading.out');rewrite(output);
	read(n);
	for i:=1 to n do begin
		read(a[i,0]);
		a[i,1]:=i;
	end;
	qsort(1,n);
	m:=0;l[0]:=0;
	for i:=1 to n do begin
		if a[i,0]>l[m] then begin inc(m);l[m]:=a[i,0] end;
		b[a[i,1]]:=m;
	end;
	//f[i,j]:=min(f[i-1,k])+a[i]-b[j]
	ans:=inf;
	for i:=0 to m do f[1,i]:=abs(l[b[1]]-l[i]);
	for i:=2 to n do begin
		p:=inf;i1:=i mod 2;i0:=1-i1;
		for j:=0 to m do begin
			p:=min(p,f[i0,j]);
			f[i1,j]:=p+abs(l[b[i]]-l[j]);
			if i=n then ans:=min(ans,f[i1,j]);
		end;
	end;
	for i:=2 to n do begin
		p:=inf;i1:=i mod 2;i0:=1-i1;
		for j:=m downto 0 do begin
			p:=min(p,f[i0,j]);
			f[i1,j]:=p+abs(l[b[i]]-l[j]);
			if i=n then ans:=min(ans,f[i1,j]);
		end;
	end;
	write(ans);
	close(input);close(output);
end.
