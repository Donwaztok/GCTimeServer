unit Horario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IniFiles, GCTime;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SalvarForm3(Form: TForm; const Section: string);
    procedure AbrirForm3(Form: TForm; const Section: string);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}



//== Form Independente =========================================================
procedure TForm3.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
end;



//== Inicialização do Form =====================================================
procedure TForm3.FormCreate(Sender: TObject);
begin
  Form3.AbrirForm3(Form3, Form3.Name);
end;


procedure TForm3.FormHide(Sender: TObject);
begin
AnimateWindow(form3.Handle,1000,AW_BLEND+AW_HIDE);
end;

//== Mover Janela ==============================================================
Procedure TForm3.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
if Form1.mouse=1 then
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);

  if Left < 0 then Left := 0;
  if Top < 0 then Top := 0;
  if Screen.Width - (Left + Width) < 0 then Left := Screen.Width - Width;
  if Screen.Height - (Top + Height) < 0 then Top := Screen.Height - Height;
end;

end;



procedure TForm3.FormShow(Sender: TObject);
begin
ShowWindow(Form3.Handle, SW_HIDE) ;
SetWindowLong(Form3.Handle, GWL_EXSTYLE, getWindowLong(Application.Handle,
GWL_EXSTYLE) or WS_EX_TOOLWINDOW) ;
AnimateWindow(form3.Handle,1000,AW_BLEND);
end;

//== Mover Janela ==============================================================
procedure TForm3.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
if Form1.mouse=1 then
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);

  if Left < 0 then Left := 0;
  if Top < 0 then Top := 0;
  if Screen.Width - (Left + Width) < 0 then Left := Screen.Width - Width;
  if Screen.Height - (Top + Height) < 0 then Top := Screen.Height - Height;
end;

end;

//== Salvar Posição do Form 3 ==================================================
procedure TForm3.SalvarForm3(Form: TForm; const Section: string);
var
  Ini3: TIniFile;

begin
  Ini3 := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
      Ini3.WriteInteger('Form3','Top', Form3.Top);
      Ini3.WriteInteger('Form3','Left', Form3.Left);
      Ini3.Free;
end;
//== Carregar Posição do Form 3 ================================================
procedure TForm3.AbrirForm3(Form: TForm; const Section: string);
var
  Ini3: TIniFile;
begin
  Ini3 := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    Form3.Top := Ini3.ReadInteger('Form3','Top',0);
    Form3.Left := Ini3.ReadInteger('Form3','Left',0);
end;
//==============================================================================
end.
