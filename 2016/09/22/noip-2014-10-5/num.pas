type int=longint;
const z=999983;
var
	f:array[0..1010,0..10010] of int64;
	a:array[0..10] of int;
	n,m,i,j,k:int;s:string;
	ans,od,ev:int64;p:^int64;

function cal(n:int):int64;
var i:int;
begin
	cal:=0;
	for i:=0 to n*9 do cal:=(cal+sqr(f[n,i])) mod z;
end;

begin
	assign(input,'num.in');reset(input);
	assign(output,'num.out');rewrite(output);
	readln(n);readln(s);
	m:=length(s);
	for i:=1 to m do a[i]:=ord(s[i])-ord('0');
	fillchar(f,sizeof(f),0);
	f[0,0]:=1;
	for i:=0 to n do
		for j:=0 to i*9 do
			if f[i,j]>0 then
				for k:=1 to m do begin
					p:=@f[i+1,j+a[k]];
					p^:=(p^+f[i,j]) mod z;
				end;
	ans:=cal(n);ev:=cal(n shr 1);od:=cal((n+1) shr 1);
	write((ans*2+z-ev*od mod z) mod z); 
	close(input);close(output);
end.

{
dp+组合数学+容斥
http://www.voidcn.com/blog/pzler/article/p-2260743.html
}
