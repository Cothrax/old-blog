uses math;
const inf=100000000;
type int=longint;
var 
	n,m,i,ans:int;s:ansistring;c1,c2:char;
	f:array[0..100010,'a'..'z'] of int;
	g:array['a'..'z','a'..'z'] of boolean;
	
	
begin
	assign(input,'note.in');reset(input);
	assign(output,'note.out');rewrite(output);
	filldword(f,sizeof(f) div 4,inf);
	fillchar(g,sizeof(g),true);
	readln(n);readln(s);readln(m);
	if m=0 then begin write(0);halt end;
	for i:=1 to m do begin
		readln(c1,c2);
		g[c1,c2]:=false;g[c2,c1]:=false;
	end;
	
	for i:=1 to n do f[i,s[i]]:=i-1;
	for i:=2 to n do
		for c1:='a' to 'z' do begin
			if s[i]=c1 then
				for c2:='a' to 'z' do
					if g[c1,c2] then
						f[i,c1]:=min(f[i,c1],f[i-1,c2]);
			f[i,c1]:=min(f[i,c1],f[i-1,c1]+1);
		end;
	ans:=n;
	for c1:='a' to 'z' do
		ans:=min(ans,f[n,c1]);
	write(ans);
	close(input);close(output);
end.
