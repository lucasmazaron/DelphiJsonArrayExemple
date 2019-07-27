object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 476
  ClientWidth = 723
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 19
    Width = 38
    Height = 13
    Caption = 'Link API'
  end
  object edtLink: TEdit
    Left = 70
    Top = 16
    Width = 686
    Height = 21
    TabOrder = 0
    Text = 
      'https://api.suasvendas.com/api/Pedido?dataHoraAtualizacao=2019-0' +
      '7-26'
  end
  object btnGet: TButton
    Left = 70
    Top = 43
    Width = 75
    Height = 25
    Caption = 'GET'
    TabOrder = 1
    OnClick = btnGetClick
  end
  object mJson: TMemo
    Left = 0
    Top = 96
    Width = 723
    Height = 380
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 2
    ExplicitTop = 112
    ExplicitWidth = 726
  end
  object IdHTTP1: TIdHTTP
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 416
    Top = 56
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 536
    Top = 64
  end
end
