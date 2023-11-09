program ConsumirApis;

uses
  System.StartUpCopy,
  FMX.Forms,
  umain in 'umain.pas' {Form1},
  uFormat in 'Originais\uFormat.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
