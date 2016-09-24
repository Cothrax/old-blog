type int=longint;
var n,m:int;
begin
	assign(input,'bishop.in');reset(input);
	assign(output,'bishop.out');rewrite(output);
	read(n,m);
	if n=m then begin
		if n=1 then write(1:3) 
		else write(2*(n-1):3);
	end else begin
		if odd(m) then write(n+m-1:3)
		else write(m+2*((n-1) div 2):3);
	end;
	close(input);close(output);
end.
