unit PopUp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, IniFiles, GCTime;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Image1: TImage;
    Timer1: TTimer;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SalvarForm2(Form: TForm; const Section: string);
    procedure AbrirForm2(Form: TForm; const Section: string);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    tempo:integer;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}


//== Form Independente =========================================================
procedure TForm2.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.WndParent := 0;
//==============================================================================
end;


//== Posição do Form OnCreate ==================================================
procedure TForm2.FormCreate(Sender: TObject);
begin
  Form2.AbrirForm2(Form2, Form2.Name);
  ShowWindow(Form2.Handle,SW_HIDE);
tempo:=0;
//==============================================================================
end;

//== Efeito ao Esconder o Form =================================================
procedure TForm2.FormHide(Sender: TObject);
begin
AnimateWindow(form2.Handle,1000,AW_BLEND+AW_HIDE);
//==============================================================================
end;

//== Mover Janela e Fechar com Botão Direito ===================================
Procedure TForm2.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
if ssLeft in Shift then {botão esquerdo acionado};
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

if ssRight in Shift then if Form1.mouse=0 then Form2.Hide; {botão direito acionado};
if ssMiddle in Shift then if Form1.mouse=0 then Form2.Hide; {botão do meio acionado};
//==============================================================================
end;


procedure TForm2.FormShow(Sender: TObject);
//== Efeito ao Mostrar o Form ==================================================
begin
ShowWindow(Form2.Handle, SW_HIDE) ;
SetWindowLong(Form2.Handle, GWL_EXSTYLE, getWindowLong(Application.Handle,
GWL_EXSTYLE) or WS_EX_TOOLWINDOW) ;
AnimateWindow(form2.Handle,1000,AW_BLEND);
//==============================================================================
end;

//== Mover Janela ==============================================================
procedure TForm2.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
if ssLeft in Shift then {botão esquerdo acionado};
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

if ssRight in Shift then if Form1.mouse=0 then Form2.Hide; {botão direito acionado};
if ssMiddle in Shift then if Form1.mouse=0 then Form2.Hide; {botão do meio acionado};
//==============================================================================
end;


//== Mover Janela ==============================================================
procedure TForm2.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
if ssLeft in Shift then {botão esquerdo acionado};
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

if ssRight in Shift then if Form1.mouse=0 then Form2.Hide; {botão direito acionado};
if ssMiddle in Shift then if Form1.mouse=0 then Form2.Hide; {botão do meio acionado};
//==============================================================================
end;


//== Salvar Posição do Form 2 ==================================================
procedure TForm2.SalvarForm2(Form: TForm; const Section: string);
var
  Ini2: TIniFile;
begin
  Ini2 := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
      Ini2.WriteInteger('Form2','Top', Form2.Top);
      Ini2.WriteInteger('Form2','Left', Form2.Left);
      Ini2.Free;
//==============================================================================
end;

procedure TForm2.Timer1Timer(Sender: TObject);
//== Fechar o Form Após '6 segundos' ===========================================
var DirImg:String;
begin
DirImg := ExtractFileDir(ParamStr(0))+'\Textures\';
if tempo = 5 then
  begin
    Timer1.Enabled:=False;
    tempo:=0;
    Form2.Hide;
    Label1.Caption:='_____________';
    Image1.Picture.LoadFromFile(DirImg+'popup.PNG');
  end else tempo:=tempo+1;
//==============================================================================
end;

//== Carregar Posição do Form 2 ================================================
procedure TForm2.AbrirForm2(Form: TForm; const Section: string);
var
  Ini2: TIniFile;
begin
  Ini2 := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    Form2.Top := Ini2.ReadInteger('Form2','Top',0);
    Form2.Left := Ini2.ReadInteger('Form2','Left',0);
end;
//==============================================================================
end.
