unit Alphametriken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  TForm1 = class(TForm)
    input: TPanel;
    start: TButton;
    output: TPanel;
    MemoOutput: TMemo;
    lboutput: TLabel;
    lbinput: TLabel;
    edeins: TEdit;
    edzwei: TEdit;
    eddrei: TEdit;
    cboperator: TComboBox;
    lbgleich: TLabel;
    procedure startClick(Sender: TObject);
    procedure edeinsChange(Sender: TObject);
    procedure edzweiChange(Sender: TObject);
    procedure eddreiChange(Sender: TObject);
    procedure cboperatorChange(Sender: TObject);
    procedure edeinsKeyPress(Sender: TObject; var Key: Char);
    procedure edzweiKeyPress(Sender: TObject; var Key: Char);
    procedure eddreiKeyPress(Sender: TObject; var Key: Char);
  private
    { Private-Deklarationen }
    eingang   : array [1..3] of string;     //Eingangswörter
    letters   : array [0..28] of string;    //Gültigen Buchstaben (gekürzt)
    multiply  : array [1..30] of integer;   //Multiplier für Haupt-ALgorithmus
    multistr  : string;                     //Multiplierstring
    operatore : string;                     //Rechenoperator
    loesung   : integer;                    //Anzahl der gefundenen Lösungen
    anzahl    : integer;                    //Anzahl der unterschiedlichen Zeichen
    gesamt2   : string;                     //s. Letters[] nur als EIN String
    used      : array [0..9] of integer;    //benutzte Zeichen --> Tempooptimierung
    min       : array [1..10] of integer;   //Die Mindesanzahl zur Vermeidung, dass eine 0 am Anfang der Rechnung steht
    procedure solveAlphametika();           //Addition mit 10
    procedure solveAlphametiks();
    procedure solveAlphametikd();
    procedure solveAlphametikm();
    procedure bestimmebuchstaben();         //doppelte Buchstaben löschen
    procedure setzeMultiplier();
    procedure setzeMin();                   //siehe Varable min
    procedure Fehlerueberpruefung(Sender: TObject);
      procedure Abfrageaneun(A,B,C,D,E,F,G,H,I:integer);  //Addition mit 9
      procedure Abfrageaacht(A,B,C,D,E,F,G,H:integer);    //Addition mit 8
      procedure Abfrageasieben(A,B,C,D,E,F,G:integer);    //Addition mit 7
      procedure Abfrageasechs(A,B,C,D,E,F:integer);       //Addition mit 6
      procedure Abfrageafuenf(A,B,C,D,E:integer);         //Addition mit 5
      procedure Abfrageavier(A,B,C,D:integer);            //Addition mit 4
      procedure Abfrageadrei(A,B,C:integer);              //Addition mit 3
      procedure Abfragesneun(A,B,C,D,E,F,G,H,I:integer);  //Subtraktion mit 9
      procedure Abfragesacht(A,B,C,D,E,F,G,H:integer);    //Subtraktion mit 8
      procedure Abfragessieben(A,B,C,D,E,F,G:integer);    //Subtraktion mit 7
      procedure Abfragessechs(A,B,C,D,E,F:integer);       //Subtraktion mit 6
      procedure Abfragesfuenf(A,B,C,D,E:integer);         //Subtraktion mit 5
      procedure Abfragesvier(A,B,C,D:integer);            //Subtraktion mit 4
      procedure Abfragesdrei(A,B,C:integer);              //Subtraktion mit 3
      procedure Abfragemneun(A,B,C,D,E,F,G,H,I:integer);  //Multiplikation mit 9
      procedure Abfragemacht(A,B,C,D,E,F,G,H:integer);    //Multiplikation mit 8
      procedure Abfragemsieben(A,B,C,D,E,F,G:integer);    //Multiplikation mit 7
      procedure Abfragemsechs(A,B,C,D,E,F:integer);       //Multiplikation mit 6
      procedure Abfragemfuenf(A,B,C,D,E:integer);         //Multiplikation mit 5
      procedure Abfragemvier(A,B,C,D:integer);            //Multiplikation mit 4
      procedure Abfragemdrei(A,B,C:integer);              //Multiplikation mit 3
      procedure Abfragedneun(A,B,C,D,E,F,G,H,I:integer);  //Division mit 9
      procedure Abfragedacht(A,B,C,D,E,F,G,H:integer);    //Division mit 8
      procedure Abfragedsieben(A,B,C,D,E,F,G:integer);    //Division mit 7
      procedure Abfragedsechs(A,B,C,D,E,F:integer);       //Division mit 6
      procedure Abfragedfuenf(A,B,C,D,E:integer);         //Division mit 5
      procedure Abfragedvier(A,B,C,D:integer);            //Division mit 4
      procedure Abfrageddrei(A,B,C:integer);              //Division mit 3
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//*********************Hauptalgorithmus**********************************
procedure TForm1.solveAlphametiks();
var A,B,C,D,E,F,G,H,I,J:integer;
begin
  for I := 0 to 9 do used[i]:=0;

  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  for A := min[1] to 9 do begin
      used[A]:=1;
      for B := min[2] to 9 do begin
        if used[B]=1 then continue;
        used[B]:=1;
        for C := min[3] to 9 do begin
          if used[C]=1 then continue;
          used[C]:=1;
          for D := min[4] to 9 do begin
            if anzahl=3 then begin Abfragesdrei(A,B,C); break; end;
            if used[D]=1 then continue;
            used[D]:=1;
            for E := min[5] to 9 do begin
              if anzahl=4 then begin Abfragesvier(A,B,C,D); break; end;
              if used[E]=1 then continue;
              used[E]:=1;
              for F := min[6] to 9 do begin
                if anzahl=5 then begin Abfragesfuenf(A,B,C,D,E); break; end;
                if used[F]=1 then continue;
                used[F]:=1;
                for G := min[7] to 9 do begin
                  if anzahl=6 then begin Abfragessechs(A,B,C,D,E,F); break; end;
                  if used[G]=1 then continue;
                  used[G]:=1;
                  for H := min[8] to 9 do begin
                    if anzahl=7 then begin Abfragessieben(A,B,C,D,E,F,G); break; end;
                    if used[H]=1 then continue;
                    used[H]:=1;
                    for I := min[9] to 9 do begin
                      if anzahl=8 then begin Abfragesacht(A,B,C,D,E,F,G,H); break; end;
                      if used[I]=1 then continue;
                      used[I]:=1;
                      for J := min[10] to 9 do begin
                          if anzahl=9 then begin Abfragesneun(A,B,C,D,E,F,G,H,I); break; end;
                          if used[J]=1 then continue;
                            if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9]+J*Form1.multiply[10])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19]+J*Form1.multiply[20])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29]+J*Form1.multiply[30] then
                            begin
                              Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
                              Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I)+'; '+Form1.letters[9]+'='+InttoStr(J));
                              loesung:=loesung+1;
                            end;
                      end;
                      used[I]:=0;
                    end;
                    used[H]:=0;
                  end;
                  used[G]:=0;
                end;
                used[F]:=0;
              end;
              used[E]:=0;
            end;
            used[D]:=0;
          end;
          used[C]:=0;
        end;
        used[B]:=0;
      end;
      used[A]:=0;
  end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(Form1.loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;


procedure TForm1.startClick(Sender: TObject);
var I:integer;
begin
  Form1.MemoOutput.Clear;
  Form1.MemoOutput.Refresh;
  eingang[1]:=Uppercase(edeins.Text);
  eingang[2]:=Uppercase(edzwei.Text);
  eingang[3]:=Uppercase(eddrei.Text);
  for I := 1 to 10 do min[i]:=0;
  operatore:=cbOperator.Text;
  loesung:=0;
  bestimmebuchstaben;
  if (anzahl<3) OR (anzahl>10) then begin
    Form1.MemoOutput.Lines.Add('There won''t be a solution!');
    Form1.MemoOutput.Lines.Add('ENDE');
    Form1.MemoOutput.Lines.Add('-------------------------------------------------');
    showmessage('Please make a correct input!');
    exit;
  end;
  setzeMultiplier;
  setzeMin;
  Form1.MemoOutput.Lines.Add('Try to solve: '+eingang[1]+' '+operatore+' '+eingang[2]+' = '+eingang[3]);
  if operatore='-' then Form1.solveAlphametiks;
  if operatore='+' then Form1.solveAlphametika;
  if operatore='/' then Form1.solveAlphametikd;
  if operatore='*' then Form1.solveAlphametikm;
end;


procedure TForm1.Fehlerueberpruefung(Sender:TObject);
begin
  if (StrtoIntdef(edeins.Text,-1)=-1) AND (StrtoIntdef(edzwei.Text,-1)=-1) AND (StrtoIntdef(eddrei.Text,-1)=-1) AND (edeins.Text<>'') AND (edzwei.Text<>'') AND (eddrei.Text<>'') AND (cbOperator.Text<>cbOperator.Items.Names[1]) AND (length(edeins.Text)>=3) AND (length(edzwei.Text)>=3) AND (length(eddrei.Text)>=3)
  then start.Enabled:=true
  else start.Enabled:=false;
end;


procedure TForm1.setzeMultiplier;
var I:integer;
begin
  for I := 1 to length(multiply) do multiply[i]:=0;
  multistr:='';
  
  for I := 1 to length(eingang[1]) do begin
    if (Pos(eingang[1][i],multistr)<>0) then
      multiply[1+StrtoInt(multistr[Pos(eingang[1][i],multistr)+1])]:=multiply[1+StrtoInt(multistr[Pos(eingang[1][i],multistr)+1])]+round(power(10,length(eingang[1])-i))
    else begin
      multiply[Pos(eingang[1][i],gesamt2)]:=round(power(10,length(eingang[1])-i));
      multistr:=multistr+eingang[1][i]+InttoStr(Pos(eingang[1][i],gesamt2)-1);
    end;
  end;

  for I := 1 to length(eingang[2]) do begin
    if (Pos(eingang[2][i],multistr)<>0) then
      multiply[11+StrtoInt(multistr[Pos(eingang[2][i],multistr)+1])]:=multiply[11+StrtoInt(multistr[Pos(eingang[2][i],multistr)+1])]+round(power(10,length(eingang[2])-i))
    else begin
      multiply[10+Pos(eingang[2][i],gesamt2)]:=round(power(10,length(eingang[2])-i));
      multistr:=multistr+eingang[2][i]+InttoStr(Pos(eingang[2][i],gesamt2)-1);
    end;
  end;

    for I := 1 to length(eingang[3]) do begin
    if (Pos(eingang[3][i],multistr)<>0) then
      multiply[21+StrtoInt(multistr[Pos(eingang[3][i],multistr)+1])]:=multiply[21+StrtoInt(multistr[Pos(eingang[3][i],multistr)+1])]+round(power(10,length(eingang[3])-i))
    else begin
      multiply[20+Pos(eingang[3][i],gesamt2)]:=round(power(10,length(eingang[3])-i));
      multistr:=multistr+eingang[3][i]+InttoStr(Pos(eingang[3][i],gesamt2)-1);
    end;
  end;
end;


procedure TForm1.bestimmebuchstaben;
  function DeleteChar(const s: String): String;
  var
    u: set of Char;
    i: integer;
  begin
    result := '';
    u := [];
    for i := 1 to Length(s) do
      if not (s[i] in u) then
      begin
        Include(u, s[i]);
        result := result + s[i];
      end;
  end;
var gesamt:string; I:integer;
begin
  gesamt:= eingang[1]+eingang[2]+eingang[3];
  gesamt2:= DeleteChar(gesamt);
  anzahl:=length(gesamt2);
  MemoOutput.Lines.Strings[MemoOutput.Lines.Count]:= 'Valid Chars('+InttoStr(anzahl)+'): ';
  for I := 0 to length(gesamt2)-1 do begin
    letters[i]:=gesamt2[i+1];
    MemoOutput.Lines.Strings[MemoOutput.Lines.Count-1]:=MemoOutput.Lines.Strings[MemoOutput.Lines.count-1]+Letters[i]+';'
  end;
end;

procedure TForm1.setzeMin;
begin
  min[Pos(eingang[1][1],gesamt2)]:=1;
  min[Pos(eingang[2][1],gesamt2)]:=1;
  min[Pos(eingang[3][1],gesamt2)]:=1;
end;




//*********************UNWICHTIG!!************************************

procedure TForm1.edeinsChange(Sender: TObject);
begin
  Form1.Fehlerueberpruefung(Sender);
end;

procedure TForm1.edzweiChange(Sender: TObject);
begin
  Form1.Fehlerueberpruefung(Sender);
end;

procedure TForm1.eddreiChange(Sender: TObject);
begin
  Form1.Fehlerueberpruefung(Sender);
end;

procedure TForm1.cboperatorChange(Sender: TObject);
begin
  Form1.Fehlerueberpruefung(Sender);
end;

                                                                  
procedure TForm1.eddreiKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z','A'..'Z',#08,#10,#11,#12] then else Key:=#00;
end;

procedure TForm1.edzweiKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z','A'..'Z',#08,#10,#11,#12] then else Key:=#00;
end;

procedure TForm1.edeinsKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z','A'..'Z',#08,#10,#11,#12] then else Key:=#00;
end;


//**********************************Nebenalgorithmen**************************

procedure TForm1.solveAlphametika();
var A,B,C,D,E,F,G,H,I,J:integer;
begin
  for I := 0 to 9 do used[i]:=0;

  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  for A := min[1] to 9 do begin
      used[A]:=1;
      for B := min[2] to 9 do begin
        if used[B]=1 then continue;
        used[B]:=1;
        for C := min[3] to 9 do begin
          if used[C]=1 then continue;
          used[C]:=1;
          for D := min[4] to 9 do begin
            if anzahl=3 then begin Abfrageadrei(A,B,C); break; end;
            if used[D]=1 then continue;
            used[D]:=1;
            for E := min[5] to 9 do begin
              if anzahl=4 then begin Abfrageavier(A,B,C,D); break; end;
              if used[E]=1 then continue;
              used[E]:=1;
              for F := min[6] to 9 do begin
                if anzahl=5 then begin Abfrageafuenf(A,B,C,D,E); break; end;
                if used[F]=1 then continue;
                used[F]:=1;
                for G := min[7] to 9 do begin
                  if anzahl=6 then begin Abfrageasechs(A,B,C,D,E,F); break; end;
                  if used[G]=1 then continue;
                  used[G]:=1;
                  for H := min[8] to 9 do begin
                    if anzahl=7 then begin Abfrageasieben(A,B,C,D,E,F,G); break; end;
                    if used[H]=1 then continue;
                    used[H]:=1;
                    for I := min[9] to 9 do begin
                      if anzahl=8 then begin Abfrageaacht(A,B,C,D,E,F,G,H); break; end;
                      if used[I]=1 then continue;
                      used[I]:=1;
                      for J := min[10] to 9 do begin
                          if anzahl=9 then begin Abfrageaneun(A,B,C,D,E,F,G,H,I); break; end;
                          if used[J]=1 then continue;
                            if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9]+J*Form1.multiply[10])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19]+J*Form1.multiply[20])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29]+J*Form1.multiply[30] then
                            begin
                              Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
                              Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I)+'; '+Form1.letters[9]+'='+InttoStr(J));
                              loesung:=loesung+1;
                            end;
                      end;
                      used[I]:=0;
                    end;
                    used[H]:=0;
                  end;
                  used[G]:=0;
                end;
                used[F]:=0;
              end;
              used[E]:=0;
            end;
            used[D]:=0;
          end;
          used[C]:=0;
        end;
        used[B]:=0;
      end;
      used[A]:=0;
  end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(Form1.loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikd();
var A,B,C,D,E,F,G,H,I,J:integer;
begin
  for I := 0 to 9 do used[i]:=0;

  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  for A := min[1] to 9 do begin
      used[A]:=1;
      for B := min[2] to 9 do begin
        if used[B]=1 then continue;
        used[B]:=1;
        for C := min[3] to 9 do begin
          if used[C]=1 then continue;
          used[C]:=1;
          for D := min[4] to 9 do begin
            if anzahl=3 then begin Abfrageddrei(A,B,C); break; end;
            if used[D]=1 then continue;
            used[D]:=1;
            for E := min[5] to 9 do begin
              if anzahl=4 then begin Abfragedvier(A,B,C,D); break; end;
              if used[E]=1 then continue;
              used[E]:=1;
              for F := min[6] to 9 do begin
                if anzahl=5 then begin Abfragedfuenf(A,B,C,D,E); break; end;
                if used[F]=1 then continue;
                used[F]:=1;
                for G := min[7] to 9 do begin
                  if anzahl=6 then begin Abfragedsechs(A,B,C,D,E,F); break; end;
                  if used[G]=1 then continue;
                  used[G]:=1;
                  for H := min[8] to 9 do begin
                    if anzahl=7 then begin Abfragedsieben(A,B,C,D,E,F,G); break; end;
                    if used[H]=1 then continue;
                    used[H]:=1;
                    for I := min[9] to 9 do begin
                      if anzahl=8 then begin Abfragedacht(A,B,C,D,E,F,G,H); break; end;
                      if used[I]=1 then continue;
                      used[I]:=1;
                      for J := min[10] to 9 do begin
                          if anzahl=9 then begin Abfragedneun(A,B,C,D,E,F,G,H,I); break; end;
                          if used[J]=1 then continue;
                            if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9]+J*Form1.multiply[10])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19]+J*Form1.multiply[20])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29]+J*Form1.multiply[30] then
                            begin
                              Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
                              Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I)+'; '+Form1.letters[9]+'='+InttoStr(J));
                              loesung:=loesung+1;
                            end;
                      end;
                      used[I]:=0;
                    end;
                    used[H]:=0;
                  end;
                  used[G]:=0;
                end;
                used[F]:=0;
              end;
              used[E]:=0;
            end;
            used[D]:=0;
          end;
          used[C]:=0;
        end;
        used[B]:=0;
      end;
      used[A]:=0;
  end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(Form1.loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikm();
var A,B,C,D,E,F,G,H,I,J:integer;
begin
  for I := 0 to 9 do used[i]:=0;

  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  for A := min[1] to 9 do begin
      used[A]:=1;
      for B := min[2] to 9 do begin
        if used[B]=1 then continue;
        used[B]:=1;
        for C := min[3] to 9 do begin
          if used[C]=1 then continue;
          used[C]:=1;
          for D := min[4] to 9 do begin
            if anzahl=3 then begin Abfragemdrei(A,B,C); break; end;
            if used[D]=1 then continue;
            used[D]:=1;
            for E := min[5] to 9 do begin
              if anzahl=4 then begin Abfragemvier(A,B,C,D); break; end;
              if used[E]=1 then continue;
              used[E]:=1;
              for F := min[6] to 9 do begin
                if anzahl=5 then begin Abfragemfuenf(A,B,C,D,E); break; end;
                if used[F]=1 then continue;
                used[F]:=1;
                for G := min[7] to 9 do begin
                  if anzahl=6 then begin Abfragemsechs(A,B,C,D,E,F); break; end;
                  if used[G]=1 then continue;
                  used[G]:=1;
                  for H := min[8] to 9 do begin
                    if anzahl=7 then begin Abfragemsieben(A,B,C,D,E,F,G); break; end;
                    if used[H]=1 then continue;
                    used[H]:=1;
                    for I := min[9] to 9 do begin
                      if anzahl=8 then begin Abfragemacht(A,B,C,D,E,F,G,H); break; end;
                      if used[I]=1 then continue;
                      used[I]:=1;
                      for J := min[10] to 9 do begin
                          if anzahl=9 then begin Abfragemneun(A,B,C,D,E,F,G,H,I); break; end;
                          if used[J]=1 then continue;
                            if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9]+J*Form1.multiply[10])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19]+J*Form1.multiply[20])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29]+J*Form1.multiply[30] then
                            begin
                              Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
                              Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I)+'; '+Form1.letters[9]+'='+InttoStr(J));
                              loesung:=loesung+1;
                            end;
                      end;
                      used[I]:=0;
                    end;
                    used[H]:=0;
                  end;
                  used[G]:=0;
                end;
                used[F]:=0;
              end;
              used[E]:=0;
            end;
            used[D]:=0;
          end;
          used[C]:=0;
        end;
        used[B]:=0;
      end;
      used[A]:=0;
  end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(Form1.loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

//******************************************************************************
//*********Unnötige Nebenalgorithmen zur Verbesserung der Performance***********
//******************************************************************************
//**********************************Addition************************************
//******************************************************************************


procedure TForm1.Abfrageaneun(A,B,C,D,E,F,G,H,I:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfrageaacht(A,B,C,D,E,F,G,H:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfrageasieben(A,B,C,D,E,F,G:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfrageasechs(A,B,C,D,E,F:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfrageafuenf(A,B,C,D,E:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfrageavier(A,B,C,D:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfrageadrei(A,B,C:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3])+(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C));
    loesung:=loesung+1;
  end;
end;

//******************************************************************************
//******************************************************************************
//**********************************Subtraktion*********************************
//******************************************************************************
//******************************************************************************

procedure TForm1.Abfragesneun(A,B,C,D,E,F,G,H,I:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragesacht(A,B,C,D,E,F,G,H:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragessieben(A,B,C,D,E,F,G:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragessechs(A,B,C,D,E,F:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragesfuenf(A,B,C,D,E:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragesvier(A,B,C,D:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragesdrei(A,B,C:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C));
    loesung:=loesung+1;
  end;
end;

//******************************************************************************
//******************************************************************************
//**********************************Multiplikation******************************
//******************************************************************************
//******************************************************************************

procedure TForm1.Abfragemneun(A,B,C,D,E,F,G,H,I:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragemacht(A,B,C,D,E,F,G,H:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragemsieben(A,B,C,D,E,F,G:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragemsechs(A,B,C,D,E,F:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragemfuenf(A,B,C,D,E:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragemvier(A,B,C,D:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragemdrei(A,B,C:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3])*(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C));
    loesung:=loesung+1;
  end;
end;

//******************************************************************************
//******************************************************************************
//**********************************Division************************************
//******************************************************************************
//******************************************************************************

procedure TForm1.Abfragedneun(A,B,C,D,E,F,G,H,I:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragedacht(A,B,C,D,E,F,G,H:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragedsieben(A,B,C,D,E,F,G:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragedsechs(A,B,C,D,E,F:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragedfuenf(A,B,C,D,E:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfragedvier(A,B,C,D:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D));
    loesung:=loesung+1;
  end;
end;

procedure TForm1.Abfrageddrei(A,B,C:integer);
begin
  if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3])/(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23] then
  begin
    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+FormatDateTime('hh:mm:ss.zzz', now)+')');
    Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C));
    loesung:=loesung+1;
  end;
end;



end.
