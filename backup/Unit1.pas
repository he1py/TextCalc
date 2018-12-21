unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,math;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Edit3: TEdit;
    Button3: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Button4: TButton;
    Edit6: TEdit;
    Button5: TButton;
    Edit7: TEdit;
    Button6: TButton;
    Edit8: TEdit;
    Button7: TButton;
    Button8: TButton;
    Edit9: TEdit;
    Button9: TButton;
    Edit10: TEdit;
    procedure Button9Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   parb:integer;
   pare:integer;
implementation

{$R *.dfm}

function verify(start:string):boolean;
var
i:integer;
numpb:integer;
numpe:integer;
begin
i:=1;
numpe:=0;
numpb:=0;
  while (i<=length(start)) do
    begin
    if start[i]='(' then numpb := numpb+1;
    if start[i]=')' then numpe := numpe+1;
    i:=i+1;
    end;
    if numpb=numpe then result:=true
    else
    result:=false;

end;


function invtext(texte:string):string;
var
i:integer;
res:string;
begin
i:=length(texte);
while(i>0)do
begin
res:=res+texte[i];
i:=i-1;
end;
result:=res;
end;



function gettfrom(toparse:string;from:integer;topoint:integer):string;
var
i:integer;
parsed:string;
begin
i:=from;

while(i<= length(toparse)) and (not(i=topoint+1)) do
        begin
        parsed:=parsed+toparse[i];
        i:=i+1;
        end;

        result:=parsed;
end;

function Replace(inn:string;by:string;from:integer;too:integer):string;
var
i:integer;
text:string;
begin
text:='';
i:=1;
while(i<=length(inn)) and (i<from) do
begin
text:= text + inn[i];
i:=i+1;
end;
text:= text + by;
i:=too+1;
while(i<=length(inn)) do
begin
text:= text + inn[i];
i:=i+1;
end;
result:=text;
end;




function eglebone(start:string;pos:integer):string;
var
i:integer;
toegleb:string;
magloub:string;
begin
i:=pos+1;
toegleb:='';
while(i<=length(start)) and((isnumeric(start[i]))or(start[i]='.'))  do
begin
toegleb:=toegleb+start[i];
i:=i+1;
end;
toegleb:=floattostr(1/strtofloat(toegleb));
magloub:=replace(start,'*'+toegleb,pos,i-1);

result:=magloub;
end;

function eglebga3(start:string):string;
var
i:integer;
magloubga3:string;
begin
magloubga3:=start ;
i:=1;
while(i<=length(magloubga3))do
begin
if(magloubga3[i]='/') then
begin
magloubga3:=eglebone(magloubga3,i);
end;
i:=i+1;
end;
result:=magloubga3;
end;

function DOSIOP(op1:string;op2:string;opp:string):string;
var
resu:extended;
begin
if opp = '+' then
resu:=strtofloat(op1) + strtofloat(op2);
if opp = '-' then
resu:=strtofloat(op1) - strtofloat(op2);
if opp = '/' then
resu:=strtofloat(op1) / strtofloat(op2);
if opp = '*' then
resu:=strtofloat(op1) * strtofloat(op2);
if opp = '^' then
resu:=power(strtofloat(op1), strtofloat(op2));
result:=floattostr(resu);
end;

Function getopp(texte:string;sympos:integer):string;
var
i:integer;
opp1:string;
opp2:string;
res:string;
from:integer;
too:integer;
begin
i:=sympos-1;
//get the opp before the oppsymbol
 while (i>0) and ((isnumeric(texte[i])) or (texte[i]='.')) do
begin
opp1:=opp1+texte[i];
from:=i;
i:=i-1;
end;
opp1:=invtext(opp1);
//get the opp after the oppsymbol
 i:=sympos+1;
while (i<=length(texte)) and ((isnumeric(texte[i])) or (texte[i]='.')) do
begin
opp2:=opp2+texte[i];
i:=i+1;
too:=i;
end;
res:=DOSIOP(opp1,opp2,texte[sympos]);
result:=replace(texte,res,from,too-1)
end;

function dox(start:string):string;
var
i:integer;
res:string;
begin
i:=1;
res:=start;
while(i<=length(res))do
begin
if (res[i]='*')then
begin
res:=getopp(res,i);
i:=1;
end;
i:=i+1;
end;
result:=res;
end;

function doadd(start:string):string;
var
i:integer;
res:string;
begin
i:=1;
res:=start;
while(i<=length(res))do
begin
if (res[i]='+')then
begin
res:=getopp(res,i);
i:=1;
end;
i:=i+1;
end;
result:=res;
end;


function dosub(start:string):string;
var
i:integer;
res:string;
begin
i:=1;
res:=start;
while(i<=length(res))do
begin
if (res[i]='-')then
begin
res:=getopp(res,i);
i:=1;
end;
i:=i+1;
end;
result:=res;
end;

function doexp(start:string):string;
var
i:integer;
res:string;
begin
i:=1;
res:=start;
while(i<=length(res))do
begin
if (res[i]='^')then
begin
res:=getopp(res,i);
i:=1;
end;
i:=i+1;
end;
result:=res;
end;

function doopp(start:string):string;
begin
result:=(dosub(doadd(dox(eglebga3(doexp(start))))))

end;

function countpar(start:string):integer;
var
i:integer;
parnum:integer;
begin
i:=1;
parnum:=0;
        while (i<=length(start)) do
         begin
         if start[i]='(' then parnum:=parnum+1 ;
         i:=i+1;
         end;
         result:=parnum;
end;

function get1stpar (start:string):string;
var
i:integer;
itemp:integer;
inside:string;
begin
i:=1;
itemp:=1;
inside:='';

while(i<=length(start)) and (not(start[i]=')')) do
begin
if start[i]='(' then
begin
itemp:=i;
end;
i:=i+1;
end;
parb:=itemp;
pare:=i;
result:=gettfrom(start,itemp+1,i-1);
end;

function solve1stpar(start:string):string;
var
solved:string;
i:integer;
oppdone:string;
parcount:integer;
begin
//verify here.............
if verify(start) = true then
begin
//////////////////////////
i:=1;
solved:=start;
parcount:=countpar(solved);
while (i<=parcount) do
begin
oppdone:=doopp(get1stpar(solved));
solved:=replace(solved,oppdone,parb,pare);
i:=i+1;
end;
result:=doopp(solved);
end
else
result:='Verify your parenthesis!!!!';
end;

//FIND ALL LETTERS SYMBOLES AND SOLVE EM:
function solve3let(start:string):string;
var
i:integer;
thrlet:string;
thropp:string;
parb:integer;
parbi:integer;
pare:integer;
parei:integer;
j:integer;
resthr:extended;
begin
i:=1;
thrlet:='';
 while (i<=length(start)) do
   begin
   if (start[i]='A') or (start[i]='B') or (start[i]='C') or (start[I]='D') or (start[i]='E') or
   (start[i]='F') or (start[i]='G') or (start[i]='H') or (start[i]='I') or (start[i]='J') or
   (start[i]='K') or (start[i]='L') or (start[i]='M') or (start[i]='N') or (start[i]='O') or
   (start[i]='P') or (start[i]='Q') or (start[i]='R') or (start[i]='S') or (start[i]='T') or
   (start[i]='U') or (start[i]='V') or (start[I]='W') or (start[i]='X') or (start[i]='Y')OR
   (start[i]='Z') THEN
    begin
    thrlet:=thrlet+start[i];
     if (length(thrlet)=3) and (start[i+1]='(') then
     begin
     j:=i+1;
     parb:=0;
     pare:=0;
     parei:=0;
     while (j<=length(start)) do
      begin
       if start[j] = '(' then parb := parb+1;
       if start[j] = ')' then pare := pare+1;
     if parb= pare then
     begin
     parei:=j;
     parbi:=i+2 ;
     thropp:= gettfrom(start,parbi,parei-1) ;
     end;
     j:=j+1;
      end;

     end;


    end;
    resthr:=12345;
    //Different functions:
    if thrlet = 'COS' then
    begin
     resthr := cos(strtofloat(Solve1stpar(thropp)));
    end;

    if thrlet = 'SIN' then
    begin
     resthr := SIN(strtofloat(Solve1stpar(thropp)));
    end;
    ////////////////////////////////


    result:=replace(start,floattostr(resthr),parbi-7,parei);
    i:=i+1;
   end;
end;
//
function solveall (start:string):string;
var
i:integer;
j:integer;
almostsolved:string;
begin
//look for thrlet and count them
i:=1;
j:=0;
 while(i<=length(start)) do
 begin
  if (start[i]='A') or (start[i]='B') or (start[i]='C') or (start[I]='D') or (start[i]='E') or
   (start[i]='F') or (start[i]='G') or (start[i]='H') or (start[i]='I') or (start[i]='J') or
   (start[i]='K') or (start[i]='L') or (start[i]='M') or (start[i]='N') or (start[i]='O') or
   (start[i]='P') or (start[i]='Q') or (start[i]='R') or (start[i]='S') or (start[i]='T') or
   (start[i]='U') or (start[i]='V') or (start[I]='W') or (start[i]='X') or (start[i]='Y')OR
   (start[i]='Z') THEN
   begin
   j:=j+1;
   i:=i+3
   end;
  i:=i+1;
 end;
 almostsolved:=start;
 while (j>=1) do
 begin
 almostsolved:=solve3let(almostsolved);
 j:=j-1;
 end;
 result:= solve1stpar(almostsolved);
end;


procedure TForm1.Button9Click(Sender: TObject);
begin
edit10.Text:=solveall(edit1.text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
if paramstr(1)='' then
else
ShowMessage(Solve3let(ParamStr(1)));
end;

end.
