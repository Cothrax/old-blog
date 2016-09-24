type int=longint;
var a,b,x,y,g:int;

function gcd(a,b:int):int;
begin
	if b=0 then gcd:=a else gcd:=gcd(b,a mod b);
end;

procedure extgcd(a,b:int;var x,y:int);
begin
	if b=0 then begin
		x:=1;y:=0;
	end else begin
		extgcd(b,a mod b,y,x);
		dec(y,(a div b)*x);
	end;
end;

begin
	assign(input,'pour.in');reset(input);
	assign(output,'pour.out');rewrite(output);
	read(a,b);
	g:=gcd(a,b);
	writeln(g,' ');
	a:=a div g;b:=b div g;
	extgcd(a,b,x,y);
	while x>0 do begin
		dec(x,b);inc(y,a);
	end;
	while x+b<0 do begin
		inc(x,b);dec(y,a);
	end;
	write(-x,' ',y);
	close(input);close(output);
end.

{
扩展欧几里得
}
