uses math;
const seed=131;p=10000019;
type state=record s:ansistring;i:integer end;
var
    ht:array[0..1,0..p] of integer;
    q:array[0..1,0..10010] of state;
    a:array[0..1,0..7] of ansistring;
    n,p0:integer;s:ansistring;
    h,t:array[0..1] of integer;

function hash(s:ansistring):dword;
var i:integer;
begin
    hash:=0;
    for i:=1 to length(s) do
        hash:=(hash*seed+ord(s[i])) and $FFFFFFF;
    hash:=hash mod p;
end;

function getpos(t,p:string;start:integer):integer;
begin
    getpos:=pos(t,copy(p,start,length(p)-start+1));
    if getpos<>0 then inc(getpos,start-1);
end;

procedure expand(x:integer);
var i,p0:integer;cstr,nstr:ansistring;ha:dword;
begin
    cstr:=q[x,h[x]].s;
    for i:=1 to n do begin
        p0:=getpos(a[x,i],cstr,1);
        while p0<>0 do begin
            nstr:=cstr;
            delete(nstr,p0,length(a[x,i]));
            insert(a[1-x,i],nstr,p0);

            ha:=hash(nstr);
            if ht[1-x,ha]<>0 then begin
                write(ht[1-x,ha]+q[x,h[x]].i+1);
                halt;
            end;
            if ht[x,ha]=0 then begin
                q[x,t[x]].s:=nstr;q[x,t[x]].i:=q[x,h[x]].i+1;
                ht[x,ha]:=q[x,t[x]].i;
                inc(t[x]);if t[x]>10010 then t[x]:=0;
            end;
            p0:=getpos(a[x,i],cstr,p0+1);
        end;
    end;
    inc(h[x]);if h[x]>10010 then h[x]:=0;
end;

procedure bfs();
var i:integer;
begin
    for i:=0 to 1 do begin
        h[i]:=1;t[i]:=2;
        q[i,1].s:=a[i,0];q[i,1].i:=0;
    end;
    repeat
        for i:=0 to 1 do
            if (h[i]<>t[i]) and (q[i,t[i]].i<=10) then expand(i);
    until ((h[0]=t[0]) and (h[1]=t[1])) or 
          (q[0,h[0]].i+q[1,h[1]].i>10);
end;

begin
    n:=-1;
    while not eof do begin
        inc(n);
        readln(s);
        p0:=pos(' ',s);
        a[0,n]:=copy(s,1,p0-1);
        a[1,n]:=copy(s,p0+1,length(s)-p0);
    end;
    //fillchar(ht,sizeof(ht),0);
    bfs();
    write('NO ANSWER!');
end.
