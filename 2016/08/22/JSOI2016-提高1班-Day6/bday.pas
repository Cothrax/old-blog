const 
	maxn=2000000;
	sz=500009;
type 
	int=longint;
	node=record i,next:int end;
var 
	h:array[0..sz] of int;
	t:array[0..maxn] of node;
	a:array[0..41] of int;
	n,m,hsz,i,k:int;flag:boolean;

function hash(k:int):int;
begin hash:=k mod sz end;

procedure insert(k:int);
var j:int;
begin
	inc(hsz);
	j:=hash(k);
	t[hsz].next:=h[j];t[hsz].i:=k;
	h[j]:=hsz;
end;

function query(k:int):boolean;
var i:int;
begin
	if k<0 then exit(false);
	i:=h[hash(k)];
	while i<>0 do begin
		if t[i].i=k then exit(true);
		i:=t[i].next;
	end;
	query:=false;
end;

procedure dfs(x,w,s:int);
begin
	if flag then exit;
	if (s=0) and (x=k+1) then begin insert(w);exit end;
	if (s=1) and (x=n+1) then begin
		if query(m-w) then flag:=true;
		exit;
	end;
	dfs(x+1,w+a[x],s);
	dfs(x+1,w,s);
end;

begin
	assign(input,'bday.in');reset(input);
	assign(output,'bday.out');rewrite(output);
	read(n,m);
	while (n<>0) and (m<>0) do begin
		k:=n div 2;
		for i:=1 to n do read(a[i]);
		fillchar(h,sizeof(h),0);hsz:=0;
		flag:=false;
		dfs(1,0,0);dfs(k+1,0,1);
		if flag then writeln('YES') else writeln('NO');
		read(n,m);
	end;
	close(input);close(output);
end.
