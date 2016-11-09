uses math;
type int=longint;
var 
	n,m,i:int;ans:double;
	a:array[0..100010,0..1] of int;
	b,l:array[0..100010] of int;
	bit,lis,lds:array[0..100010] of int64;

procedure qsort(l,r:int);
var i,j,x:int;tmp:array[0..1] of int;
begin
	i:=l;j:=r;x:=a[random(r-l)+l,0];
	repeat
		while a[i,0]<x do inc(i);
		while a[j,0]>x do dec(j);
		if i<=j then begin
			tmp:=a[i];a[i]:=a[j];a[j]:=tmp;
			inc(i);dec(j);
		end;
	until i>j;
	if l<j then qsort(l,j);
	if i<r then qsort(i,r);
end;

function query(x:int):int64;
begin
	query:=0;
	while x>0 do begin
		query:=max(query,bit[x]);
		x:=x and (x-1);
	end;
end;

procedure add(x:int;k:int64);
begin
	while x<=n do begin
		bit[x]:=max(bit[x],k);
		inc(x,x and (-x));
	end;
end;

begin
	assign(input,'seq.in');reset(input);
	assign(output,'seq.out');rewrite(output);
	read(n);
	for i:=1 to n do read(a[i,0]);
	for i:=1 to n do a[i,1]:=i;
	qsort(1,n);m:=0;l[m]:=0;
	for i:=1 to n do begin
		if a[i,0]>l[m] then begin inc(m);l[m]:=a[i,0] end;
		b[a[i,1]]:=m;
	end;
	//f[i]=max(f[j])+a[i] i<j&&a[i]<=a[j] max(1..a[j]) of f[]
	for i:=1 to n do begin
		lis[i]:=query(b[i]-1)+l[b[i]];
		add(b[i],lis[i]);
	end;
	fillchar(bit,sizeof(bit),0);
	for i:=n downto 1 do begin
		lds[i]:=query(b[i]-1)+l[b[i]];
		add(b[i],lds[i]);
	end;
	for i:=2 to n do lis[i]:=max(lis[i],lis[i-1]);
	for i:=n-1 downto 1 do lds[i]:=max(lds[i],lds[i+1]);
	ans:=lis[n];
	for i:=1 to n-1 do ans:=max(ans,(lis[i]+lds[i+1])/2);
	write(ans:0:3);
	close(input);close(output);
end.
