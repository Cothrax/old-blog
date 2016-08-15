uses math;
const seed=131;p=100000007;
type state=record s:string;i:integer end;
var
    ht:array[0..p] of boolean;
    q:array[0..10010] of state;
    a:array[0..1,0..7] of string;
    n,p0,h,t:integer;s:string;

function hash(s:string):dword;
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

procedure bfs();
var i,p0:integer;cstr,nstr:string;ha:dword;
begin
    if a[0,0]=a[1,0] then begin write(0);halt end;
    h:=1;t:=2;
    q[h].s:=a[0,0];q[h].i:=0;
    while h<>t do begin
        cstr:=q[h].s;
        if q[h].i=10 then exit;
        for i:=1 to n do begin
            p0:=getpos(a[0,i],cstr,1);
            while p0<>0 do begin
                nstr:=cstr;
                delete(nstr,p0,length(a[0,i]));
                insert(a[1,i],nstr,p0);
                
                ha:=hash(nstr);
                if not ht[ha] then begin
                    ht[ha]:=true;
                    if nstr=a[1,0] then begin
                        write(q[h].i+1);
                        halt;
                    end;
                    q[t].s:=nstr;q[t].i:=q[h].i+1;
                    inc(t);if t>10010 then t:=0;
                end;
                p0:=getpos(a[0,i],cstr,p0+1);
            end;
        end;
        inc(h);if h>10010 then h:=0;
    end;
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

    //fillchar(ht,sizeof(ht),false);
    bfs();
    write('NO ANSWER!');
end.
