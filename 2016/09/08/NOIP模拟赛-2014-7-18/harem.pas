uses math;
type int=longint;
var 
	n,m,k,b,i,j,l,r,tot:int;
	q:array[0..100010,0..3] of int;
	a,ans,cnt:array[0..100010] of int;

function com(i,j:int):boolean;
begin
	com:=(q[i,3]<q[j,3]) or ((q[i,3]=q[j,3]) and (q[i,2]<q[j,2]));
end;

procedure qsort(l,r:int);
var 
	tmp:array[0..3] of int;
	i,j:int;
begin
	i:=l;j:=r;q[0]:=q[random(r-l)+l];
	repeat
		while com(i,0) do inc(i);
		while com(0,j) do dec(j);
		if i<=j then begin
			tmp:=q[i];q[i]:=q[j];q[j]:=tmp;
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(i,r);
	if l<j then qsort(l,j);
end;

procedure update(i,x:int);
begin
	if not odd(cnt[i]) and (cnt[i]<>0) then dec(tot);
	inc(cnt[i],x);
	if not odd(cnt[i]) and (cnt[i]<>0) then inc(tot);
end;

begin
	assign(input,'harem.in');reset(input);
	assign(output,'harem.out');rewrite(output);
	read(n,k,m);b:=floor(sqrt(n));
	for i:=1 to n do read(a[i]);
	for i:=1 to m do begin
		read(q[i,1],q[i,2]);
		q[i,0]:=i;
		q[i,3]:=(q[i,1]-1) div b+1;
	end;
	qsort(1,m);
	l:=1;r:=0;tot:=0;
	for i:=1 to m do begin
		for j:=r+1 to q[i,2] do update(a[j],1);
		for j:=r downto q[i,2]+1 do update(a[j],-1);
		for j:=l to q[i,1]-1 do update(a[j],-1);
		for j:=l-1 downto q[i,1] do update(a[j],1);
		l:=q[i,1];r:=q[i,2];
		ans[q[i,0]]:=tot;
	end;
	for i:=1 to m do writeln(ans[i]);
	close(input);close(output);
end.
