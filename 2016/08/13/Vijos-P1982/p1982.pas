uses math;
type int=longint;
const z=1000000007;
var 
    n,m,k,i,i0,i1,j,t,l:int;
    f:array[0..1,0..1010,0..210] of int;
    a,b:ansistring;

begin
    readln(n,m,k);
    readln(a);readln(b);
    for i:=0 to n do f[0,i,0]:=1;
    for i:=1 to k do begin
        i0:=i mod 2;i1:=(i+1) mod 2;
        fillchar(f[i0],sizeof(f[i0]),0);
        for j:=1 to n do
            for t:=1 to m do begin
                f[i0,j,t]:=f[i0,j-1,t];
                l:=0;
                while a[j-l]=b[t-l] do begin
                    if l>=min(j,t) then break;
                    f[i0,j,t]:=(f[i0,j,t]+f[i1,j-l-1,t-l-1]) mod z;
                    inc(l);
                end;
            end;
    end;
    write(f[k mod 2,n,m]);
end.
