uses math;
type int=longint;
var 
    n,m,i,j,cur:int;ans:int64;
    cnt:array[0..2000010] of int;

begin
    assign(input,'gcd.in');reset(input);
    assign(output,'gcd.out');rewrite(output);

    read(n);m:=0;
    for i:=1 to n do begin
        read(j);
        inc(cnt[j]);
        m:=max(m,j);
    end;
    ans:=0;
    for i:=1 to m do begin
        j:=i;cur:=0;
        while j<=m do begin
            inc(cur,cnt[j]);
            inc(j,i);
        end;
        if cur<2 then continue;
        ans:=max(ans,cur*i);
    end;
    write(ans);

    close(input);close(output);
end.
