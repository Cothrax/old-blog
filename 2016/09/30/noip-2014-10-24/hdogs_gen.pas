type int=longint;
var i,t:int;
begin
	assign(output,'hdogs.in');rewrite(output);
	randomize;
	t:=random(1000)+1;
	writeln(t);
	for i:=1 to t do
		writeln(random(10000),' ',random(10000));
	close(output);
end.
