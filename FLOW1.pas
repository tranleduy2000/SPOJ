const
	maxn = 255;
var
	c: array[1..maxn, 1..maxn] of boolean;
procedure enter;
var
	f: text;
begin
	assign(f, 'file.inp');
	reset(f);
	readln(f, n, m);
end;
begin
end.

{
* http://vn.spoj.com/problems/FLOW1/
* Bài này thực chất là tìm cặp ghép với tập X_đỉnh là các học sinh SP,
* Y_đỉnh là các học sinh TH
* 
* Hai đỉnh (u,v) có cạnh nối với nhau nếu như cả 2 học sinh u, v cùng 
* thích 1 môn nào đó.???  như vậy thì 2 đỉnh sẽ có nhiều cạnh nối
*
}














