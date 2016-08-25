uses math;
const z=10007;
type int=longint;
var 
	ch,br,s,sz,f:array[0..1010] of int;
	c:array[-1..1010,-1..1010] of int;
	n,i,j,k,t:int;
	
procedure add(p,c:int);
begin
	br[c]:=ch[p];
	ch[p]:=c;
end;	
	
	
procedure dp(v:int);
var sc,sb:int;
begin
	if v=0 then exit;
	dp(ch[v]);sc:=sz[ch[v]];
	dp(br[v]);sb:=sz[br[v]];
	sz[v]:=sc+sb+1;
	f[v]:=(c[sc+sb,sc]*f[ch[v]] mod z)*f[br[v]] mod z;
end;	
	
begin
	assign(input,'t1.in');reset(input);
	assign(output,'t1.out');rewrite(output);
	read(t);
	c[0,0]:=1;
	for i:=1 to 1000 do
		for j:=0 to i do
			c[i,j]:=(c[i-1,j-1]+c[i-1,j]) mod z;
	repeat
		read(n);
		fillchar(ch,sizeof(ch),0);
		fillchar(br,sizeof(br),0);
		for i:=1 to n do begin
			read(k);
			for j:=1 to k do read(s[j]);
			for j:=k downto 1 do add(i,s[j]);
		end;
		f[0]:=1;
		dp(1);
		writeln(f[1]);
		dec(t);
	until t=0;
	close(input);close(output);
end.
