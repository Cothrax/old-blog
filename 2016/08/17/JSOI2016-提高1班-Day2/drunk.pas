uses math;
type int=longint;
const 
    q:array[0..1] of int=(1000019,100000007);
    p:array[0..1] of int=(1009,133);
var
    n,m,i,j,k:int;
    s:ansistring;
    pn,f:array[0..1,0..100010] of int64;

function hash(l,r,j:int):int64;
begin
    hash:=(f[j,r]-f[j,l-1]*pn[j,r-l+1] mod q[j]+q[j]) mod q[j];
end;

function query(i,j:int):int;
var l,r,mid:int;
begin
    if i>j then begin l:=i;i:=j;j:=l end;
    l:=1;r:=n-j+1;query:=0;
    while l<=r do begin
        mid:=(l+r) shr 1;
        if (hash(i,i+mid-1,0)=hash(j,j+mid-1,0)) and
           (hash(i,i+mid-1,1)=hash(j,j+mid-1,1)) then begin
            query:=mid;l:=mid+1;
        end else r:=mid-1;
    end;
end;

begin
    assign(input,'drunk.in');reset(input);
    assign(output,'drunk.out');rewrite(output);
    
    readln(n,m);readln(s);
    for i:=0 to 1 do begin f[i,0]:=0;pn[i,0]:=1 end;
    for i:=1 to n do 
        for j:=0 to 1 do begin
            pn[j,i]:=pn[j,i-1]*p[j] mod q[j];
            f[j,i]:=(f[j,i-1]*p[j]+ord(s[i])) mod q[j];
        end;
    
    for i:=1 to m do begin
        read(j,k);
        writeln(query(j,k));
    end;

    close(input);close(output);
end.
