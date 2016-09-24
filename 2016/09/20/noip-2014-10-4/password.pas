type int=longint;
const z=500009;
var 
	a:array[0..41] of int;
	hash:array[0..1500000] of int;
	amt:array[0..1500000] of int;
	next:array[0..1500000] of int;
	head:array[0..z] of int;
	sz,n,f,k,w,i:int;cnt:int64;

procedure insert(x:int64);
var i:int;
begin
	i:=(x mod z+z) mod z;
	if head[i]=0 then begin
		inc(sz);head[i]:=sz;
		hash[sz]:=x;inc(amt[sz]);
		exit;
	end;
	i:=head[i];
	while next[i]<>0 do begin
		if hash[i]=x then begin inc(amt[i]);exit end;
		i:=next[i];
	end;
	if hash[i]=x then begin inc(amt[i]);exit end;
	inc(sz);hash[sz]:=x;inc(amt[sz]);next[i]:=sz;
end;

function query(x:int):int;
var i:int;
begin
	i:=head[(x mod z+z) mod z];
	while i<>0 do begin
		if hash[i]=x then exit(i);
		i:=next[i];
	end;
	query:=-1;
end;

procedure dfs(c,x:int);
var t:int;
begin
	if (x=0) and (c=k+1) then begin insert(f);exit end;
	if (x=1) and (c=n+1) then begin
		t:=query(w-f);
		if t<>-1 then inc(cnt,amt[t]);
		exit;
	end;
	inc(f,a[c]);dfs(c+1,x);
	dec(f,a[c]);dfs(c+1,x);
end;

begin
	assign(input,'password.in');reset(input);
	assign(output,'password.out');rewrite(output);
	read(n,w);k:=n shr 1;
	for i:=1 to n do read(a[i]);
	sz:=0;f:=0;dfs(1,0);
	cnt:=0;f:=0;dfs(k+1,1);
	write(cnt);
	close(input);close(output);
end.
