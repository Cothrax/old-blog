uses math;
type int=longint;ll=int64;
var	n,m,i,j,k:int;ans:ll;

function c(x:int64):int64;
begin
	if x<3 then exit(0);
	c:=x*(x-ll(1))*(x-ll(2));
end;

function gcd(a,b:int):int;
begin
	if b=0 then gcd:=a else gcd:=gcd(b,a mod b);
end;

begin
	assign(input,'nmtg.in');reset(input);
	assign(output,'nmtg.out');rewrite(output);
	read(n,m);
	inc(n);inc(m);
	ans:=(c(n*m)-m*c(n)-n*c(m)) div 6;
	for i:=1 to n do
		for j:=1 to m do begin
			k:=gcd(i,j)+1;
			if k<=2 then continue;
			dec(ans,(n-i)*(m-j)*(k-2)*2);
		end;
	write(ans);
	close(input);close(output);
end.
