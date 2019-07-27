object DM: TDM
  OldCreateOrder = False
  Height = 150
  Width = 412
  object FDCon: TFDConnection
    Params.Strings = (
      'Database=estilo_02072019'
      'User_Name=postgres'
      'DriverID=PG'
      'Password=postgres'
      'MonitorBy=Remote'
      'Server=kminformatica.no-ip.org'
      'Port=5436'
      'CharacterSet=LATIN1')
    Left = 23
    Top = 8
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
    Left = 95
    Top = 14
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 95
    Top = 70
  end
end
