type int=longint;
var
	n,sz,i,cnt:int;ans:int64;
	a,t:array[0..100010] of int;
	h:array[0..200010] of int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure heapify(i:int);
var l,r,s:int;
begin
	l:=i*2;r:=i*2+1;
	if (l<=sz) and (h[l]<h[i]) then s:=l else s:=i;
	if (r<=sz) and (h[r]<h[s]) then s:=r;
	if i<>s then begin
		swap(h[i],h[s]);heapify(s);
	end;
end;

function extract():int;
begin extract:=h[1];h[1]:=h[sz];dec(sz);heapify(1) end;

procedure insert(x:int);
var i:int;
begin
	inc(sz);h[sz]:=x;i:=sz;
	while (i>1) and (h[i]<h[i shr 1]) do begin
		swap(h[i],h[i shr 1]);i:=i shr 1;
	end;
end;

procedure qsort(l,r:int);
var i,j,x:int;
begin
	i:=l;j:=r;x:=t[random(r-l)+l];
	repeat
		while t[i]<x do inc(i);
		while t[j]>x do dec(j);
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
	qsort(1,n);
	sz:=0;cnt:=0;ans:=0;
	for i:=1 to n do begin
		inc(cnt);inc(ans,a[i]);insert(a[i]);
		while cnt>t[i] do begin
			dec(cnt);dec(ans,extract);
		end;
	end;
	write(ans);
	close(input);close(output);
end.
