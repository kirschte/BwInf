program KonsoleParition1;

{$APPTYPE CONSOLE}

{$R Images.RES}

uses
  SysUtils,
  Windows,
  uBaum in 'uBaum.pas',
  uKnoten in 'uKnoten.pas';

var
  Flaschenanzahl, Behaelteranzahl,answer1,answer2:string;
  Behaelterarraystring: array of string;
  Behaelterarrayinteger: array of integer;
  Baum: TBaumi;
  datestart,dateende: extended;

function Ansi2OEM(AnsiString: string): string; 
begin
  ANSIString := ANSIString + #0;
  CharToOEM(PChar(ANSIString), @ANSIString[1]);
  Delete(ANSIString, Length(ANSIString), 1);
  Result := ANSIString;
end;
function ClearConsoleScreen(): Boolean;
var
  ConsoleOutput: THandle;
  ConsoleScreenBufferInfo: TConsoleScreenBufferInfo;
  WriteCoord: TCoord;
  NumberOfCharsWritten: DWORD;
begin
  Result := False;
  ConsoleOutput := GetStdHandle(STD_OUTPUT_HANDLE);
  if ConsoleOutput <> INVALID_HANDLE_VALUE then
  begin
    if GetConsoleScreenBufferInfo(ConsoleOutput, ConsoleScreenBufferInfo) then
    begin
      WriteCoord.X := 0;
      WriteCoord.Y := 0;
      if FillConsoleOutputCharacter(ConsoleOutput, ' ',
        ConsoleScreenBufferInfo.dwSize.X * ConsoleScreenBufferInfo.dwSize.X,
        WriteCoord, NumberOfCharsWritten) then
      begin
        Result := SetConsoleCursorPosition(ConsoleOutput, WriteCoord);
      end;
    end;
  end;
end;

procedure Datenfestlegen();
var i:integer;
begin
  //Get Flaschenanzahl
  repeat begin
    write('> Bitte geben Sie die Flaschenanzahl ein (Int): ');
    readLn(Flaschenanzahl);
    if StrtoIntdef(Flaschenanzahl,-1)<0 then writeLn('Abbruch: Ung'+Ansi2OEM('ü')+'ltiger Wert');
  end until StrtoIntdef(Flaschenanzahl,-1)>=0;
  writeln('Done. Set Flaschenanzahl auf '+Flaschenanzahl+'.');
  writeln('');
  //Get Behäleranzahl
  repeat begin
    write('> Bitte geben Sie die Beh'+Ansi2OEM('ä')+'lteranzahl ein (Int): ');
    readLn(Behaelteranzahl);
    if StrtoIntdef(Behaelteranzahl,-1)<=0 then writeLn('Abbruch: Ung'+Ansi2OEM('ü')+'ltiger Wert');
  end until StrtoIntdef(Behaelteranzahl,-1)>0;
  writeln('Done. Set Beh'+Ansi2OEM('ä')+'lteranzahl auf '+Behaelteranzahl+'.');
  //Get Behältervolumen
  for I := 1 to StrtoInt(Behaelteranzahl) do begin
    setlength(Behaelterarraystring,length(Behaelterarraystring)+1);
    repeat begin
      write('> Bitte geben Sie f'+Ansi2OEM('ü')+'r den  Beh'+Ansi2OEM('ä')+'lter '+InttoStr(i)+' die max. Anzahl an m'+Ansi2OEM('ö')+'glichen Flaschen ein (Int): ');
      readln(Behaelterarraystring[i]);
      if StrtoIntdef(Behaelterarraystring[i],-1)<=0 then writeLn('Abbruch: Ung'+Ansi2OEM('ü')+'ltiger Wert');
    end until StrtoIntdef(Behaelterarraystring[i],-1)>0;
  end;

  for I := 1 to length(Behaelterarraystring)-1 do begin 
    setlength(Behaelterarrayinteger,length(Behaelterarrayinteger)+1);
    Behaelterarrayinteger[i]:=StrtoInt(Behaelterarraystring[i]);
  end;
  Behaelterarrayinteger[0]:=0;
    
  writeln('Done. Set Inhalt der Beh'+Ansi2OEM('ä')+'lter.');
  writeln('');
end;

procedure Eingangsgrafik();
begin
  writeln('');
  writeln('     ##############################################################################################');
  writeln('     ##############################################################################################');
  writeln('     ##############################################################################################');
  writeln('     ####  _____           _   _ _   _                                 _     _                 ####');
  writeln('     #### |  __ \         | | (_) | (_)                               | |   | |                ####');
  writeln('     #### | |__) |_ _ _ __| |_ _| |_ _  ___  _ __  ___ _ __  _ __ ___ | |__ | | ___ _ __ ___   ####');
  writeln('     #### |  ___/ _` | ''__| __| | __| |/ _ \| ''_ \/ __| ''_ \| ''__/ _ \| ''_ \| |/ _ \ ''_ ` _ \  ####');
  writeln('     #### | |  | (_| | |  | |_| | |_| | (_) | | | \__ \ |_) | | | (_) | |_) | |  __/ | | | | | ####');
  writeln('     #### |_|   \__,_|_|   \__|_|\__|_|\___/|_| |_|___/ .__/|_|  \___/|_.__/|_|\___|_| |_| |_| ####');
  writeln('     ####                                             | |                                      ####');
  writeln('     ####                                             |_|                                      ####');
  writeln('     ####                                                                                      ####');
  writeln('     ##############################################################################################');
  writeln('     ##############################################################################################');
  writeln('     ##############################################################################################');
  writeln('');
end;

begin
  setlength(Behaelterarraystring,1);
  setlength(Behaelterarrayinteger,1);
  Eingangsgrafik();
  //Daten festlegen
  Datenfestlegen();

  //Partitionsproblem starten
  write('> M'+Ansi2OEM('ö')+'chten Sie alle m'+Ansi2OEM('ö')+'glichen Kombinationen ausprobieren? (Ja/Nein) ');
  readln(answer1);
  if answer1='Nein' then begin exit; end;
  {
    repeat begin
      write('> M'+Ansi2OEM('ö')+'chten Sie die Daten '+Ansi2OEM('ä')+'ndern? (Ja/Nein) ');
      readln(answer2);
      if answer2='Ja' then Datenfestlegen();
    end until (answer2='Nein');
    write('> M'+Ansi2OEM('ö')+'chten Sie alle m'+Ansi2OEM('ö')+'glichen Kombinationen jetzt ausprobieren? (Ja/Nein) ');
    readln(answer1);
    if answer1='Nein' then begin writeln(''); writeln('Goodbye'); writeln('Press any key to continue.'); readln; exit; end;
  end;        }
  //Starten
  writeln('');
  clearConsoleScreen();
  Eingangsgrafik();
  writeln('');
  writeln('Paritionierungsproblem gestartet.');
  if StrtoInt(Flaschenanzahl)<>0 then begin
    Baum:=TBaumi.erzeuge(StrtoInt(Flaschenanzahl),StrtoInt(Behaelteranzahl),Behaelterarrayinteger);
    datestart:=Now * SecsPerDay * 1000.0;
    Baum.partition(0,0,0);
    dateende:=Now * SecsPerDay * 1000.0;
    writeln('Partitionierungsproblem erfolgreich beendet. ('+FloattoStr(round(dateende-datestart)/1000)+'s)');
    writeln('Es sind genau '+InttoStr(Baum.getzaehler)+' Kombinationen m'+Ansi2OEM('ö')+'glich.');
    writeln('');
    writeln('Dieses Programm musste daf'+Ansi2OEM('ü')+'r '+FloattoStr(Baum.getKnotendurchlauf)+' Knoten durchlaufen.');
  end else begin
    writeln('Partitionierungsproblem erfolgreich beendet. ('+FloattoStr(round(dateende-datestart)/1000)+'s)');
    writeln('Es ist nur 1 Kombination m'+Ansi2OEM('ö')+'glich.');
  end;
  writeln('');
  writeln('Press enter to continue.');
  readln;

end.
