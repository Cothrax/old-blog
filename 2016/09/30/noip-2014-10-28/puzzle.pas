uses math;
type int=longint;
const inf=100;
var
	a:array[0..21] of int;
	f:array[0..21,0..21] of int;
	b:array[0..21] of boolean;
	n,m,i,j,ans:int;s:string;

procedure dfs(x,p,s,c,d:int);
begin
	if (d>ans) or (s>m) then exit;
	if x=n+1 then begin
		inc(s,c*f[p,n]);
		if s=m then ans:=min(ans,d);
		exit;
	end;
	if b[x] and (f[p,x]<>0) and (s+c>m) then exit;
	dfs(x+1,p,s,c,d);
	if x=n then exit;
	dfs(x+1,x+1,s+c*f[p,x],1,d+1);
	dfs(x+1,x+1,s,c*f[p,x],d+1);
end;

begin
	assign(input,'puzzle.in');reset(input);
	assign(output,'puzzle.out');rewrite(output);
	while true do begin
		readln(s);readln(m);
		if m<0 then break;
		n:=length(s);
		for i:=1 to n do a[i]:=ord(s[i])-ord('0');
		fillchar(f,sizeof(f),0);
		for i:=1 to n do
			for j:=i to n do
				f[i,j]:=min(m+1,f[i,j-1]*10+a[j]);
		fillchar(b,sizeof(b),true);
		for i:=1 to n do
			if a[i]=0 then
				for j:=i downto 1 do
					b[j]:=false;
		ans:=inf;
		dfs(1,1,0,1,0);
		if ans=inf then writeln(-1) else writeln(ans);
	end;
	close(input);close(output);
end.
