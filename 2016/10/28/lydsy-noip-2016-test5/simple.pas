uses math;
type int=longint;
var n,m,q,g,l,r,ans:int64;i,j,t:int;
function gcd(a,b:int64):int64;
begin if b=0 then gcd:=a else gcd:=gcd(b,a mod b) end;
function cldv(n,m:int64):int64;
begin
	cldv:=n div m;
	if n mod m<>0 then inc(cldv);
end;

begin
	//assign(input,'simple.in');reset(input);
	//assign(output,'simple.out');rewrite(output);
	read(t);
	repeat
		read(n,m,q);g:=gcd(n,m);
		ans:=q;q:=q div g;dec(ans,q);
		n:=n div g;m:=m div g;
		for i:=0 to n-1 do begin
			l:=max(1,cldv(i*m-q,n));
			r:=trunc((i*m-1)/n);
			inc(ans,max(r-l+1,0));
		end;
		writeln(ans);
		dec(t);
	until t=0;
	close(input);close(output);
end.
