type int=longint;
var 
	p,f:array[0..200010] of int;
	s:ansistring;
	n,i,j,ans:int;

begin
	assign(input,'prefix.in');reset(input);
	assign(output,'prefix.out');rewrite(output);
	readln(s);n:=length(s);
	p[1]:=0;j:=0;
	for i:=2 to n do begin
		while (j>0) and (s[j+1]<>s[i]) do j:=p[j];
		if s[j+1]=s[i] then inc(j);
		p[i]:=j; 
	end;
	ans:=0;
	fillchar(f,sizeof(f),0);
	for i:=2 to n do begin
		if (i and 1)=0 then inc(f[i]);
		inc(f[i],f[p[i]]);
		inc(ans,f[i]);
	end;
	write(ans);
	close(input);close(output);
end.

