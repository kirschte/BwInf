unit TRechnensub;

interface

uses
  Classes {$IFDEF MSWINDOWS} , Windows {$ENDIF},SysUtils;

type
  TRechnens = class(TThread)
  private
    Amin:integer;
    Amax:integer;
    used:array [0..9] of integer;
    procedure SetName;
  protected
    procedure Execute; override;
    procedure UpdateLoesung();
    function ueberpruefen():boolean;
  end;

implementation

uses Alphametriken;

{ Wichtig: Methoden und Eigenschaften von Objekten in visuellen Komponenten dürfen 
  nur in einer Methode namens Synchronize aufgerufen werden, z.B.

      Synchronize(UpdateCaption);

  und UpdateCaption könnte folgendermaßen aussehen:

    procedure TIf.UpdateCaption;
    begin
      Form1.Caption := 'Aktualisiert in einem Thread';
    end; }

{$IFDEF MSWINDOWS}
type
  TThreadNameInfo = record
    FType: LongWord;     // muss 0x1000 sein
    FName: PChar;        // Zeiger auf Name (in Anwender-Adress-Bereich)
    FThreadID: LongWord; // Thread-ID (-1 ist Caller-Thread)
    FFlags: LongWord;    // reserviert für zukünftige Verwendung, muss 0 sein
  end;
{$ENDIF}

{ TIf }

procedure TRechnens.SetName;
{$IFDEF MSWINDOWS}
var
  ThreadNameInfo: TThreadNameInfo;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  ThreadNameInfo.FType := $1000;
  ThreadNameInfo.FName := 'Rechnen mit Subtraktion';
  ThreadNameInfo.FThreadID := $FFFFFFFF;
  ThreadNameInfo.FFlags := 0;

  try
    RaiseException( $406D1388, 0, sizeof(ThreadNameInfo) div sizeof(LongWord), @ThreadNameInfo );
  except
  end;
{$ENDIF}
end;

procedure TRechnens.Execute;
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
var A,B,C,D,E,F,G,H,I,J:integer;
doppelteins,doppeltzwei:string;
begin
  SetName;
  Amin:=1;
  Amax:=9;
  for I := 0 to 9 do used[i]:=0;
  //if ueberpruefen=false then exit;
  Form1.MemoOutput.Lines.Add('Start Scanning (Time: '+TimeToStr(Now)+')');
  for A := Amin to Amax do begin
      used[A]:=1;
      for B := 0 to 9 do begin
        if used[B]=1 then continue;
        used[B]:=1;
        for C := 0 to 9 do begin
          if used[C]=1 then continue;
          used[C]:=1;
          for D := 0 to 9 do begin
            if used[D]=1 then continue;
            used[D]:=1;
            for E := 0 to 9 do begin
              if used[E]=1 then continue;
              used[E]:=1;
              for F := 0 to 9 do begin
                if used[F]=1 then continue;
                used[F]:=1;
                for G := 0 to 9 do begin
                  if used[G]=1 then continue;
                  used[G]:=1;
                  for H := 0 to 9 do begin
                    if used[H]=1 then continue;
                    used[H]:=1;
                    for I := 0 to 9 do begin
                      if used[I]=1 then continue;
                      used[I]:=1;
                      for J := 0 to 9 do begin
                          if used[J]=1 then continue;
                          if (A*Form1.multiply[1]+B*Form1.multiply[2]+C*Form1.multiply[3]+D*Form1.multiply[4]+E*Form1.multiply[5]+F*Form1.multiply[6]+G*Form1.multiply[7]+H*Form1.multiply[8]+I*Form1.multiply[9]+J*Form1.multiply[10])-(A*Form1.multiply[11]+B*Form1.multiply[12]+C*Form1.multiply[13]+D*Form1.multiply[14]+E*Form1.multiply[15]+F*Form1.multiply[16]+G*Form1.multiply[17]+H*Form1.multiply[18]+I*Form1.multiply[19]+J*Form1.multiply[20])=A*Form1.multiply[21]+B*Form1.multiply[22]+C*Form1.multiply[23]+D*Form1.multiply[24]+E*Form1.multiply[25]+F*Form1.multiply[26]+G*Form1.multiply[27]+H*Form1.multiply[28]+I*Form1.multiply[29]+J*Form1.multiply[30] then
                          begin
                            {doppelteins:=InttoStr(A)+InttoStr(B)+InttoStr(C)+InttoStr(D)+InttoStr(E)+InttoStr(F)+InttoStr(G)+InttoStr(H)+InttoStr(I)+InttoStr(J);
                            doppeltzwei:=DeleteChar(doppelteins);
                            if length(doppelteins)=length(doppeltzwei) then
                            begin          }
                            Form1.MemoOutput.Lines.Add('Lösung gefunden! (Time: '+TimeToStr(Now)+')');
                            Form1.MemoOutput.Lines.Add(Form1.letters[0]+'='+InttoStr(A)+'; '+Form1.letters[1]+'='+InttoStr(B)+'; '+Form1.letters[2]+'='+InttoStr(C)+'; '+Form1.letters[3]+'='+InttoStr(D)+'; '+Form1.letters[4]+'='+InttoStr(E)+'; '+Form1.letters[5]+'='+InttoStr(F)+'; '+Form1.letters[6]+'='+InttoStr(G)+'; '+Form1.letters[7]+'='+InttoStr(H)+'; '+Form1.letters[8]+'='+InttoStr(I)+'; '+Form1.letters[9]+'='+InttoStr(J));
                            Synchronize(UpdateLoesung);
                            { end;}
                          end;
                          used[J]:=0;
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
  Form1.MemoOutput.Lines.Add('Ende des Scannings (Time: '+TimeToStr(Now)+')');
  Form1.MemoOutput.Lines.Add('Found '+InttoStr(Form1.loesung)+' Solutions');
  Form1.MemoOutput.Lines.Add('--------------------------------------------------');
end;

procedure TRechnens.UpdateLoesung;
begin
  Form1.loesung:=Form1.loesung+1;
end;

function TRechnens.ueberpruefen():boolean;
  procedure MemoHinzufuegen();
  begin
    Form1.MemoOutput.Lines.Add('There won''t be a solution!');
    Form1.MemoOutput.Lines.Add('ENDE');
    Form1.MemoOutput.Lines.Add('-------------------------------------------------');
  end;
begin
  result:=true;
  if (length(Form1.eingang[1])=length(Form1.eingang[2])+1) AND (length(Form1.eingang[1])=length(Form1.eingang[3])+1) then
  begin
    Amax:=1;
    Amin:=1;
  end;
  //////////////////////Fehlerüberprüfung///////////////////////////////////////
  if (length(Form1.eingang[1])>length(Form1.eingang[2])+1) AND (length(Form1.eingang[1])>length(Form1.eingang[3])+1) then
  begin
    MemoHinzufuegen;
    result:=false;
  end;
  if (length(Form1.eingang[1])<length(Form1.eingang[2])) OR (length(Form1.eingang[1])<length(Form1.eingang[3])) then
  begin
    Memohinzufuegen;
    result:=false;
  end;
end;


end.
