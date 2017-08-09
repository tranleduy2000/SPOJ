const
	maxn = 201;
	maxC = 1000000;

var
	c: array[0..maxn, 0..maxn] of longint;
	fx, fy, mx, my, trace: array[0..maxn] of longint;
	n: longint;
procedure enter;
var
	f: text;
	i, j: longint;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, n);
	for i := 1 to n	 do
		for j := 1 to n do c[i, j] := maxC;
	while not eof(f) do
	begin
		read(f, i, j);
		read(f, c[i, j]);
	end;
	close(f);
end;

procedure init;
var
	i, j: longint;
begin
	fillchar(mx, sizeof(mx), 0);
	fillchar(my, sizeof(my), 0);
	for i := 1 to n do
	begin
		fx[i] := maxC;
		for j := 1 to n do 
			if c[i, j] < fx[i] then fx[i] := c[i, j];
	end;
	for j := 1 to n do
	begin
		fy[j] := maxC;
		for i := 1 to n do if c[i, j] - fx[i] < fy[j] then
			fy[j] := c[i, j] - fx[i];
	end;
end;

function getC(x, y: longint): longint;
begin
	getC := (c[x, y] - fx[x] - fy[y]);
end;

function findPath(start: longint): longint;
var
	f, r, x, y: longint;
	queue: array[0..maxn] of longint;
begin
	fillchar(trace, sizeof(trace), 0);
	f := 1;
	r := 1 ;
	queue[1] := start;
	while f <= r do
	begin
		x := queue[f];
		inc(f);
		for y := 1 to n do
			if (trace[y] = 0) and (getC(x, y) = 0) then
			begin
				trace[y] := x;
				if mY[y] = 0 then exit(y);
				inc(r);
				queue[r] := mY[y];
			end;
	end;
	exit(0);
end;

procedure subXaddY(start: longint);
var
	vx, vy: array[1..maxn] of boolean;
	delta, i, y, x: longint;
begin
	fillchar(vx, sizeof(vx), false);
	fillchar(vy, sizeof(vy), false);
	vx[start] := true;
	for y := 1 to n do
		if trace[y] <> 0 then
		begin
			vy[y] := true;
			vx[my[y]] := true;
		end;
		
	delta := maxC;
	for x := 1 to n do
		if vx[x] then
			for y := 1 to n do
				if (not vy[y]) and (delta > getC(x, y)) then
					delta := getC(x, y);
				
	for i := 1 to n do
	begin
		if vx[i] then fx[i] := fx[i] + delta;
		if vy[i] then fy[i] := fy[i] - delta;
	end;
end;

procedure enlarge(y: longint);
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
	x, finish: longint;
begin
	init;
	for x := 1 to n do
	begin
		repeat
			finish := findPath(x);
			if finish = 0 then subXaddY(x);
		until finish <> 0;
		enlarge(finish);
	end;
end;

procedure print;
var
	x, cost: longint;
begin
	cost := 0;
	for x := 1 to n do 
		if c[x, mx[x]] < maxC then 
			inc(cost, c[x, mX[x]]);
	writeln(cost);
	
	for x := 1 to n do
		if c[x, mx[x]] < maxC then
			writeln(x, ' ', mX[x]);
end;

begin
	enter;
	solve;
	print;
end.
