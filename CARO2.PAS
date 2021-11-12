program caro;
uses crt;
var x,y,vtx,vty,point,max,lastx,lasty,lastx2,lasty2:integer;
    kt:Boolean;
    board:array[-30..30,-30..30] of integer;
    
function checkxy(x,y:byte):boolean;
begin
if (x<1) and (y<1) or (x>20) and (y>20) then checkxy:=false
else checkxy:=true;
end;    

procedure arrayCout;
begin
for x:=1 to 20 do
begin
for y:=1 to 20 do
begin
if board[x,y]=0 then write(' ');
if board[x,y]=1 then write('X');
if board[x,y]=-1 then write('O');
writeln;
end;
end;
end;

procedure map;
begin
for x:=1 to 20 do
begin
for y:= 1 to 20 do
write('.');
writeln
end;
End;

procedure enter;
begin 
kt:=true;
gotoxy(1,21); delline;
gotoxy(1,22); delline;
gotoxy(1,23); delline;
gotoxy(1,21);
writeln('--------------------');
write('x:'); readln(x);
write('y:'); readln(y);
if checkxy(x,y)=true then
begin
board[x,y]:=1;
lastx:=x;
lasty:=y;
gotoxy(x,y);
write('X')
end else
begin
kt:=false;
write('error');
end;

end;

procedure cout;
begin
gotoxy(x,y);
write('X');
end;

procedure botCout(x,y:byte);
begin
gotoxy(x,y);
write('O');
board[x,y]:=-1;
lastx2:=x;
lasty2:=y;
end;

procedure playerWin;
begin
textColor(red);
for x:=1 to 20 do
 for y:=1 to 20 do
  begin
   if board[x,y]=1 then
   cout;
  end;
gotoxy(1,25);
writeln('you win');
readln;
halt;
end;

procedure botWin;
begin
textColor(green);
for x:=1 to 20 do
 for y:=1 to 20 do
  begin
   if board[x,y]=-1 then
   botCout(x,y);
  end;
gotoxy(1,25);
writeln('bot win');
readln;
halt;
end;

procedure checkwin;
begin
for x:=1 to 20 do
 for y:=1 to 20 do
 begin
if (board[x,y]+board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=5)
or (board[x,y]+board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=5)
or (board[x,y]+board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=5)
or (board[x,y]+board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=5)
or (board[x,y]+board[x,y+1]+board[x,y+2]+board[x,y+3]+board[x,y+4]=5)
or (board[x,y]+board[x+1,y]+board[x+2,y]+board[x+3,y]+board[x+4,y]=5)
or (board[x,y]+board[x,y-1]+board[x,y-2]+board[x,y-3]+board[x,y-4]=5)
or (board[x,y]+board[x-1,y]+board[x-2,y]+board[x-3,y]+board[x+4,y]=5)
then playerWin;

if (board[x,y]+board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=-5)
or (board[x,y]+board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=-5)
or (board[x,y]+board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=-5)
or (board[x,y]+board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=-5)
or (board[x,y]+board[x,y+1]+board[x,y+2]+board[x,y+3]+board[x,y+4]=-5)
or (board[x,y]+board[x+1,y]+board[x+2,y]+board[x+3,y]+board[x+4,y]=-5)
or (board[x,y]+board[x,y-1]+board[x,y-2]+board[x,y-3]+board[x,y-4]=-5)
or (board[x,y]+board[x-1,y]+board[x-2,y]+board[x-3,y]+board[x+4,y]=-5)
then botWin;
end;
end;

function evaluated(x,y:byte):integer;
begin
point:=0;
{//attack point}
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=-4 then point:=point+500;
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]=-3 then point:=point+350;
if board[x+1,y+1]+board[x+2,y+2]=-2 then point:=point+100;

if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=-4 then point:=point+500;
if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]=-3 then point:=point+350;
if board[x-1,y+1]+board[x-2,y+2]=-2 then point:=point+100;

if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=-4 then point:=point+500;
if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]=-3 then point:=point+350;
if board[x+1,y-1]+board[x+2,y-2]=-2 then point:=point+100;

if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=-4 then point:=point+500;
if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]=-3 then point:=point+350;
if board[x-1,y-1]+board[x-2,y-2]=-2 then point:=point+100;

if board[x,y+1]+board[x,y+2]+board[x,y+3]+board[x,y+4]=-4 then point:=point+500;
if board[x,y+1]+board[x,y+2]+board[x,y+3]=-3 then point:=point+350;
if board[x,y+1]+board[x,y+2]=-2 then point:=point+100;

if board[x,y-1]+board[x,y-2]+board[x,y-3]+board[x,y-4]=-4 then point:=point+500;
if board[x,y-1]+board[x,y-2]+board[x,y-3]=-3 then point:=point+350;
if board[x,y-1]+board[x,y-2]=-2 then point:=point+100;

if board[x+1,y]+board[x+2,y]+board[x+3,y]+board[x+4,y]=-4 then point:=point+500;
if board[x+1,y]+board[x+2,y]+board[x+3,y]=-3 then point:=point+350;
if board[x+1,y]+board[x+2,y]=-2 then point:=point+100;

if board[x-1,y]+board[x-2,y]+board[x-3,y]+board[x-4,y]=-4 then point:=point+500;
if board[x-1,y]+board[x-2,y]+board[x-3,y]=-3 then point:=point+350;
if board[x-1,y]+board[x-2,y]=-2 then point:=point+100;

{//defender point}
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=4 then point:=point+500;
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]=3 then point:=point+25;
if board[x+1,y+1]+board[x+2,y+2]=2 then point:=point+5;

if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=4 then point:=point+500;
if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]=3 then point:=point+25;
if board[x-1,y+1]+board[x-2,y+2]=2 then point:=point+5;

if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=4 then point:=point+500;
if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]=-3 then point:=point+25;
if board[x+1,y-1]+board[x+2,y-2]=2 then point:=point+5;

if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=4 then point:=point+500;
if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]=3 then point:=point+25;
if board[x-1,y-1]+board[x-2,y-2]=2 then point:=point+5;

if board[x,y+1]+board[x,y+2]+board[x,y+3]+board[x,y+4]=4 then point:=point+500;
if board[x,y+1]+board[x,y+2]+board[x,y+3]=3 then point:=point+25;
if board[x,y+1]+board[x,y+2]=2 then point:=point+5;

if board[x,y-1]+board[x,y-2]+board[x,y-3]+board[x,y-4]=4 then point:=point+500;
if board[x,y-1]+board[x,y-2]+board[x,y-3]=3 then point:=point+25;
if board[x,y-1]+board[x,y-2]=2 then point:=point+5;

if board[x+1,y]+board[x+2,y]+board[x+3,y]+board[x+4,y]=4 then point:=point+500;
if board[x+1,y]+board[x+2,y]+board[x+3,y]=3 then point:=point+25;
if board[x+1,y]+board[x+2,y]=2 then point:=point+5;

if board[x-1,y]+board[x-2,y]+board[x-3,y]+board[x-4,y]=4 then point:=point+500;
if board[x-1,y]+board[x-2,y]+board[x-3,y]=3 then point:=point+25;
if board[x-1,y]+board[x-2,y]=2 then point:=point+5;

evaluated:=point;
end;

procedure computer;
begin
max:=0;
for x:=1 to 20 do
 for y:=1 to 20 do
  if (max<evaluated(x,y)) and (board[x,y]=0) then
   begin
    max:=evaluated(x,y);
    vtx:=x;
    vty:=y;
   end;
 botCout(vtx,vty)
end;

procedure information;
begin
writeln('name of caro AI:zero 1.0');
writeln('GUI version:1.5');
writeln('max depth search:1');
writeln('thread:1');
writeln('total positions search:400');
writeln('evaluated position:true');
write('press enter to continue:');
end;

begin
clrscr;
information;
readln;
clrscr;
map;
while true do
begin
gotoxy(22,1); write('evaluated position:',max);
checkwin;
enter;
checkwin;
if kt=true then computer;
end;
  readln;
end.
