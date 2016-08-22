const z=1000000007;
var 
    n,m,a,rev,tmp,ans:int64;
    i:longint;

procedure extgcd(a,b:int64;var x,y:int64);
begin
    if b=0 then begin
        x:=1;y:=0;exit;
    end;
    extgcd(b,a mod b,y,x);
    dec(y,(a div b)*x);
end;

begin
    assign(input,'video.in');reset(input);
    assign(output,'video.out');rewrite(output);

    read(n,m);
    a:=1;
    for i:=1 to m do a:=a*i mod z;
    extgcd(a,z,rev,tmp);
    rev:=(rev+z) mod z;
    ans:=1;
    for i:=n-m+1 to n do ans:=ans*i mod z;
    write(ans*rev mod z);
    
    close(input);close(output);
end.
