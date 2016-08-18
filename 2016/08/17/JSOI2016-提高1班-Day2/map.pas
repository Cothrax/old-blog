uses math;
const inf=100000000;
type int=longint;
var 
    f:array[0..1110,0..1110] of int;
    n,m,l,k,i,j,tmp:int;

begin
    assign(input,'map.in');reset(input);
    assign(output,'map.out');rewrite(output);

    read(n,m);
    filldword(f,sizeof(f) div 4,inf);
    for i:=1 to m do begin
        read(l);
        for j:=1 to l do begin
            read(k);read(tmp);
            f[k,i+n]:=min(f[k,i+n],tmp);
            f[i+n,k]:=f[k,i+n];
        end;
    end;
    for i:=1 to m+n do f[i,i]:=0;
    for k:=1 to m+n do
        for i:=1 to m+n do
            for j:=1 to m+n do
                f[i,j]:=min(f[i,j],f[i,k]+f[k,j]);
    read(i,j);
    while (i<>0) and (j<>0) do begin
        if f[i,j]=inf then writeln(-1) else writeln(f[i,j]);
        read(i,j);
    end;
end.
