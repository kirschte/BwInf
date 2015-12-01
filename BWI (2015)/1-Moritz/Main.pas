unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uSpielfeld, ExtCtrls, StdCtrls, FileCtrl, ComCtrls, Menus, DateUtils,
  ExtDlgs, uNotepad;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    PanelFeld: TPanel;
    PanelErzeugen: TPanel;
    PanelLog: TPanel;
    mm1: TMenuItem;
    ausDateiladen1: TMenuItem;
    Log: TMemo;
    OpenDialog1: TOpenDialog;
    PaintBoxFeld: TPaintBox;
    winter: TButton;
    ausEditoreinfgen1: TMenuItem;
    zuflliggenerieren1: TMenuItem;
    sommer: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ausDateiladen1Click(Sender: TObject);
    procedure winterClick(Sender: TObject);
    procedure ausEditoreinfgen1Click(Sender: TObject);
    procedure sommerClick(Sender: TObject);
  private
    { Private-Deklarationen }
    Spielfeld : TSpielFeld;
  public
    { Public-Deklarationen }
    procedure Dateiverarbeiten(Dateiinhalt:TStringList);
    procedure DateiverarbeitenEditor();
    procedure DateiverarbeitenTxt();
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.DateiverarbeitenEditor;
var Dateiinhalt: TStringList;
begin
  Dateiinhalt:=Notepad.getSL;
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Daten erfolgreich aus Editor gelesen ---');
  Dateiverarbeiten(Dateiinhalt);
  end;

procedure TForm1.DateiverarbeitenTxt;
var Dateiinhalt: TStringList;
begin
  Dateiinhalt:= TStringList.Create;
  Dateiinhalt.LoadFromFile(OpenDialog1.FileName);
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Datei '''+ExtractFileName(OpenDialog1.FileName)+''' erfolgreich geöffnet ---');
  Dateiverarbeiten(Dateiinhalt);
end;

procedure TForm1.Dateiverarbeiten(Dateiinhalt:TStringList);
procedure ungueltig(why:string);
begin 
  showmessage('Bitte geben Sie gültige Daten ein!');
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Abbruch: ungültige Daten ('+why+') ---');
end;
var breite,hoehe,i,j,k:integer;Liste:TStringList;
begin
    k:=0;
    Liste:=TStringList.Create;
    ExtractStrings([' '],[],PChar(Dateiinhalt.Strings[0]),Liste);
    if StrtoIntdef(Liste[0],-1)<>-1 then hoehe:=StrtoInt(Liste[0]) else begin ungueltig('Ungültiges Zeichen in der Höhenangabe'); exit; end;
    if StrtoIntdef(Liste[1],-1)<>-1 then breite:=StrtoInt(Liste[1]) else begin ungueltig('Ungültiges Zeichen in der Breitenangabe'); exit; end;
    if Dateiinhalt.Count-1<>hoehe then begin ungueltig('Tatsächliche Höhe stimmt nicht mit der angegebenen Höhe überein'); exit; end;
    if (AnsiPos('K',Dateiinhalt.Strings[1])<>0) OR (AnsiPos('K',Dateiinhalt.Strings[hoehe])<>0) OR (AnsiPos(' ',Dateiinhalt.Strings[1])<>0) OR (AnsiPos(' ',Dateiinhalt.Strings[hoehe])<>0) then begin ungueltig('Feld ist oben und unten nicht von schwarzen Feldern umgeben'); exit; end;
    for i := 1 to hoehe do begin
      if (Dateiinhalt.Strings[i][breite]<>'#') OR (Dateiinhalt.Strings[i][1]<>'#') then begin ungueltig('Feld ist rechts und links nicht von schwarzen Feldern umgeben bzw. Zeile ist zu lang (Zeile:'+InttoStr(i)+')'); exit; end;
      for j := 1 to breite do begin
        if not ((Dateiinhalt.Strings[i][j]='#') OR (Dateiinhalt.Strings[i][j]=' ') OR (Dateiinhalt.Strings[i][j]='K')) then begin
          ungueltig('ungültiges Zeichen in '+InttoStr(j)+','+InttoStr(i));
          exit;
        end;
        if (Dateiinhalt.Strings[i][j]='K') then k:=k+1; //Bei zwei Krabben --> ungültig
      end;
    end;
  if k<>1 then begin
    ungueltig('zu viele/wenige Schildkröten');
    exit;
  end;
  try
    Spielfeld.Free;
  finally
    Spielfeld:=TSpielfeld.erzeuge(hoehe,breite,Dateiinhalt); //Übergibt die StringList an das Objekt Spielfeld, damit dies dann die Felder erzeuge kann #OOP
  end;
  PaintBoxFeld.Canvas.Draw(40,40,Spielfeld.getBuffer);
  winter.Enabled:=true;
  sommer.Enabled:=true;
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Feld erfolgreich erstellt ---');
end;


procedure TForm1.ausDateiladen1Click(Sender: TObject);
begin
  OpenDialog1.Filter := 'Textdocuments (*.txt)|*.txt';
  OpenDialog1.InitialDir := GetCurrentDir;
  if OpenDialog1.Execute then begin
    DateiverarbeitenTxt();
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  PanelLog.Height:=round(screen.Height/5);
  PanelErzeugen.Width:=round(screen.Width/5);
  Sommer.Width:=round(Panelerzeugen.Width/2);
  Winter.Width:=round(Panelerzeugen.Width/2);
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Application started ---');
end;

procedure TForm1.sommerClick(Sender: TObject);
var resultat:boolean;
begin
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Prüfe Erreichbarkeit aller weißen Felder ---');
  resultat:=Spielfeld.sommer;
  Spielfeld.macherealeSchritte; //verhindert mehrmaliges Ausführen der Hamiltonprozedure
  if resultat=true then Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Alle weißen Felder sind von der Schildkröte begehbar! ---');
  if resultat=false then Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Alle weißen Felder sind von der Schildkröte nicht begehbar! ---');
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Erreichbarkeitssuche beendet ('+FloattoStr(Spielfeld.getSchritte)+' Schritte) ---');
end;

procedure TForm1.winterClick(Sender: TObject);
begin
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Hamiltonpfadsuche gestartet ---');
  Spielfeld.hamilton(-1);
  Spielfeld.macherealeSchritte; //verhindert mehrmaliges Ausführen der Hamiltonprozedure
  if Spielfeld.getloesung=true then Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Lösung für Hamiltonpfad gefunden! ('+Spielfeld.getpfad+') ---');
  if Spielfeld.getloesung=false then Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- keine Lösung für Hamiltonpfad gefunden! ---');
  Log.Lines.Add(FormatDateTime('hh:mm:ss.zzz', now)+'  --- Hamiltonpfadsuche beendet ('+FloattoStr(Spielfeld.getSchritte)+' Schritte) ---');
end;

procedure TForm1.ausEditoreinfgen1Click(Sender: TObject);
begin
  Notepad.ShowModal;
  if Notepad.Tag=0 then Dateiverarbeiteneditor();
end;

end.
