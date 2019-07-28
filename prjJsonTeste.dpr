program prjJsonTeste;

uses
  Vcl.Forms,
  uTeste in 'uTeste.pas' {Form1},
  uJsonThread in 'uJsonThread.pas',
  uDM in 'uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
