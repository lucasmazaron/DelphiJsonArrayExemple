unit uTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.PG, FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.UI, FireDAC.Moni.Base,
  FireDAC.Moni.RemoteClient, FireDAC.Dapt, Vcl.ComCtrls, uJsonThread;

type
  TForm1 = class(TForm)
    edtLink: TEdit;
    Label1: TLabel;
    btnGet: TButton;
    mJson: TMemo;
    mTerminal: TMemo;
    pbGetting: TProgressBar;
    btnPauseGet: TButton;
    btnCancelGet: TButton;
    procedure btnGetClick(Sender: TObject);
    procedure btnPauseGetClick(Sender: TObject);
    procedure btnCancelGetClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var
  JsonThread: TJsonThread;


procedure TForm1.btnCancelGetClick(Sender: TObject);
begin
  TerminateThread(JsonThread.Handle, 0);

  mTerminal.Clear;
  mTerminal.Lines.Add('Thread Cancelada!');
  pbGetting.Position := 0;
end;

procedure TForm1.btnGetClick(Sender: TObject);
begin
  if not Assigned(JsonThread) then
  begin
    JsonThread := TJsonThread.Create(edtLink.Text, mTerminal, mJson, pbGetting);
    JsonThread.Start;
  end;
end;

procedure TForm1.btnPauseGetClick(Sender: TObject);
begin
  if Assigned(JsonThread) then
  begin
    if JsonThread.Suspended then
    begin
     JsonThread.Suspended := False;
    end
    else
    begin
     JsonThread.Suspended := True;
    end;
  end;
end;

end.
