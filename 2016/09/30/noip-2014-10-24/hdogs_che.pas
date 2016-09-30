type int=longint;
var i,j,cnt,t,n,m:int;
begin
	assign(input,'hdogs.in');reset(input);
	assign(output,'hdogs.ans');rewrite(output);
	read(t);
	for i:=1 to t do begin
		read(n,m);
		cnt:=0;
		for j:=1 to m do
			if (j*n mod m)<>0 then inc(cnt);
		writeln(cnt);
	end;
	close(input);close(output);
end.

{
2015-9-27
答案是m-gcd(n,m)
}
