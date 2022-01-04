program caro;
uses crt;
var x,y,vtx,vty,point,max,lastx,lasty:integer;
    kt:Boolean;
    key:char;
    board:array[-30..30,-30..30] of integer;

function checkxy(x,y:byte):boolean;
begin
if (x<1) or (y<1) or (x>20) or (y>20) then checkxy:=false
else checkxy:=true;
end;

procedure arrayCout;
begin
for x:=1 to 20 do
begin
for y:=1 to 20 do
begin
gotoxy(x*2,y);
if board[x,y]=0 then write('.');
if board[x,y]=1 then write('X');
if board[x,y]=-1 then write('O');
writeln;
end;
end;
end;

procedure map;
begin
textcolor(white);
for x:=1 to 20 do
begin
for y:= 1 to 20 do
write('.':2); write(' |');
writeln
end;
End;

procedure enter;
begin
kt:=true;
x:=1; y:=1;
textcolor(white);
gotoxy(1,21);
writeln('------------------------------------------');
writeln('move the cursor with the a,s,w,d keys on your computer and');
writeln('press space to move.');
gotoxy(x*2,y);
repeat
key:=readkey;

case key of
#97:dec(x);
#119:dec(y);
#100:inc(x);
#115:inc(y);
end;
gotoxy(x*2,y);
until key=#13;

if board[x,y]<>0 then
begin
gotoxy(1,24);
write('error #2: this location already has X or O, press enter to exit:');
readln;
halt
end;

if checkxy(x,y)=true then
begin
textcolor(white);
board[x,y]:=1;
gotoxy(x*2,y);
write('X');
end else if checkxy(x,y)=false then
begin
kt:=false;
gotoxy(1,24);
write('error #1: your location is out of map, press enter to exit:');
readln;
halt;
end;
end;

procedure cout;
begin
gotoxy(x*2,y);
write('X');
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
gotoxy(1,24);
writeln('you win');
textcolor(white);
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
   begin
   gotoxy(x*2,y); write('O');
   end;
  end;
gotoxy(1,24);
writeln('bot win');
textcolor(white);
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
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=-4 then point:=point+625;
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]=-3 then point:=point+125;
if board[x+1,y+1]+board[x+2,y+2]=-2 then point:=point+25;
if board[x+1,y+1]=-1 then point:=point+5;

if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=-4 then point:=point+625;
if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]=-3 then point:=point+125;
if board[x-1,y+1]+board[x-2,y+2]=-2 then point:=point+25;
if board[x-1,y+1]=-1 then point:=point+5;

if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=-4 then point:=point+625;
if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]=-3 then point:=point+125;
if board[x+1,y-1]+board[x+2,y-2]=-2 then point:=point+25;
if board[x+1,y-1]=-1 then point:=point+5;

if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=-4 then point:=point+625;
if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]=-3 then point:=point+125;
if board[x-1,y-1]+board[x-2,y-2]=-2 then point:=point+25;
if board[x-1,y-1]=-1 then point:=point+5;

if board[x,y+1]+board[x,y+2]+board[x,y+3]+board[x,y+4]=-4 then point:=point+625;
if board[x,y+1]+board[x,y+2]+board[x,y+3]=-3 then point:=point+125;
if board[x,y+1]+board[x,y+2]=-2 then point:=point+25;
if board[x,y+1]=-1 then point:=point+5;

if board[x,y-1]+board[x,y-2]+board[x,y-3]+board[x,y-4]=-4 then point:=point+625;
if board[x,y-1]+board[x,y-2]+board[x,y-3]=-3 then point:=point+125;
if board[x,y-1]+board[x,y-2]=-2 then point:=point+25;
if board[x,y-1]=-1 then point:=point+5;

if board[x+1,y]+board[x+2,y]+board[x+3,y]+board[x+4,y]=-4 then point:=point+625;
if board[x+1,y]+board[x+2,y]+board[x+3,y]=-3 then point:=point+125;
if board[x+1,y]+board[x+2,y]=-2 then point:=point+25;
if board[x+1,y]=-1 then point:=point+5;

if board[x-1,y]+board[x-2,y]+board[x-3,y]+board[x-4,y]=-4 then point:=point+625;
if board[x-1,y]+board[x-2,y]+board[x-3,y]=-3 then point:=point+125;
if board[x-1,y]+board[x-2,y]=-2 then point:=point+25;
if board[x-1,y]=-1 then point:=point+5;

{update attack point}
if board[x+1,y+1]+board[x+2,y+2]+board[x-1,y-1]+board[x-2,y-2]=-4 then point:=point+625;
if board[x+1,y-1]+board[x+2,y-2]+board[x-1,y+1]+board[x-2,y+2]=-4 then point:=point+625;
if board[x,y+1]+board[x,y+2]+board[x,y-1]+board[x,y-2]=-4 then point:=point+625;
if board[x+1,y]+board[x+2,y]+board[x-1,y]+board[x-2,y]=-4 then point:=point+625;

if board[x+1,y+1]+board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]=-4 then point:=point+625;
if board[x+1,y+1]+board[x-1,y-1]+board[x-2,y-2]=-3 then point:=point+125;

if board[x-1,y-1]+board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]=-4 then point:=point+625;
if board[x-1,y-1]+board[x+1,y+1]+board[x+2,y+2]=-3 then point:=point+125;

if board[x-1,y+1]+board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]=-4 then point:=point+625;
if board[x-1,y+1]+board[x+1,y-1]+board[x+2,y-2]=-3 then point:=point+125;

if board[x+1,y-1]+board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]=-4 then point:=point+625;
if board[x+1,y-1]+board[x-1,y+1]+board[x-2,y+2]=-3 then point:=point+125;

if board[x,y+1]+board[x,y-1]+board[x,y-2]+board[x,y-3]=-4 then point:=point+625;
if board[x,y+1]+board[x,y-1]+board[x,y-2]=-3 then point:=point+125;

if board[x-1,y]+board[x+1,y]+board[x+2,y]+board[x+3,y]=-4 then point:=point+625;
if board[x-1,y]+board[x+1,y]+board[x+2,y]=-3 then point:=point+125;

if board[x,y-1]+board[x,y+1]+board[x,y+2]+board[x,y+3]=-4 then point:=point+625;
if board[x,y-1]+board[x,y+1]+board[x,y+2]=-3 then point:=point+125;

if board[x+1,y]+board[x-1,y]+board[x-2,y]+board[x-3,y]=-4 then point:=point+625;
if board[x+1,y]+board[x-1,y]+board[x-2,y]=-3 then point:=point+125;

if (board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=-3) and (board[x+1,y+1]=0) then point:=point+125;

if (board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=-3) and (board[x+1,y-1]=0)  then point:=point+125;

if (board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=-3) and (board[x-1,y+1]=0)  then point:=point+125;

if (board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=-3) and (board[x-1,y-1]=0)  then point:=point+125;

if (board[x,y+2]+board[x,y+3]+board[x,y+4]=-3) and (board[x,y+1]=0)  then point:=point+125;

if (board[x,y-2]+board[x,y-3]+board[x,y-4]=-3) and (board[x,y-1]=0)  then point:=point+125;

if (board[x+2,y]+board[x+3,y]+board[x+4,y]=-3) and (board[x+1,y]=0)  then point:=point+125;

if (board[x-2,y]+board[x-3,y]+board[x-4,y]=-3) and (board[x-1,y]=0)  then point:=point+125;

{//defender point}
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=4 then point:=point+400;
if board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]=3 then point:=point+100;
if board[x+1,y+1]+board[x+2,y+2]=2 then point:=point+20;
if board[x+1,y+1]=1 then point:=point+4;

if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=4 then point:=point+400;
if board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]=3 then point:=point+100;
if board[x-1,y+1]+board[x-2,y+2]=2 then point:=point+20;
if board[x-1,y+1]=1 then point:=point+4;

if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=4 then point:=point+400;
if board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]=3 then point:=point+100;
if board[x+1,y-1]+board[x+2,y-2]=2 then point:=point+20;
if board[x+1,y-1]=1 then point:=point+4;

if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=4 then point:=point+400;
if board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]=3 then point:=point+100;
if board[x-1,y-1]+board[x-2,y-2]=2 then point:=point+20;
if board[x-1,y-1]=1 then point:=point+4;

if board[x,y+1]+board[x,y+2]+board[x,y+3]+board[x,y+4]=4 then point:=point+400;
if board[x,y+1]+board[x,y+2]+board[x,y+3]=3 then point:=point+100;
if board[x,y+1]+board[x,y+2]=2 then point:=point+20;
if board[x,y+1]=1 then point:=point+4;

if board[x,y-1]+board[x,y-2]+board[x,y-3]+board[x,y-4]=4 then point:=point+400;
if board[x,y-1]+board[x,y-2]+board[x,y-3]=3 then point:=point+100;
if board[x,y-1]+board[x,y-2]=2 then point:=point+20;
if board[x,y-1]=1 then point:=point+4;

if board[x+1,y]+board[x+2,y]+board[x+3,y]+board[x+4,y]=4 then point:=point+400;
if board[x+1,y]+board[x+2,y]+board[x+3,y]=3 then point:=point+100;
if board[x+1,y]+board[x+2,y]=2 then point:=point+20;
if board[x+1,y]=1 then point:=point+4;

if board[x-1,y]+board[x-2,y]+board[x-3,y]+board[x-4,y]=4 then point:=point+400;
if board[x-1,y]+board[x-2,y]+board[x-3,y]=3 then point:=point+100;
if board[x-1,y]+board[x-2,y]=2 then point:=point+20;
if board[x-1,y]=1 then point:=point+4;
{update defender point}
if board[x+1,y+1]+board[x+2,y+2]+board[x-1,y-1]+board[x-2,y-2]=4 then point:=point+400;
if board[x+1,y-1]+board[x+2,y-2]+board[x-1,y+1]+board[x-2,y+2]=4 then point:=point+400;
if board[x,y+1]+board[x,y+2]+board[x,y-1]+board[x,y-2]=4 then point:=point+400;
if board[x+1,y]+board[x+2,y]+board[x-1,y]+board[x-2,y]=4 then point:=point+400;

if board[x+1,y+1]+board[x-1,y-1]+board[x-2,y-2]+board[x-3,y-3]=4 then point:=point+400;
if board[x+1,y+1]+board[x-1,y-1]+board[x-2,y-2]=3 then point:=point+100;

if board[x-1,y-1]+board[x+1,y+1]+board[x+2,y+2]+board[x+3,y+3]=4 then point:=point+400;
if board[x-1,y-1]+board[x+1,y+1]+board[x+2,y+2]=3 then point:=point+100;

if board[x-1,y+1]+board[x+1,y-1]+board[x+2,y-2]+board[x+3,y-3]=4 then point:=point+400;
if board[x-1,y+1]+board[x+1,y-1]+board[x+2,y-2]=3 then point:=point+100;

if board[x+1,y-1]+board[x-1,y+1]+board[x-2,y+2]+board[x-3,y+3]=4 then point:=point+400;
if board[x+1,y-1]+board[x-1,y+1]+board[x-2,y+2]=3 then point:=point+100;

if board[x,y+1]+board[x,y-1]+board[x,y-2]+board[x,y-3]=4 then point:=point+400;
if board[x,y+1]+board[x,y-1]+board[x,y-2]=3 then point:=point+100;

if board[x-1,y]+board[x+1,y]+board[x+2,y]+board[x+3,y]=4 then point:=point+400;
if board[x-1,y]+board[x+1,y]+board[x+2,y]=3 then point:=point+100;

if board[x,y-1]+board[x,y+1]+board[x,y+2]+board[x,y+3]=4 then point:=point+400;
if board[x,y-1]+board[x,y+1]+board[x,y+2]=3 then point:=point+100;

if board[x+1,y]+board[x-1,y]+board[x-2,y]+board[x-3,y]=4 then point:=point+400;
if board[x+1,y]+board[x-1,y]+board[x-2,y]=3 then point:=point+100;

if (board[x+2,y+2]+board[x+3,y+3]+board[x+4,y+4]=3) and (board[x+1,y+1]=0) then point:=point+100;

if (board[x+2,y-2]+board[x+3,y-3]+board[x+4,y-4]=3) and (board[x+1,y-1]=0)  then point:=point+100;

if (board[x-2,y+2]+board[x-3,y+3]+board[x-4,y+4]=3) and (board[x-1,y+1]=0)  then point:=point+100;

if (board[x-2,y-2]+board[x-3,y-3]+board[x-4,y-4]=3) and (board[x-1,y-1]=0)  then point:=point+100;

if (board[x,y+2]+board[x,y+3]+board[x,y+4]=3) and (board[x,y+1]=0)  then point:=point+100;

if (board[x,y-2]+board[x,y-3]+board[x,y-4]=3) and (board[x,y-1]=0)  then point:=point+100;

if (board[x+2,y]+board[x+3,y]+board[x+4,y]=3) and (board[x+1,y]=0)  then point:=point+100;

if (board[x-2,y]+board[x-3,y]+board[x-4,y]=3) and (board[x-1,y]=0)  then point:=point+100;

evaluated:=point;
end;

procedure botCout(x,y:byte);
begin
gotoxy(x*2,y); write('O');
board[x,y]:=-1;
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
botcout(vtx,vty);
end;

procedure information;
begin
textcolor(white);
writeln('code written by zero5556');
writeln('name of caro AI:zero 5.5');
writeln('GUI version:3.5');
writeln('max depth search:1');
writeln('thread:1');
writeln('total positions search:400');
writeln('evaluated position:true');
writeln('update:increase the attack and defense of AI, fix map bug, add a wall');
writeln('with character "|" to the map.');
write('press enter to continue:');
end;

begin
clrscr;
information;
readln;
clrscr;
x:=0;
map;
while x<>-1 do
begin
gotoxy(43,1); write('evaluated position:',max);
checkwin;
enter;
checkwin;
delay(100);
if kt=true then computer;
end;
  readln;
end.
