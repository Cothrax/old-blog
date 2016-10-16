type 
	int=longint;
	sort=array[0..30010,0..1] of qword;
var 
	a,q:sort;
	b,l,ans:array[0..30010] of qword;
	sgt:array[0..120010] of int;
	n,m,k,lst,i:int;

procedure swap(var a,b:qword);
var tmp:qword;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(var a:sort;l,r:int);
var i,j:int;x:qword;
begin
	i:=l;j:=r;x:=a[random(r-l)+l,0];
	repeat
		while a[i,0]<x do inc(i);
		while a[j,0]>x do dec(j);
		if i<=j then begin
			swap(a[i,0],a[j,0]);swap(a[i,1],a[j,1]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(a,i,r);
	if l<j then qsort(a,l,j);
end;

procedure insert(i,b,e,x:int);
var l,r,mid:int;
begin
	if b=e then begin inc(sgt[i]);exit end;
	l:=i shl 1;r:=l or 1;mid:=(b+e) shr 1;
	if x<=mid then insert(l,b,mid,x)
	else insert(r,mid+1,e,x);
	sgt[i]:=sgt[l]+sgt[r];
end;

function query(i,b,e,x:int):int;
var mid,l,r:int;
begin
	if b=e then exit(b);
	l:=i shl 1;r:=l or 1;mid:=(b+e) shr 1;
	if sgt[l]>=x then query:=query(l,b,mid,x)
	else query:=query(r,mid+1,e,x-sgt[l]);
end;

begin
	assign(input,'rollcall.in');reset(input);
	assign(output,'rollcall.out');rewrite(output);
	read(n,m);
	for i:=1 to n do begin read(a[i,0]);a[i,1]:=i end;
	for i:=1 to m do begin read(q[i,0]);q[i,1]:=i end;
	qsort(a,1,n);qsort(q,1,m);
	k:=0;lst:=0;
	for i:=1 to n do begin
		if a[i,0]>a[lst,0] then begin 
			inc(k);l[k]:=a[i,0];lst:=i;
		end;
		b[a[i,1]]:=k;
	end;
	k:=1;
	for i:=1 to n do begin
		insert(1,1,n,b[i]);
		while q[k,0]=i do begin
			ans[q[k,1]]:=l[query(1,1,n,q[k,1])];inc(k)
		end;
	end;
	for i:=1 to m do writeln(ans[i]);
	close(input);close(output);
end.
