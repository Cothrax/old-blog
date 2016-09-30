type int=longint;
var t,i:int;n,m:qword;

function gcd(a,b:qword):qword;
begin
	if b=0 then gcd:=a else gcd:=gcd(b,a mod b);
end;

begin
	assign(input,'hdogs.in');reset(input);
	assign(output,'hdogs.out');rewrite(output);
	read(t);
	for i:=1 to t do begin
		read(n,m);
		writeln(m-gcd(n,m));
	end;
	close(input);close(output);
end.
