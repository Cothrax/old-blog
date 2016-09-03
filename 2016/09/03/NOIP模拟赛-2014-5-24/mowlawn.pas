type int=longint;
var 
	n,m,i,h,t:int;
	a,sum,f:array[0..100010] of int64;
	q:array[0..200010,0..1] of int64;

procedure push(i,x:int64);
begin
	while (h<=t) and (q[t,1]<=x) do dec(t);
	inc(t);q[t,0]:=i;q[t,1]:=x;
end;

procedure pop(i:int64);
begin
	while (h<=t) and (i-q[h,0]>m) do inc(h);
end;

begin
	assign(input,'mowlawn.in');reset(input);
	assign(output,'mowlawn.out');rewrite(output);
	read(n,m);
	for i:=1 to n do read(a[i]);
	sum[0]:=0;
	for i:=1 to n do sum[i]:=sum[i-1]+a[i];
	h:=1;t:=0;
	for i:=1 to m do begin
		f[i]:=sum[i];
		push(i,f[i-1]-sum[i]);
	end;
	//f[i]:=max{f[j-1]-sum[j]}+sum[i]
	for i:=m+1 to n do begin
		push(i,f[i-1]-sum[i]);
		pop(i);
		f[i]:=q[h,1]+sum[i];
	end;
	write(f[i]);
	close(input);close(output);
end.
