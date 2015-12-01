program Hamiltonproblem;

{$R 'res\Images.res' 'res\Images.rc'}

uses
  Forms,
  Main in 'Main.pas' {Form1},
  uFeld in 'uFeld.pas',
  uSpielfeld in 'uSpielfeld.pas',
  uNotepad in 'uNotepad.pas' {Notepad};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Hamiltonpfad';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TNotepad, Notepad);
  Application.Run;
end.
