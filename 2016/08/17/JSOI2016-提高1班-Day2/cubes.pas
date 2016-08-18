type int=longint;
const n=100000;
var 
    par,dist,len:array[0..100010] of int;
    p,i,x,y:int;c:char;

function find(x:int):int;
begin
    if par[x]=x then find:=x
    else begin
        find:=find(par[x]);
        inc(dist[x],dist[par[x]]);
        par[x]:=find;
    end;
end;

procedure union(x,y:int);
begin
    x:=find(x);y:=find(y);
    par[x]:=y;
    dist[x]:=len[y];
    inc(len[y],len[x]);
    len[x]:=0;
end;

function query(x:int):int;
begin
    if par[x]=x then query:=1
    else query:=dist[x]+query(par[x]);
end;

begin
    assign(input,'cubes.in');reset(input);
    assign(output,'cubes.out');rewrite(output);

    for i:=1 to n do begin
        par[i]:=i;
        dist[i]:=0;
        len[i]:=1;
    end;
    readln(p);
    for i:=1 to p do begin
        read(c);
        if c='M' then begin
            readln(x,y);
            union(x,y);
        end else begin
            readln(x);
            writeln(query(x)-1);
        end;
    end;
    
    close(input);close(output);
end.
