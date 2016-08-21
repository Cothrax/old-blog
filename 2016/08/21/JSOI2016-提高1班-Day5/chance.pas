uses math;
var 
    n,k,i,j:longint;l,r:int64;
    p:array[0..2010] of double;
    f:array[0..2010,-1..2010] of double;
    ans:double;

function cal():double;
var x,y,tot:int64;i:longint;
begin
    read(l,r);
    x:=1;tot:=0;
    for i:=1 to 18 do begin
        if x>r then break;
        y:=2*x-1;
        if y>=l then
            inc(tot,min(y,r)-max(l,x)+1);
        x:=x*10;
    end;
    cal:=tot/(r-l+1);
end;

begin
    assign(input,'chance.in');reset(input);
    assign(output,'chance.out');rewrite(output);
    read(n,k);
    ans:=0;
    for i:=1 to n do p[i]:=cal();
    f[0,0]:=1;
    for i:=1 to n do
        for j:=0 to n do
            f[i,j]:=f[i-1,j-1]*p[i]+f[i-1,j]*(1-p[i]); 
    ans:=0;
    for i:=ceil(n*k/100) to n do
        ans:=ans+f[n,i];
    write(ans:0:7);
    close(input);close(output);
end.
