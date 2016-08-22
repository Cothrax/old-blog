uses math;
type int=longint;
var 
    n,m,i,h,t:int;ans:int64;
    sum:array[0..1000010] of int64;
    q:array[0..20000010] of int64;

begin
    assign(input,'sum.in');reset(input);
    assign(output,'sum.out');rewrite(output);
    
    read(n,m);
    for i:=1 to n do read(sum[i]);
    for i:=1 to n do inc(sum[i],sum[i-1]);
    h:=1;t:=0;ans:=0;q[h]:=0;
    for i:=1 to n do begin
        while (h<=t) and (i-q[h]>m) do inc(h);
        ans:=max(ans,sum[i]-sum[q[h]]);
        while (h<=t) and (sum[q[t]]>=sum[i]) do dec(t);
        inc(t);q[t]:=i;
    end;
    write(ans);
    close(input);close(output);
end.
