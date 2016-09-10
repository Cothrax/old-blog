uses math;
type int=longint;
var 
	f:array[0..15010] of boolean;
	g:array[0..15010] of int;
	a,k,h:array[0..110] of int;
	n,i,j,ans:int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=h[random(r-l)+l];
	repeat
		while h[i]<x do inc(i);
		while h[j]>x do dec(j);
		if i<=j then begin
			swap(a[i],a[j]);
			swap(h[i],h[j]);
			swap(k[i],k[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

begin
	assign(input,'fly.in');reset(input);
	assign(output,'fly.out');rewrite(output);
	read(n);
	for i:=1 to n do read(a[i],h[i],k[i]);
	qsort(1,n);
	fillchar(f,sizeof(f),false);
	f[0]:=true;ans:=0;
	for i:=1 to n do begin
		fillchar(g,sizeof(g),0);
		for j:=a[i] to h[i] do
			if not f[j] and f[j-a[i]] and 
				(g[j-a[i]]<k[i]) then begin
				f[j]:=true;
				g[j]:=g[j-a[i]]+1;
				ans:=max(ans,j);			
			end;
	end;
	write(ans);
	close(input);close(output);
end.
