uses math;
type int=longint;
var 
    h:array[0..100010] of int;
    f:array[0..100010,0..1] of int;
    i,j,n,len:int;

begin
    read(n);
    for i:=1 to n do read(h[i]);
    fillchar(f,sizeof(f),0);
    f[1,0]:=1;f[1,1]:=1;len:=1;
    for i:=2 to n do begin
        for j:=1 to i-1 do begin
            if h[i]>h[j] then f[i,1]:=max(f[i,1],f[j,0]+1);
            if h[i]<h[j] then f[i,0]:=max(f[i,0],f[j,1]+1);
        end;
        len:=max(len,max(f[i,0],f[i,1]));
    end;
    write(len);
end.
