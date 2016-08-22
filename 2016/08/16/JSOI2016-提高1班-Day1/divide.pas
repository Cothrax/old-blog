uses math;
const inf=1000000000;
type int=longint;
var 
    n,l,a,b,i,j,k:int;
    seg:array[0..1010,0..1] of int;
    f:array[-1010..1000010] of int;

function com(x,y:int):boolean;
begin
    if (seg[x,0]<seg[y,0]) or 
       ((seg[x,0]=seg[y,0]) and (seg[x,1]<seg[y,1])) then com:=true
    else com:=false;
end;

procedure swap(var a,b:int);
var tmp:int;
begin tmp:=a;a:=b;b:=tmp end;

procedure qsort(b,e:int);
var i,j:int;
begin
    i:=b;j:=e;seg[0]:=seg[random(e-b)+b];
    repeat
        while com(i,0) do inc(i);
        while com(0,j) do dec(j);
        if i<=j then begin
            swap(seg[i,0],seg[j,0]);swap(seg[i,1],seg[j,1]);
            inc(i);dec(j);
        end;
    until i>j;
    if i<e then qsort(i,e);
    if b<j then qsort(b,j);
end;

begin
    //assign(input,'divide.in');reset(input);
    //assign(output,'divide.out');rewrite(output);

    read(n,l,a,b);
    for i:=1 to n do read(seg[i,0],seg[i,1]);
    qsort(1,n);
    filldword(f,sizeof(f) div 4,inf);
    seg[0,1]:=0;seg[0,0]:=0;seg[n+1,0]:=l;

    f[0]:=0;
    for i:=1 to n+1 do
        for j:=seg[i-1,1] to seg[i,0] do
            for k:=a to b do
                f[j]:=min(f[j],f[j-k*2]+1);
    if f[l]=inf then write(-1) else write(f[l]);
    //close(input);close(output);
end.

{
4 202
10 12
21 27
32 39
103 121
163 180
}
