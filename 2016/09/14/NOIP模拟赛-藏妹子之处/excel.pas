uses math;
type int=longint;
const inf=1000000007;
var n,m,i,j,mi,mx:int;ans:qword;
begin
	assign(input,'excel.in');reset(input);
	assign(output,'excel.out');rewrite(output);
	read(n,m,mi,mx);
	ans:=0;
	for i:=3 to n do
		for j:=3 to m do
			if (2*(i+j-2)>=mi) and (2*(i+j-2)<=mx) then begin
				ans:=ans+6*(i-2)*(j-2)*(n-i+1)*(m-j+1);
				if ans>inf then ans:=ans mod inf;
			end;
	write(ans);
	close(input);close(output);
end.
