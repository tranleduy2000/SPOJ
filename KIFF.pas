const maxn = 300001;
        oo = 1000000000;
var
        it_max, it_min: array[1..4*maxn] of longint;
        a: array[0..maxn] of longint;
        f: array[0..maxn] of longint;
        n, k: longint;

function min(x, y: longint): longint;
begin if x < y then exit(x) else exit(y);end;

function max(x, y: longint): longint;
begin if x > y then exit(x) else exit(y); end;
procedure buildIT(k , l, r: longint);
var     mid: longint;
begin
        if l = r then
        begin
                it_min[k] := a[l];
                it_max[k] := a[l];
                exit;
        end;
        mid := (l + r) div 2;
        buildIT(k*2, l , mid);
        buildIT(k*2+1, mid +1 , r);
        it_min[k] :=min(it_min[k*2], it_min[k*2+1]);
        it_max[k] := max(it_max[k*2], it_max[k*2+1]);
end;


function getMin(k, l ,r, i, j: longint): longint;
var     mid, tmp: longint;
begin
        if (i > r) or (j <l) then exit(oo);
        if (i <= l) and (r <= j) then exit(it_min[k]);
        mid := (l + r) div 2;
        tmp := getMin(k*2, l, mid, i, j);
        tmp := min(tmp,  getMin(k*2 +1 , mid + 1, r, i, j));
        exit(tmp);
end;

function getMax(k, l ,r, i, j: longint): longint;
var     mid, tmp: longint;
begin
        if (i > r) or (j <l) then exit(-oo);
        if (i <= l) and (r <= j) then exit(it_max[k]);
        mid := (l + r) div 2;
        tmp := getMax(k*2, l, mid, i, j);
        tmp := max(tmp,  getMax(k*2 +1 , mid + 1, r, i, j));
        exit(tmp);
end;

procedure readf;
var     fi: text;
        i: longint;
begin
        assign(fi, 'file.inp');
        reset(fi);
        readln(fi, n, k);
        for i := 1 to n do readln(fi, a[i]);
        close(fi);
end;

var t1, t2,t3, res, mmax: longint;

procedure process(l, r: longint);
var i, j: longint;
begin

        mmax := 0;
        for i := l to r do
        begin
                f[i] := i;
                for j := f[i-1] to i do
                begin
                        if getmax(1, 1, n, j, i) - getmin(1, 1, n, j, i) <= k
                        then
                        begin
                                f[i] := j;
                                 if i - f[i] + 1 > mmax then
                                 begin
                                        mmax := i - f[i] + 1;
                                        t1 := f[i];
                                        t2 := i;
                                 end;
                                break;
                        end;
                end;

        end;
       // for i := 1 to n do write(f[i], ' ');
end;

begin
         readf;
         buildIT(1, 1, n);
         f[0] := 1;
         process(1, n);
         res := mmax;
         process(1, t1-1);
         t3 := mmax;
         process(t2+1, n);
         if t3 < mmax then t3 := mmax;
         res := res + t3;
         writeln(res);
         readln;
end.