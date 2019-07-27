unit uTeste;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, System.JSON;

type
  TForm1 = class(TForm)
    edtLink: TEdit;
    Label1: TLabel;
    btnGet: TButton;
    IdHTTP1: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    mJson: TMemo;
    procedure btnGetClick(Sender: TObject);
  private
    procedure JsonToStr(AJsonStream: TStringStream);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnGetClick(Sender: TObject);
const
  TOKEN = 'Yoursoft w3nUro1o73QrYN6fwEC7534dF7FtCinFWF5s5xvDw02tcU1oq0'+
          'G2o3M87U8uBHvfrHG17334QtnEmxS5oIFw7ap15Fq7cAnhu6AH-0BA74B3E'+
          '0C6A635D45A3429F000FAB8FC05A7B5C';
var
  JsonStream: TStringStream;
begin
  JsonStream := TStringStream.Create(EmptyStr, TEncoding.UTF8);

  try
    { JsonStream conterá os dados JSON requisitados :}
    IdHttp1.Request.CustomHeaders.AddValue('Authorization', TOKEN);
    idHttp1.Get(edtLink.Text, JsonStream);
    JsonStream.Position := 0;
    JsonToStr(JsonStream);
  finally
    JsonStream.Free();
  end;

end;

procedure TForm1.JsonToStr(AJsonStream: TStringStream);
var
  JsonObj: TJSONObject;
  JsonArr: TJSONArray;
  JsonValue: TJSONValue;
  Item: TJSONValue;
begin
  JsonObj := TJsonObject.Create;
  try
    JsonObj.Parse(AJsonStream.Bytes, 0);
    mJson.Lines.LoadFromStream(AJsonStream, TEncoding.UTF8);

    JsonArr := JsonObj.ParseJSONValue(TEncoding.UTF8.GetBytes(AJsonStream.DataString), 0) as TJSONArray;
    for JsonValue in JsonArr do
    begin
      ShowMessage(JsonValue.ToString);

      JsonObj := (JsonValue as TJSONObject);
      Item := JsonObj.GetValue('pedi_id');

      ShowMessage(Item.ToString);
//      for Item in TJSONArray(JsonValue) do
//      begin
//        ShowMessage(Format('%s : %s',[TJSONPair(Item).JsonString.Value, TJSONPair(Item).JsonValue.Value]));
//      end;
    end;
  finally
    JsonObj.Free;
  end;
end;

end.
