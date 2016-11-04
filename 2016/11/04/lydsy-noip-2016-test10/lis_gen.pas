type int=longint;
var i:int;
begin
	assign(output,'lis.in');rewrite(output);
	randomize;
	writeln(random(100000000000)+1);
	for i:=1 to 5 do write(random(150)+1,' ');
	close(output);
end.
