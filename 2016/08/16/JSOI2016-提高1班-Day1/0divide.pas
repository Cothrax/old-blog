uses math;
const inf=1000000000;
type int=longint;
var 
    n,l,a,b,h,t,i,x:int;
    q:array[0..10010,0..1] of int;
    c,f:array[0..1000010] of int;

begin
    assign(input,'divide.in');reset(input);
    assign(output,'divide.out');rewrite(output);
    
    read(n,l,a,b);
    for i:=1 to n do begin
        read(h,t);
        inc(c[h+1]);dec(c[t]);
    end;
    for i:=1 to l do inc(c[i],c[i-1]);

    filldword(f,sizeof(f) div 4,inf);
    f[0]:=0;
    h:=0;t:=0;i:=2;
    while i<=l do begin
        x:=i-2*a;
        if x>=0 then begin
            while (h<>t) and (q[t-1,0]>=f[x]) do dec(t);
            q[t,0]:=f[x];q[t,1]:=x;
            inc(t);if t>10010 then t:=0;
        end;
        if c[i]=0 then begin
            x:=i-2*b;
            while (h<>t) and (q[h,1]<x) do begin
                inc(h);if h>10010 then h:=0;
            end;
            if (h=t) or (q[h,0]=inf) then f[i]:=inf else f[i]:=q[h,0]+1;
        end;
        inc(i,2);
    end;
    if f[l]=inf then write(-1) else write(f[l]);

    close(input);close(output);
end.
