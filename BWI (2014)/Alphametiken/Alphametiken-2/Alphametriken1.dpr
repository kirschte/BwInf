program Alphametriken1;

uses
  Forms,
  Alphametriken in 'Alphametriken.pas' {Form1},
  TRechnensub in 'TRechnensub.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
