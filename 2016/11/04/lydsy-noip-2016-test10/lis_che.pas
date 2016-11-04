uses math;
type int=longint;
var 
	s,f:array[0..50010] of int;
	n,a,b,c,d,i,j,ans,lst,cnt:int;
begin
	assign(input,'lis.in');reset(input);
	//assign(output,'lis.ans');rewrite(output);
	read(n,s[1],a,b,c,d);
	for i:=2 to n do
		s[i]:=(a*sqr(s[i-1])+b*s[i-1]+c)mod d;
	//for i:=1 to n do write(s[i],' ');
	writeln;writeln;
	for i:=1 to n do
		for j:=i-1 downto 0 do
			if s[j]<=s[i] then
				f[i]:=max(f[i],f[j]+1);
	ans:=0;
	for i:=1 to n do 
		if f[i]>ans then
			begin ans:=max(ans,f[i]);j:=i end;
	writeln;lst:=s[j];cnt:=1;
	while j>0 do begin
		for i:=j downto 0 do
			if f[i]+1=f[j] then
				begin j:=i;break end;
		if s[j]=lst then inc(cnt)
		else begin writeln(lst,'*',cnt);cnt:=1;lst:=s[j] end;
	end;
	write(ans);
	close(input);close(output);
end.
