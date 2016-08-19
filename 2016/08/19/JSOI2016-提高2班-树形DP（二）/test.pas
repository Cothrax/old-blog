uses math;
type 
    int=longint;
var 
    br,ch,w:array[0..210] of int;
    f:array[0..210,0..210] of int;
    n,m,i,a:int;

procedure add(p,c:int);
begin
    br[c]:=ch[p];
    ch[p]:=c;
end;

function dp(v,j:int):int;
var i:int;
begin
    if (v=0) or (v=0) then exit(0);
    if f[v,j]<>-1 then exit(f[v,j]);
    f[v,j]:=0;
    for i:=0 to j-1 do
        f[v,j]:=max(f[v,j],dp(ch[v],i)+w[v]+dp(br[v],j-i-1));
    f[v,j]:=max(f[v,j],dp(br[v],j));
    dp:=f[v,j];
end;

begin
    read(n,m);
    while (n<>0) and (m<>0) do begin
        fillchar(br,sizeof(br),0);
        fillchar(ch,sizeof(ch),0);
        for i:=1 to n do begin
            read(a,w[i]);
            add(a,i);        
        end;
        filldword(f,sizeof(f) div 4,-1);
        writeln(dp(ch[0],m));
        read(n,m);
    end;
end.
