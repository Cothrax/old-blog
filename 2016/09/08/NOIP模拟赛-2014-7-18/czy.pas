type int=longint;
var 
	n,i,j,c,p:int;
	f:array[0..1,0..4210] of int;

begin
	assign(input,'czy.in');reset(input);
	assign(output,'czy.out');rewrite(output);
	read(n,p);
	if n=1 then begin write(1);halt end;
	f[1,1]:=1;
	for i:=2 to n do begin
		c:=i and 1;
		for j:=1 to i do begin
			f[c,j]:=f[c,j-1]+f[c xor 1,i-j];
			if f[c,j]>p then f[c,j]:=f[c,j] mod p;
		end;
	end;
	write(f[n and 1,n]*2 mod p);
	close(input);close(output);
end.
