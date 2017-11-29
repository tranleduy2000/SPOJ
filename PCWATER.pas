const 
  maxmn = 0;
var
  a: array[0..maxmn, 0..maxmn] of longint;
  n, m: longint;
  
procedure enter;
var 
  i: longint;
begin
  readln(n, m);
  for i := 1 to n do
    for j := 1 to n do read(a[i, j]);
end;

procedure bfs;
begin
end;

procedure solve;
begin
end;

begin
  enter;
  solve;
end.