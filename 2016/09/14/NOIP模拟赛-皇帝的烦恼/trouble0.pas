uses math;
type int=longint;
var 
	a,lb,ub:array[0..100010] of int;
	n,i,l,r,mid,ans:int;

function jud(x:int):boolean;
var i:int;
begin
	lb[1]:=a[1];ub[1]:=a[1];
	for i:=2 to n do begin
		ub[i]:=min(a[i],a[1]-lb[i-1]);
		lb[i]:=max(0,a[i]-(x-a[1]+(a[i-1]-ub[i-1])));
	end;
	jud:=lb[n]=0;
end;

begin
	assign(input,'trouble.in');reset(input);
	assign(output,'trouble.out');rewrite(output);
	read(n);ans:=0;
	for i:=1 to n do begin
		read(a[i]);
		ans:=max(ans,a[i-1]+a[i]);
	end;
	l:=ans;r:=ans*2;
	while l<=r do begin
		mid:=(l+r) shr 1;
		if jud(mid) then begin ans:=mid;r:=mid-1 end
		else l:=mid+1;
	end;
	write(ans);
	close(input);close(output);
end.
