program GCTimeServer;

uses
  Vcl.Forms,
  GCTime in 'Forms\GCTime.pas' {Form1},
  PopUp in 'Forms\PopUp.pas' {Form2},
  Horario in 'Forms\Horario.pas' {Form3},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Carbon');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
