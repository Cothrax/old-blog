uses math;
type int=longint;
const inf=100000000;
var 
	a,head,next,mex,ans:array[0..200010] of int;
	flag:array[0..200010] of boolean;
	q:array[0..200010,0..2] of int;
	sgt:array[0..800010] of int;
	n,m,i,j:int;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end; 

procedure qsort(b,e:int);
var x,i,j:int;
begin
	i:=b;j:=e;x:=q[random(e-b)+b,0];
	repeat
		while q[i,0]<x do inc(i);
		while q[j,0]>x do dec(j);
		if i<=j then begin
			swap(q[i,0],q[j,0]);
			swap(q[i,1],q[j,1]);
			swap(q[i,2],q[j,2]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<e then qsort(i,e);
	if b<j then qsort(b,j);
end;

procedure build(i,b,e:int);
var mid:int;
begin
	if b=e then begin sgt[i]:=mex[b];exit end;
	sgt[i]:=inf;
	mid:=(b+e) shr 1;
	build(i*2,b,mid);
	build(i*2+1,mid+1,e);
end;

procedure pushdown(i,b,e:int);
begin
	if b<e then begin
		sgt[i*2]:=min(sgt[i*2],sgt[i]);
		sgt[i*2+1]:=min(sgt[i*2+1],sgt[i]);
	end;
	sgt[i]:=inf;
end;

procedure update(i,b,e,l,r,x:int);
var mid:int;
begin
	if (r<b) or (e<l) then exit;
	if (l<=b) and (e<=r) then begin 
		sgt[i]:=min(sgt[i],x);
		exit;
	end;
	if sgt[i]<>inf then pushdown(i,b,e);
	mid:=(b+e) shr 1;
	update(i*2,b,mid,l,r,x);
	update(i*2+1,mid+1,e,l,r,x);
end;

function query(i,b,e,x:int):int;
var mid:int;
begin
	if b=e then exit(sgt[i]);
	if sgt[i]<>inf then pushdown(i,b,e);
	mid:=(b+e) shr 1;
	if x<=mid then query:=query(i*2,b,mid,x)
	else query:=query(i*2+1,mid+1,e,x);
end;

begin
	assign(input,'mex.in');reset(input);
	assign(output,'mex.out');rewrite(output);
	read(n,m);
	for i:=1 to n do read(a[i]);
	for i:=1 to m do begin
		read(q[i,0],q[i,1]);
		q[i,2]:=i;
	end;
	j:=0;
	fillchar(flag,sizeof(flag),false);
	for i:=1 to n do begin
		flag[a[i]]:=true;
		while flag[j] do inc(j);
		mex[i]:=j;
	end;
	fillchar(head,sizeof(head),0);
	for i:=n downto 1 do begin
		next[i]:=head[a[i]];
		head[a[i]]:=i;
	end;
	for i:=1 to n do if next[i]=0 then next[i]:=n+1;
	qsort(1,m);
	build(1,1,n);
	j:=1;
	for i:=1 to m do begin
		while j<q[i,0] do begin
			update(1,1,n,j,next[j]-1,a[j]);
			inc(j);
		end;
		ans[q[i,2]]:=query(1,1,n,q[i,1]);
	end;
	for i:=1 to m do writeln(ans[i]);
	close(input);close(output);
end.
