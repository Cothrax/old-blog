uses math;
type int=longint;
var 
	tmp,a:array[0..1000010] of int;
	n,k,p,i,j,ans:int;

begin
	assign(input,'jkl.in');reset(input);
	assign(output,'jkl.ans');rewrite(output);
	read(n,k);
	for i:=1 to n do read(a[i]);
	tmp:=a;a[0]:=0;ans:=0;
	for i:=1 to k do begin
		p:=0;
		for j:=1 to n do
			if a[j]>a[p] then p:=j;
		inc(ans,a[p]);dec(a[p]);	
	end;
	write(ans,' ');
	a:=tmp;a[0]:=maxlongint;ans:=0;
	for i:=1 to k do begin
		p:=0;
		for j:=1 to n do
			if (a[j]>0) and (a[j]<a[p]) then p:=j;
		inc(ans,a[p]);dec(a[p]);
	end;
	write(ans);
	close(input);close(output);
end.
