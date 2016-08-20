uses math;
type int=longint;
var 
    n,m,i,j,k,d,h,t,ans:int;
    c,w,a:array[0..110] of int; //费用,价值,数量
    f:array[0..10010] of int;
    q:array[0..10010,0..1] of int;

begin
    assign(input,'war.in');reset(input);
    assign(output,'war.out');rewrite(output);
    read(n,m);
    for i:=1 to n do read(c[i],w[i],a[i]);
    d:=0;
    for i:=1 to n do begin
        d:=min(m,d+c[i]*a[i]);
        for j:=0 to c[i]-1 do begin
            h:=1;t:=0;k:=0;
            while j+c[i]*k<=d do begin
                while (h<=t) and (q[t,0]<=f[j+c[i]*k]-w[i]*k) do dec(t);
                inc(t);q[t,1]:=k;q[t,0]:=f[j+c[i]*k]-w[i]*k;
                while (h<=t) and (k-q[h,1]>a[i]) do inc(h);
                f[j+c[i]*k]:=max(f[j+c[i]*k],q[h,0]+k*w[i]);
                inc(k);
            end;
        end;
    end;
    ans:=0;
    for i:=1 to m do ans:=max(ans,f[i]);
    write(ans);
    close(input);close(output);
end.