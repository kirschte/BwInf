unit Alphametriken;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math, TRechnensub;

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

    procedure solveAlphametika();           //Addition mit 10
      procedure solveAlphametikaq();          //Addition mit 9
      procedure solveAlphametikaw();          //Addition mit 8
      procedure solveAlphametikae();          //Addition mit 7
      procedure solveAlphametikar();          //Addition mit 6
      procedure solveAlphametikat();          //Addition mit 5
      procedure solveAlphametikaz();          //Addition mit 4
    procedure solveAlphametiks();
    procedure solveAlphametikd();
    procedure solveAlphametikm();
    procedure bestimmebuchstaben();         //doppelte Buchstaben löschen
    procedure setzeMultiplier();
    procedure Fehlerueberpruefung(Sender: TObject);
  public
    { Public-Deklarationen }
    eingang   : array [1..3] of string;     //Eingangswörter
    letters   : array [0..22] of string;    //Gültigen Buchstaben (gekürzt)
    multiply  : array [1..30] of integer;   //Multiplier für Haupt-Algorithmus
    multistr  : string;                     //Multiplierstring
    operatore : string;                     //Rechenoperator
    loesung   : integer;                    //Anzahl der gefundenen Lösungen
    anzahl    : integer;                    //Anzahl der unterschiedlichen Zeichen
    gesamt2   : string;                     //s. Letters[] nur als EIN String
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

//*********************Hauptalgorithmus**********************************
procedure TForm1.solveAlphametiks();
begin
  TRechnens.Create(false);
end;


procedure TForm1.startClick(Sender: TObject);
begin
  Form1.MemoOutput.Clear;
  Form1.MemoOutput.Refresh;
  eingang[1]:=Uppercase(edeins.Text);
  eingang[2]:=Uppercase(edzwei.Text);
  eingang[3]:=Uppercase(eddrei.Text);
  operatore:=cbOperator.Text;
  loesung:=0;
  bestimmebuchstaben;
  if (anzahl<5) OR (anzahl>10) then begin
    Form1.MemoOutput.Lines.Add('There won''t be a solution!');
    Form1.MemoOutput.Lines.Add('ENDE');
    Form1.MemoOutput.Lines.Add('-------------------------------------------------');
    showmessage('Please make a correct input!');
    exit;
  end;
  setzeMultiplier;
  Form1.MemoOutput.Lines.Add('Try to solve: '+eingang[1]+' '+operatore+' '+eingang[2]+' = '+eingang[3]);
  if operatore='-' then Form1.solveAlphametiks;
  if (operatore='+') AND (anzahl=10) then Form1.solveAlphametika;
//********************PERFORMANCE**********************************************
  if (operatore='+') AND (anzahl= 9) then Form1.solveAlphametikaq;
  if (operatore='+') AND (anzahl= 8) then Form1.solveAlphametikaw;
  if (operatore='+') AND (anzahl= 7) then Form1.solveAlphametikae;
  if (operatore='+') AND (anzahl= 6) then Form1.solveAlphametikar;
  if (operatore='+') AND (anzahl= 5) then Form1.solveAlphametikat;
  if (operatore='+') AND (anzahl<=4) then Form1.solveAlphametikaz;
  //**************************PERFORMANCE**************************************
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
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              for F := 0 to 9 do begin
                for G := 0 to 9 do begin
                  for H := 0 to 9 do begin
                    for I := 0 to 9 do begin
                      for J := 0 to 9 do begin
                       if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5]+F*multiply[6]+G*multiply[7]+H*multiply[8]+I*multiply[9]+J*multiply[10])+(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16]+G*multiply[17]+H*multiply[18]+I*multiply[19]+J*multiply[20])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25]+F*multiply[26]+G*multiply[27]+H*multiply[28]+I*multiply[29]+J*multiply[30] then
                       begin
                        if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) AND (A<>F) AND (A<>G) AND (A<>H) AND (A<>I) AND (A<>J) then
                        begin
                          if (B<>C) AND (B<>D) AND (B<>E) AND (B<>F) AND (B<>G) AND (B<>H) AND (B<>I) AND (B<>J) then
                          begin
                            if (C<>D) AND (C<>E) AND (C<>F) AND (C<>G) AND (C<>H) AND (C<>I) AND (C<>J) then
                            begin
                              if (D<>E) AND (D<>F) AND (D<>G) AND (D<>H) AND (D<>I) AND (D<>J) then
                              begin
                                if (E<>F) AND (E<>G) AND (E<>H) AND (E<>I) AND (E<>J) then
                                begin
                                  if (F<>G) AND (F<>H) AND (F<>I) AND (F<>J) then
                                  begin
                                    if (G<>H) AND (G<>I) AND(G<>J) then
                                    begin
                                      if (H<>I) AND (H<>J) then
                                      begin
                                        if (I<>J) then
                                        begin
                                          Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                                          Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E)+'; '+letters[5]+'='+InttoStr(F)+'; '+letters[6]+'='+InttoStr(G)+'; '+letters[7]+'='+InttoStr(H)+'; '+letters[8]+'='+InttoStr(I)+'; '+letters[9]+'='+InttoStr(J));
                                          loesung:=loesung+1;
                                        end;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                       end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikd();
var A,B,C,D,E,F,G,H,I,J:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              for F := 0 to 9 do begin
                for G := 0 to 9 do begin
                  for H := 0 to 9 do begin
                    for I := 0 to 9 do begin
                      for J := 0 to 9 do begin
                       if (A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16]+G*multiply[17]+H*multiply[18]+I*multiply[19]+J*multiply[20])<>0 then begin
                       if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5]+F*multiply[6]+G*multiply[7]+H*multiply[8]+I*multiply[9]+J*multiply[10]) div (A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16]+G*multiply[17]+H*multiply[18]+I*multiply[19]+J*multiply[20])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25]+F*multiply[26]+G*multiply[27]+H*multiply[28]+I*multiply[29]+J*multiply[30] then
                       begin
                        if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) AND (A<>F) AND (A<>G) AND (A<>H) AND (A<>I) AND (A<>J) then
                        begin
                          if (B<>C) AND (B<>D) AND (B<>E) AND (B<>F) AND (B<>G) AND (B<>H) AND (B<>I) AND (B<>J) then
                          begin
                            if (C<>D) AND (C<>E) AND (C<>F) AND (C<>G) AND (C<>H) AND (C<>I) AND (C<>J) then
                            begin
                              if (D<>E) AND (D<>F) AND (D<>G) AND (D<>H) AND (D<>I) AND (D<>J) then
                              begin
                                if (E<>F) AND (E<>G) AND (E<>H) AND (E<>I) AND (E<>J) then
                                begin
                                  if (F<>G) AND (F<>H) AND (F<>I) AND (F<>J) then
                                  begin
                                    if (G<>H) AND (G<>I) AND(G<>J) then
                                    begin
                                      if (H<>I) AND (H<>J) then
                                      begin
                                        if (I<>J) then
                                        begin
                                          Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                                          Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E)+'; '+letters[5]+'='+InttoStr(F)+'; '+letters[6]+'='+InttoStr(G)+'; '+letters[7]+'='+InttoStr(H)+'; '+letters[8]+'='+InttoStr(I)+'; '+letters[9]+'='+InttoStr(J));
                                          loesung:=loesung+1;
                                        end;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                       end;
                       end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikm();
var A,B,C,D,E,F,G,H,I,J:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              for F := 0 to 9 do begin
                for G := 0 to 9 do begin
                  for H := 0 to 9 do begin
                    for I := 0 to 9 do begin
                      for J := 0 to 9 do begin
                       if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5]+F*multiply[6]+G*multiply[7]+H*multiply[8]+I*multiply[9]+J*multiply[10])*(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16]+G*multiply[17]+H*multiply[18]+I*multiply[19]+J*multiply[20])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25]+F*multiply[26]+G*multiply[27]+H*multiply[28]+I*multiply[29]+J*multiply[30] then
                       begin
                        if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) AND (A<>F) AND (A<>G) AND (A<>H) AND (A<>I) AND (A<>J) then
                        begin
                          if (B<>C) AND (B<>D) AND (B<>E) AND (B<>F) AND (B<>G) AND (B<>H) AND (B<>I) AND (B<>J) then
                          begin
                            if (C<>D) AND (C<>E) AND (C<>F) AND (C<>G) AND (C<>H) AND (C<>I) AND (C<>J) then
                            begin
                              if (D<>E) AND (D<>F) AND (D<>G) AND (D<>H) AND (D<>I) AND (D<>J) then
                              begin
                                if (E<>F) AND (E<>G) AND (E<>H) AND (E<>I) AND (E<>J) then
                                begin
                                  if (F<>G) AND (F<>H) AND (F<>I) AND (F<>J) then
                                  begin
                                    if (G<>H) AND (G<>I) AND(G<>J) then
                                    begin
                                      if (H<>I) AND (H<>J) then
                                      begin
                                        if (I<>J) then
                                        begin
                                          Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                                          Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E)+'; '+letters[5]+'='+InttoStr(F)+'; '+letters[6]+'='+InttoStr(G)+'; '+letters[7]+'='+InttoStr(H)+'; '+letters[8]+'='+InttoStr(I)+'; '+letters[9]+'='+InttoStr(J));                                          Form1.MemoOutput.Lines.Add('S='+InttoStr(A)+'; '+'U='+InttoStr(B)+'; '+'C='+InttoStr(C)+'; '+'H='+InttoStr(D)+'; '+'E='+InttoStr(E)+'; '+'N='+InttoStr(F)+'; '+'M='+InttoStr(G)+'; '+'A='+InttoStr(H)+'; '+'T='+InttoStr(I)+'; '+'P='+InttoStr(J));
                                          loesung:=loesung+1;
                                        end;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                       end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

//******************************************************************************
//*********Unnötige Nebenalgorithmen zur Verbesserung der Geschwindigkeit*******
//******************************************************************************
//**********************************Addition************************************
//******************************************************************************

procedure TForm1.solveAlphametikaq();
var A,B,C,D,E,F,G,H,I:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              for F := 0 to 9 do begin
                for G := 0 to 9 do begin
                  for H := 0 to 9 do begin
                    for I := 0 to 9 do begin
                       if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5]+F*multiply[6]+G*multiply[7]+H*multiply[8]+I*multiply[9])+(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16]+G*multiply[17]+H*multiply[18]+I*multiply[19])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25]+F*multiply[26]+G*multiply[27]+H*multiply[28]+I*multiply[29] then
                       begin
                        if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) AND (A<>F) AND (A<>G) AND (A<>H) AND (A<>I) then
                        begin
                          if (B<>C) AND (B<>D) AND (B<>E) AND (B<>F) AND (B<>G) AND (B<>H) AND (B<>I) then
                          begin
                            if (C<>D) AND (C<>E) AND (C<>F) AND (C<>G) AND (C<>H) AND (C<>I) then
                            begin
                              if (D<>E) AND (D<>F) AND (D<>G) AND (D<>H) AND (D<>I) then
                              begin
                                if (E<>F) AND (E<>G) AND (E<>H) AND (E<>I) then
                                begin
                                  if (F<>G) AND (F<>H) AND (F<>I) then
                                  begin
                                    if (G<>H) AND (G<>I) then
                                    begin
                                      if (H<>I) then
                                      begin
                                        Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                                        Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E)+'; '+letters[5]+'='+InttoStr(F)+'; '+letters[6]+'='+InttoStr(G)+'; '+letters[7]+'='+InttoStr(H)+'; '+letters[8]+'='+InttoStr(I));
                                        loesung:=loesung+1;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                       end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikaw();
var A,B,C,D,E,F,G,H:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              for F := 0 to 9 do begin
                for G := 0 to 9 do begin
                  for H := 0 to 9 do begin
                       if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5]+F*multiply[6]+G*multiply[7]+H*multiply[8])+(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16]+G*multiply[17]+H*multiply[18])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25]+F*multiply[26]+G*multiply[27]+H*multiply[28] then
                       begin
                        if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) AND (A<>F) AND (A<>G) AND (A<>H) then
                        begin
                          if (B<>C) AND (B<>D) AND (B<>E) AND (B<>F) AND (B<>G) AND (B<>H) then
                          begin
                            if (C<>D) AND (C<>E) AND (C<>F) AND (C<>G) AND (C<>H) then
                            begin
                              if (D<>E) AND (D<>F) AND (D<>G) AND (D<>H) then
                              begin
                                if (E<>F) AND (E<>G) AND (E<>H) then
                                begin
                                  if (F<>G) AND (F<>H) then
                                  begin
                                    if (G<>H) then
                                    begin
                                      Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                                      Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E)+'; '+letters[5]+'='+InttoStr(F)+'; '+letters[6]+'='+InttoStr(G)+'; '+letters[7]+'='+InttoStr(H));
                                      loesung:=loesung+1;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                       end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikae();
var A,B,C,D,E,F,G:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              for F := 0 to 9 do begin
                for G := 0 to 9 do begin
                  if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5]+F*multiply[6]+G*multiply[7])+(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16]+G*multiply[17])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25]+F*multiply[26]+G*multiply[27] then
                  begin
                    if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) AND (A<>F) AND (A<>G) then
                    begin
                      if (B<>C) AND (B<>D) AND (B<>E) AND (B<>F) AND (B<>G) then
                      begin
                        if (C<>D) AND (C<>E) AND (C<>F) AND (C<>G) then
                        begin
                          if (D<>E) AND (D<>F) AND (D<>G) then
                          begin
                            if (E<>F) AND (E<>G) then
                            begin
                              if (F<>G) then
                              begin
                                Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                                Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E)+'; '+letters[5]+'='+InttoStr(F)+'; '+letters[6]+'='+InttoStr(G));
                                loesung:=loesung+1;
                              end;
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikar();
var A,B,C,D,E,F:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              for F := 0 to 9 do begin
                if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5]+F*multiply[6])+(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15]+F*multiply[16])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25]+F*multiply[26] then
                begin
                  if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) AND (A<>F) then
                  begin
                    if (B<>C) AND (B<>D) AND (B<>E) AND (B<>F) then
                    begin
                      if (C<>D) AND (C<>E) AND (C<>F) then
                      begin
                        if (D<>E) AND (D<>F) then
                        begin
                          if (E<>F) then
                          begin
                            Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                            Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E)+'; '+letters[5]+'='+InttoStr(F));
                            loesung:=loesung+1;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikat();
var A,B,C,D,E:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            for E := 0 to 9 do begin
              if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4]+E*multiply[5])+(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14]+E*multiply[15])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24]+E*multiply[25] then
              begin
                if (A<>B) AND (A<>C) AND (A<>D) AND (A<>E) then
                begin
                  if (B<>C) AND (B<>D) AND (B<>E) then
                  begin
                    if (C<>D) AND (C<>E) then
                    begin
                      if (D<>E) then
                      begin
                        Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                        Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D)+'; '+letters[4]+'='+InttoStr(E));
                        loesung:=loesung+1;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TForm1.solveAlphametikaz();
var A,B,C,D:integer;
begin
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
    for A := 0 to 9 do begin
      for B := 0 to 9 do begin
        for C := 0 to 9 do begin
          for D := 0 to 9 do begin
            if (A*multiply[1]+B*multiply[2]+C*multiply[3]+D*multiply[4])+(A*multiply[11]+B*multiply[12]+C*multiply[13]+D*multiply[14])=A*multiply[21]+B*multiply[22]+C*multiply[23]+D*multiply[24] then
            begin
              if (A<>B) AND (A<>C) AND (A<>D) then
              begin
                if (B<>C) AND (B<>D) then
                begin
                  if (C<>D) then
                  begin
                    Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                    Form1.MemoOutput.Lines.Add(letters[0]+'='+InttoStr(A)+'; '+letters[1]+'='+InttoStr(B)+'; '+letters[2]+'='+InttoStr(C)+'; '+letters[3]+'='+InttoStr(D));
                    loesung:=loesung+1;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;


end.
