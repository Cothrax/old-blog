uses math;
type int=longint;
var n,i,j,sum,mxl:int;

begin
	while not eof do begin
		readln(n);
		mxl:=0;sum:=0;
		for i:=1 to n do begin
			read(j);
			mxl:=max(mxl,j);
			inc(sum,j);
		end;
		readln;
		writeln(min((sum-mxl)/1,sum/2):0:1);
	end;
end.
