type int=longint;
var 
    n,m,i,j,i0,i1:int;
    a:array[0..501] of int;
    f:array[0..1,-501000..501000] of boolean;

begin
    assign(input,'competition.in');reset(input);
    assign(output,'competition.out');rewrite(output);

    read(n);
    m:=0;
    for i:=1 to n do begin
        read(a[i]);
        inc(m,a[i]);
    end;
    fillchar(f,sizeof(f),false);
    f[0,0]:=true;
    for i:=1 to n do begin
        i0:=i mod 2;i1:=1-i0;
        for j:=-m to m do
            f[i0,j]:=f[i1,j-a[i]] or f[i1,j+a[i]];
    end;
    i0:=n mod 2;
    for j:=0 to m do
        if f[i0,j] or f[i0,-j] then begin
            write((m-j) div 2,' ',(m+j) div 2);
            halt
        end;

    close(input);close(output);
end.

