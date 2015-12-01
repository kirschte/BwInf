unit uNotepad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TNotepad = class(TForm)
    Ok: TButton;
    Abbrechen: TButton;
    notepadSL: TMemo;
    procedure AbbrechenClick(Sender: TObject);
    procedure OkClick(Sender: TObject);
  private
    { Private-Deklarationen }
    SL: TStringList; //Inhalt des Memos
  public
    { Public-Deklarationen }
    function getSL:TStringList;
  end;

var
  Notepad: TNotepad;

implementation

{$R *.dfm}

procedure TNotepad.AbbrechenClick(Sender: TObject);
begin
Notepad.Tag:=1;
Notepad.Close;
end;

procedure TNotepad.OkClick(Sender: TObject);
var i:integer;
begin
  SL:=TStringList.Create;
  for I := 0 to NotepadSL.Lines.Count-1 do
    SL.Insert(i,NotepadSL.Lines[i]);
  Notepad.Tag:=0;
  Notepad.Close;
end;

function TNotepad.getSL;
begin
  result:=SL;
end;

end.
