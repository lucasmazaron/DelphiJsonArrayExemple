program prjJsonTeste;

uses
  Vcl.Forms,
  uTeste in 'uTeste.pas' {Form1},
  uJsonThread in 'uJsonThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
