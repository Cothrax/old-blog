type 
	int=longint;
	arr=array[0..50010] of int64;
var 
	sum,squ,a,b:arr;
	n,i,p:int;sa,sb:int64;
	
procedure swap(var a,b:int64);
var tmp:int64;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(var b:arr;l,r:int);
var i,j:int;x:int64;
begin
	i:=l;j:=r;x:=b[random(r-l)+l];
	repeat
		while b[i]<x do inc(i);
		while b[j]>x do dec(j);
		if i<=j then begin
			swap(b[i],b[j]);
			inc(i);dec(j);
		end;
	until i>j;
	if i<r then qsort(b,i,r);
	if l<j then qsort(b,l,j);
end;

begin
	assign(input,'mat.in');reset(input);
	assign(output,'mat.out');rewrite(output);
	read(n);
	for i:=1 to n do read(a[i]);
	for i:=1 to n do read(b[i]);
	qsort(a,1,n);qsort(b,1,n);
	sum[0]:=0;squ[0]:=0;
	for i:=1 to n do begin
		sum[i]:=sum[i-1]+b[i];
		squ[i]:=squ[i-1]+sqr(b[i]);
	end;
	p:=1;sa:=0;sb:=0;
	for i:=1 to n do begin
		while (p<=n) and (b[p]<=a[i]) do inc(p);
		sa:=sa+(p-1)*sqr(a[i])-2*a[i]*sum[p-1]+squ[p-1];
		sb:=sb+(n-p+1)*sqr(a[i])-2*a[i]*(sum[n]-sum[p-1])
			+squ[n]-squ[p-1];
	end;
	write((sa-sb)/n:0:1);
	close(input);close(output);
end.

{
考虑a中的每个点对答案的贡献
维护前缀和和前缀平方和
qsort+指针
注意点：a数组设为int64，int与int64混合计算可能溢出
}
