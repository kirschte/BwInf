program Alphametriken1;

uses
  Forms,
  Alphametriken in 'Alphametriken.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Alphametriken';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
