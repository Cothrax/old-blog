uses math;
type int=longint;
var 
    n,m,k,i,j,t,lowbit:int;
    f,p:array[0..(1 shl 16)-1] of int;
    a:array[0..17] of int;

begin
    assign(input,'hacker.in');reset(input);
    assign(output,'hacker.out');rewrite(output);

    read(n);
    k:=(1 shl n)-1;
    for i:=0 to n-1 do begin
        read(m);
        a[i]:=1 shl i;
        for j:=1 to m do begin
            read(t);
            a[i]:=a[i] or (1 shl t);
        end;
    end;
    for i:=0 to k do begin
        t:=i;
        p[i]:=0;
        while t>0 do begin
            lowbit:=t and (-t);
            p[i]:=p[i] or a[round(ln(lowbit)/ln(2))];
            t:=t-lowbit;
        end;
    end;
    for i:=1 to k do begin
        f[i]:=0;j:=i;
        while j<>0 do begin
            if p[j]=k then f[i]:=max(f[i xor j]+1,f[i]);
            j:=(j-1) and i;
        end;
    end;
    write(f[k]);

    close(input);close(output);
end.
