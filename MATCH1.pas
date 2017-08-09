const
	maxn = 1000;
var
	n, m: integer;
	mX, mY, trace: array[1..maxn] of integer;
	c: array[1..maxn, 1..maxn] of boolean;
	
procedure enter;
var
	f: text;
	x, y: integer;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, m, n);
	fillchar(c, sizeof(c), false);
	while not eof(f) do
	begin
		readln(f, x, y);
		c[x, y] := true;
	end;
	close(f);
	fillchar(mX, sizeof(mx), 0);
	fillchar(mY, sizeof(my), 0);
end;

function findPath: integer;
var
	f, r, x, y: integer;
	queue: array[1..maxn] of integer;
begin
	f := 1; r := 0;
	for x := 1 to m do
	  if mX[x] = 0 then begin inc(r); queue[r] := x; end;
	  
	fillchar(trace, sizeof(trace), 0);
	while f <= r do
	begin
	  x := queue[f]; inc(f);
	  for y := 1 to n do
		if (trace[y] = 0) and (c[x, y]) then
		begin
			trace[y] := x;
			if mY[y] = 0 then exit(y);
			inc(r); queue[r] := mY[y];
		end;
	end;
	findPath := 0;
end;

procedure enlarge(y: integer);
var
	x, next: longint;
begin
	repeat
		x := trace[y];
		next := mX[x];
		mX[x] := y;
		mY[y] := x;
		y := next;
	until y = 0;
end;

procedure solve;
var
	finish: integer;
begin
	repeat
		finish := findPath;
		if finish <> 0 then enlarge(finish);
	until finish = 0;
end;

procedure print;
var
  x: longint;
  res: integer;
begin
  res := 0;
  for x := 1 to m do if mX[x] <> 0 then inc(res);
  writeln(res);
  for x := 1 to m do if mX[x] <> 0 then writeln(x, ' ', mX[x]);
end;

begin
	enter;
	solve;
	print;
end.
