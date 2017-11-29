//CRITICAL - Thành phố trọng yếu
const maxn = 10000;
type
  tnode = ^pnode;
  pnode = record
    v: longint;
	next: tnode;
  end;
var
  a: array[1..maxn] tnode;
  count, result, n: longint;
  trace, low, number, childs: array[1..maxn] of longint;
  visited: array[1..maxn] of boolean;
  
procedure add(u, v: longint);
var 
  t: tnode;
begin
  new(t);
  t^.u := v;
  t^.trace := 0;
  t^.next := a[u];
  a[u] := t;
end;

procedure enter;
var 
  i, u, v: longint;
  f: text;
begin
  assign(f, 'file.inp');
  reset(f);
  readln(f, n);
  for i := 1 to n do
  begin
    readln(f, u, v);
	add(u, v);
	add(v, u);
  end;
  close(f);
end;

procedure childCound(u: longint);
var 
  t: tnode;
  v: longint;
begin
  visited[u] := true;
  childs[u] := 1;
  t := a[u];
  while t <> nil do
  begin
    v := t^.v;
	if not visited[v] then
	begin
	  childCound(v);
	  inc(childs[u], childs[v]);
	end;
    t := t^.next;
  end;
end;

procedure dfs(u, size: longint);
var
  t: tnode;
  v, top, sum: longint;
  c: array[1..maxn] of longint;
begin
  inc(count);
  low[u] := count;
  number[u] := count;
  t := a[u];
  top := 0;
  while t <> nil do
  begin
    v := t^.v;
	if (number[v] <> 0) and (v <> trace[u]) then
	begin
	  low[u] := min(low[u], number[v]);
	end else
	begin
	  trace[v] := u;
	  dfs(v, size);
	  if low[v] >= number[u] then //new vertices
	  begin
	    inc(top);
		c[top] := childs[v];
	  end;
	  low[u] := min(low[u], low[v]);
	end;
    t := t^.next;
  end;
  if c > 0 then
  begin
    sum := 0;
    for u := 1 to top do inc(sum, c[u]);
    inc(top);
	c[top] := size - 1 - sum;
	for u := 1 to top do
	begin
	  inc(result, c[i]
	end;
    for u := 1 to top do write(c[u], ' ');
    writeln;
  end;
end;

procedure solve;
var
  u: longint;
begin
  count := 0;
  for u := 1 to n do
  begin
    if childs[u] = 0 then
	begin
	  childCound(u);
	  dfs(u, childs[u]);
	end;
  end;
end;

begin
  enter;
  solve;
end.