unit uJsonThread;

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
  FireDAC.Moni.RemoteClient, FireDAC.Dapt, Vcl.ComCtrls, uDM;

type
  TJsonThread = class(TThread)
  private
    FUrl: String;
    FTerminal: TMemo;
    FJson: TMemo;
    FProgressBar: TProgressBar;

    function ExisteRegistro(const ACodPed: String): Boolean;
    procedure JsonToArray(AJsonStream: TStringStream);
    procedure InsereDadosPedido(AJsonObj: TJsonObject);
    { Private declarations }
  public
    constructor Create(AUrl: String; ATerminal, AJson: TMemo; AProgressBar: TProgressBar); reintroduce;
    procedure Synchronize(AItem: TJSONValue);
  protected
    procedure Execute; override;
  end;

implementation

{ TJsonThread }

var
  IsPedidoExistente: Boolean;

constructor TJsonThread.Create(AUrl: String; ATerminal, AJson: TMemo; AProgressBar: TProgressBar);
begin
  inherited Create(True);
  FUrl         := AUrl;
  FTerminal    := ATerminal;
  FJson        := AJson;

  FProgressBar := AProgressBar;
  FProgressBar.Min := 0;
  FProgressBar.Position := 0;

  Self.FreeOnTerminate := True;
end;

procedure TJsonThread.Execute;
const
  TOKEN = 'Yoursoft w3nUro1o73QrYN6fwEC7534dF7FtCinFWF5s5xvDw02tcU1oq0'+
          'G2o3M87U8uBHvfrHG17334QtnEmxS5oIFw7ap15Fq7cAnhu6AH-0BA74B3E'+
          '0C6A635D45A3429F000FAB8FC05A7B5C';
var
  JsonStream: TStringStream;
begin
  DM.FDCon.Connected := True;
  JsonStream := TStringStream.Create(EmptyStr, TEncoding.UTF8);

  try
    { JsonStream conterá os dados JSON requisitados :}
    DM.IdHttp1.Request.CustomHeaders.AddValue('Authorization', TOKEN);
    DM.idHttp1.Get(FUrl, JsonStream);
    JsonStream.Position := 0;
    JsonToArray(JsonStream);
  finally
    JsonStream.Free;
    DM.FDCon.Connected := False;
  end;
end;

function TJsonThread.ExisteRegistro(const ACodPed: String): Boolean;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);
  Qry.Connection := DM.FDCon;
  try
    Qry.Open('select count(1)'+
             '  from intpedid p'+
             ' where p.ccodigopedid = ' + QuotedStr(ACodPed));

    Result := Qry.Fields[0].AsInteger > 0;
  finally
    Qry.Free;
  end;
end;

procedure TJsonThread.JsonToArray(AJsonStream: TStringStream);
var
  JsonObj: TJSONObject;
  JsonArr: TJSONArray;
  JsonValue: TJSONValue;
  Item: TJSONValue;
begin
  JsonObj := TJsonObject.Create;
  try
//    JsonObj.Parse(AJsonStream.Bytes, 0);
    JsonArr := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(AJsonStream.DataString), 0) as TJSONArray;

    FJson.Lines.Text := ' Há ' + IntToStr(JsonArr.Count) + ' pedidos a serem tratados!' + sLineBreak;
    FJson.Lines.Text := FJson.Lines.Text + JsonArr.ToString;
    FProgressBar.Max := JsonArr.Count;
    for JsonValue in JsonArr do
    begin
//      ShowMessage(JsonValue.ToString);

      JsonObj := (JsonValue as TJSONObject);
      Item    := JsonObj.GetValue('pedi_id');

      IsPedidoExistente := ExisteRegistro(Item.ToString);

      Self.Synchronize(Item);

      if not IsPedidoExistente then
      begin
        InsereDadosPedido(JsonObj);
      end;

//      Self.Sleep(1);

//      ShowMessage(Item.ToString);
//      for Item in TJSONArray(JsonValue) do
//      begin
//        ShowMessage(Format('%s : %s',[TJSONPair(Item).JsonString.Value, TJSONPair(Item).JsonValue.Value]));
//      end;
      FProgressBar.Position := FProgressBar.Position + 1;
    end;
  finally
    JsonObj.Free;
  end;
end;

procedure TJsonThread.InsereDadosPedido(AJsonObj: TJsonObject);
var
  QryLeitura: TFDQuery;
  InsertFields, InsertValues: String;
  Item: TJSONValue;
begin

  InsertFields := ' insert into public.intpedid (nnumeroparce';
  InsertValues := ' values (1';

  QryLeitura := TFDQuery.Create(nil);
  QryLeitura.Connection := DM.FDCon;

  try
    QryLeitura.Open('select * '+
                    '  from intleitu ' +
                    ' where ctblintleitu = ' + QuotedStr('intpedid'));

    QryLeitura.First;
    while not QryLeitura.Eof do
    begin
      InsertFields := InsertFields + ', ' + QryLeitura.FieldByName('ccmpintleitu').AsString;

      Item := AJsonObj.GetValue(QryLeitura.FieldByName('ccmpextleitu').AsString);

      if Assigned(Item) then
      begin
        if QryLeitura.FieldByName('ctpcpinleitu').AsString = 'numeric' then
        begin
          InsertValues := InsertValues + ', ' + Item.ToString;
        end
        else
        begin
          InsertValues := InsertValues + ', ' + QuotedStr(Item.ToString);
        end;
      end;

      QryLeitura.Next;
    end;

    InsertFields := InsertFields + ')';
    InsertValues := InsertValues + ')';

    FTerminal.Lines.Add('-----------------------');
    FTerminal.Lines.Add(InsertFields+InsertValues);
    FTerminal.Lines.Add('-----------------------');
  finally
    QryLeitura.Free;
  end;
end;

procedure TJsonThread.Synchronize(AItem: TJSONValue);
begin
  if IsPedidoExistente then
  begin
    FTerminal.Lines.Add(' Pedido ' + AItem.ToString + ' JÁ importado!');
  end
  else
  begin
    FTerminal.Lines.Add(' Pedido ' + AItem.ToString + ' NÃO importado!');
  end;
end;

end.
