const
	maxn = 100;
var
	n, k, r, m, max, sum: longint;
	mx, my: array[0..maxn] of longint;
	nx, ny, s: array[01..maxn] of longint;
	
	trace: array[0..maxn, 0..maxn] of longint;
	numtrace: array[0..maxn] of longint;
	
	x: array[0..maxn] of longint; //trace
	
procedure enter;
var
	i: longint;
	f: text;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, K, R);
	readln(f, m);
	for i := 1 to m do read(f, mx[i], my[i]);
	readln(f, n);
	sum := 0;
	for i := 1 to n do
	begin
		read(f, nx[i], ny[i], s[i]);
		inc(sum, s[i]);
	end;
	close(f);
end;

function length(rest, house: longint): real;
begin
	exit(sqrt(sqr(mx[rest] - nx[house]) + sqr(my[rest]-ny[house])));
end;

procedure recalc;
var
	i, j: integer;
begin
	for i := 1 to m do //rest
	begin
		numtrace[i] := 0;
		for j := 1 to n do //house
			if length(i, j) <= r then
			begin
				inc(numtrace[i]);
				trace[i, numtrace[i]] := j;
	
			end;
	end;
end;

procedure printres;
begin
	writeln(max);
	halt;
end;

procedure updateRes;
var
	free: array[1..maxn] of boolean;
	j, i, z, res: longint;
begin
	
	
	fillchar(free, sizeof(free), true);
	res := 0;
	for j := 1 to k do //rest
	begin
		i := x[j];
		
		for z := 1 to numtrace[i] do
			if free[trace[i, z]] then
			begin
				inc(res, s[trace[i, z]]);
				free[trace[i, z]] := false;
			end;
	end;
	
	
	if res > max then max := res;
	if max = sum then printres;
end;

procedure next(i: integer);
var
	j: integer;
begin
	for j := x[i-1] + 1 to m do
	begin
		x[i] := j;
		if i = k then updateRes
		else next(i+1);
	end;
end;

begin
	enter;
	max := 0;
	recalc;
	next(1);
	writeln(max);
end.
