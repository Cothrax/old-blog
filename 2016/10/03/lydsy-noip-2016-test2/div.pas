uses math;
type int=longint;
const md=1001003;
var
	a,ans:array[0..210] of int;
	h,next,cnt:array[0..10000000] of int;
	head:array[0..md] of int;
	sz,n,m,i,tot:int;

procedure insert(x:int);
var i,j:int;
begin
	j:=x mod md;
	if head[j]=0 then begin
		inc(sz);head[j]:=sz;
		h[sz]:=x;cnt[sz]:=1;
		exit;
	end;
	i:=head[j];
	while next[i]<>0 do begin
		if h[i]=x then begin inc(cnt[i]);exit end;
		i:=next[i];
	end;
	if h[i]=x then begin inc(cnt[i]);exit end;
	inc(sz);next[i]:=sz;
	h[sz]:=x;cnt[sz]:=1;
end;

procedure calc(x:int);
var i:int;
begin
	for i:=1 to trunc(sqrt(x)) do
		if x mod i=0 then begin
			insert(i);
			if i<>x div i then insert(x div i);
		end;
end;

begin
	//assign(input,'div.in');reset(input);
	//assign(output,'div.out');rewrite(output);
	read(n,m);
	sz:=0;
	for i:=1 to m do read(a[i]);
	for i:=1 to m do calc(a[i]);
	tot:=0;
	for i:=1 to sz do 
		if h[i]<=n then begin
			inc(tot);
			if cnt[i]<=m then inc(ans[cnt[i]]);
		end;
	writeln(n-tot);
	for i:=1 to m do writeln(ans[i]);
	//close(input);close(output);
end.
