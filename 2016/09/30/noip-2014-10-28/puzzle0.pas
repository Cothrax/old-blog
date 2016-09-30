{TLE}
type int=longint;
var
	a,g:array[0..21] of int64;
	f:array[0..21,0..21] of int64;
	c:array[0..21] of char;
	n,m,i,j,dep,ans,cur,l,r:int;s:string;
	
function jud(d:int):boolean;
var 
	k,i:int;p:int64;
	h:array[0..21] of int64;
begin
	//d+1 num, d oper
	p:=g[1];k:=0;
	for i:=1 to d do
		if c[i]='+' then begin
			inc(k);h[k]:=p;p:=g[i+1];
		end else
			p:=p*g[i+1];
	inc(k);h[k]:=p;p:=0;
	for i:=1 to k do inc(p,h[i]);
	jud:=p=m;
end;

procedure dfs(x,p,d:int);
begin
	if (cur<>-1) or (d>dep) then exit;
	if x=n+1 then begin
		g[d+1]:=f[p,n];
		if jud(d) then cur:=d;exit;
	end;
	dfs(x+1,p,d);
	if x=n then exit;
	g[d+1]:=f[p,x];c[d+1]:='+';
	dfs(x+1,x+1,d+1);
	c[d+1]:='*';
	dfs(x+1,x+1,d+1);
end;

begin
	assign(input,'puzzle.in');reset(input);
	assign(output,'puzzle.out');rewrite(output);
	repeat
		readln(s);readln(m);
		if m<0 then break;
		n:=length(s);
		for i:=1 to n do a[i]:=ord(s[i])-ord('0');
		fillchar(f,sizeof(f),0);
		for i:=1 to n do
			for j:=i to n do
				f[i,j]:=f[i,j-1]*10+a[j];
		l:=0;r:=n-1;ans:=-1;
		while l<=r do begin
			dep:=(l+r) shr 1;
			cur:=-1;dfs(1,1,0);
			if cur<>-1 then begin ans:=cur;r:=dep-1 end
			else l:=dep+1;
		end;
		writeln(ans);
	until false;
	close(input);close(output);
end.
