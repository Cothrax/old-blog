type int=longint;
var 
	i,j,n:int;
	mat:array[0..1500,0..1500] of byte;
begin
	assign(output,'tour.in');rewrite(output);
	randomize;n:=1500;
	writeln(n);
	for i:=1 to n do
		for j:=i+1 to n do begin
			mat[i,j]:=random(2);
			mat[j,i]:=mat[i,j];
		end;
	for i:=1 to n do begin
		for j:=1 to n do write(mat[i,j]);
		writeln;
	end;
	close(output);
end.
