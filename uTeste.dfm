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
    Width = 563
    Height = 21
    TabOrder = 0
    Text = 
      'https://api.suasvendas.com/api/Pedido?dataHoraAtualizacao=2019-0' +
      '7-26'
  end
  object btnGet: TButton
    Left = 70
    Top = 38
    Width = 83
    Height = 21
    Caption = 'Start GET'
    TabOrder = 1
    OnClick = btnGetClick
  end
  object mJson: TMemo
    Left = 0
    Top = 296
    Width = 723
    Height = 180
    Align = alBottom
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object mTerminal: TMemo
    Left = 0
    Top = 88
    Width = 723
    Height = 208
    Align = alBottom
    Lines.Strings = (
      '')
    TabOrder = 3
  end
  object pbGetting: TProgressBar
    Left = 0
    Top = 71
    Width = 723
    Height = 17
    Align = alBottom
    TabOrder = 4
    ExplicitLeft = 2
    ExplicitTop = 65
    ExplicitWidth = 719
  end
  object btnPauseGet: TButton
    Left = 159
    Top = 38
    Width = 122
    Height = 21
    Caption = 'Pause/Resume GET'
    TabOrder = 5
    OnClick = btnPauseGetClick
  end
  object btnCancelGet: TButton
    Left = 287
    Top = 38
    Width = 94
    Height = 21
    Caption = 'Cancel GET'
    TabOrder = 6
    OnClick = btnCancelGetClick
  end
end
