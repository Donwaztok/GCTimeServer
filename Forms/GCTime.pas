unit GCTime;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, Vcl.ComCtrls, INIFiles, Vcl.Mask,
  Vcl.ColorGrd, Vcl.Imaging.pngimage, FileCtrl, ShellApi, Vcl.ExtDlgs,
  Vcl.MPlayer, JPEG, Vcl.Imaging.GIFImg;

type
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    Timer1: TTimer;
    Button1: TButton;
    Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button2: TButton;
    Label2: TLabel;
    qtdaltar: TEdit;
    qtdfor: TEdit;
    qtdtorre: TEdit;
    qtdberkas: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Label8: TLabel;
    ListBox3: TListBox;
    Label9: TLabel;
    ListBox4: TListBox;
    Label10: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button8: TButton;
    Label7: TLabel;
    Button9: TButton;
    Button10: TButton;
    MaskEdit1: TMaskEdit;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Abrir1: TMenuItem;
    Sair1: TMenuItem;
    FecharTudo1: TMenuItem;
    Button11: TButton;
    About: TTabSheet;
    Button12: TButton;
    Label11: TLabel;
    Image1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Image3: TImage;
    Edit4: TEdit;
    Button14: TButton;
    Button15: TButton;
    Label23: TLabel;
    TabSheet4: TTabSheet;
    Button17: TButton;
    CheckBox2: TCheckBox;
    Label24: TLabel;
    ListBox5: TListBox;
    ProgressBar1: TProgressBar;
    Button16: TButton;
    Image4: TImage;
    Label25: TLabel;
    Image5: TImage;
    CheckBox3: TCheckBox;
    MediaPlayer1: TMediaPlayer;
    procedure Minimizando(Sender:TObject);
    procedure SalvarForm1(Form: TForm; const Section: string);
    procedure AbrirForm1(Form: TForm; const Section: string);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure FecharTudo1Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    time1a,time2a,time3a :TDateTime;
    timepc,timedif : TDateTime;
    hora,timea : string;
    ver,mouse : integer;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses PopUp,Horario;
//==============================================================================
//==============================================================================


//== Função para Analisar os Logs ==============================================
procedure AnalisarLogs(arq: string);
var
  SR: TSearchRec;
  I: integer;
begin
  I := FindFirst(Form1.Edit4.Text+'\'+arq, faAnyFile, SR);
  while I = 0 do begin if (SR.Attr and faDirectory) <> faDirectory then
      Form1.ListBox5.Items.Add(SR.name);
  I := FindNext(SR);

  end;
//==============================================================================
end;


//== Função para Deletar os Logs ===============================================
procedure DeletarLogs(arq: string);
var
  SR: TSearchRec;
  I: Integer;
begin
  I := FindFirst(Form1.Edit4.Text+'\'+arq, faAnyFile, SR);
  while I = 0 do begin if (SR.Attr and faDirectory) <> faDirectory then
    if DeleteFile(Form1.Edit4.Text + '\' + SR.Name) then
        Form1.ListBox5.Items.Add(SR.name);
  I := FindNext(SR);

  end;
//==============================================================================
end;



//== Função da Versão do Aplicativo ============================================
Function VersaoExe: String;
type
   PFFI = ^vs_FixedFileInfo;
var
   F       : PFFI;
   Handle  : Dword;
   Len     : Longint;
   Data    : Pchar;
   Buffer  : Pointer;
   Tamanho : Dword;
   Parquivo: Pchar;
   Arquivo : String;
begin
   Arquivo  := Application.ExeName;
   Parquivo := StrAlloc(Length(Arquivo) + 1);
   StrPcopy(Parquivo, Arquivo);
   Len := GetFileVersionInfoSize(Parquivo, Handle);
   Result := '';
   if Len > 0 then
   begin
      Data:=StrAlloc(Len+1);
      if GetFileVersionInfo(Parquivo,Handle,Len,Data) then
      begin
         VerQueryValue(Data, '',Buffer,Tamanho);
         F := PFFI(Buffer);
         Result := Format('%d.%d.%d.%d',
                          [HiWord(F^.dwFileVersionMs),
                           LoWord(F^.dwFileVersionMs),
                           HiWord(F^.dwFileVersionLs),
                           Loword(F^.dwFileVersionLs)]
                         );
      end;
      StrDispose(Data);
   end;
   StrDispose(Parquivo);
//==============================================================================
end;

//==============================================================================
//==============================================================================


procedure TForm1.Minimizando(Sender:TObject);
begin
 ShowWindow(Form1.Handle,SW_HIDE);
end;

//==============================================================================
//==============================================================================
procedure TForm1.SalvarForm1(Form: TForm; const Section: string);
var
  Ini1: TIniFile;
//== Salvar Posição do Form1 ===================================================
begin
  Ini1 := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
      Ini1.WriteInteger('Form1','Top', Form1.Top);
      Ini1.WriteInteger('Form1','Left', Form1.Left);
      Ini1.Free;
end;
//== PopUpMenu Abrir ===========================================================
procedure TForm1.Abrir1Click(Sender: TObject);
begin
ShowWindow(Form1.Handle,SW_Restore);
Form1.SetFocus;
end;

procedure TForm1.AbrirForm1(Form: TForm; const Section: string);
//== Carregar Posição do Form1 =================================================
var
  Ini1: TIniFile;
begin
  Ini1 := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    Form1.Top := Ini1.ReadInteger('Form1','Top',0);
    Form1.Left := Ini1.ReadInteger('Form1','Left',0);
end;
//==============================================================================

Procedure DespertadorAltar;
var i:integer; DirImg,DirSound:String;
begin
//============ Altar ===========================================================
DirImg := ExtractFileDir(ParamStr(0))+'\Textures\';
DirSound := ExtractFileDir(ParamStr(0))+'\Sound\Altar\';
  for i:=0 to Form1.ListBox1.Items.Count-1 do
    begin
    //====== 5 min para abrir Altar ============================================
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:05:00');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          Form2.Label1.Caption:='5 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
          if form1.hora <> '00:05:00' then
            begin
              Form2.Show;
              Form2.Timer1.Enabled:=True;
              Form2.tempo:=0;
              if Form1.CheckBox3.Checked=True then
                begin
                  Form1.MediaPlayer1.Close;
                  Form1.MediaPlayer1.FileName:=
                    DirSound+'cinco minutos para abrir altar.mp3';
                  Form1.MediaPlayer1.Open;
                  Form1.MediaPlayer1.Play;
                end;
            end;
        end;
    //====== 3 min para abrir Altar ============================================
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:03:00');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
          if form1.hora <> '00:03:00' then
            begin
              Form2.Show;
              Form2.Timer1.Enabled:=True;
              Form2.tempo:=0;
              if Form1.CheckBox3.Checked=True then
                begin
                  Form1.MediaPlayer1.Close;
                  Form1.MediaPlayer1.FileName:=
                    DirSound+'tres minutos para abrir altar.mp3';
                  Form1.MediaPlayer1.Open;
                  Form1.MediaPlayer1.Play;
                end;
            end;
        end;
    //====== 1 min para abrir Altar ============================================
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:01:00');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='1 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
          if form1.hora <> '00:01:00' then
            begin
              Form2.Show;
              Form2.Timer1.Enabled:=True;
              Form2.tempo:=0;
              if Form1.CheckBox3.Checked=True then
                begin
                  Form1.MediaPlayer1.Close;
                  Form1.MediaPlayer1.FileName:=
                    DirSound+'um minuto para abrir altar.mp3';
                  Form1.MediaPlayer1.Open;
                  Form1.MediaPlayer1.Play;
                end;
            end;
        end;
    //====== Abrir Altar =======================================================
     if form1.hora = form1.ListBox1.Items[i] then
        begin
          Form2.Label1.Caption:='Aberto';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
          Form2.Show;
          Form2.Timer1.Enabled:=True;
          Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=DirSound+'altar abriu.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:00:06');
     form1.timea := TimeToStr(form1.time1a+form1.time2a);
     if form1.hora = form1.timea then
      begin
        Form2.Hide;
      end;
    //====== 5 min para Fechar Altar ===========================================
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:25:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          Form2.Label1.Caption:='5 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'cinco minutos para fechar altar.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 3 min para Fechar Altar ===========================================
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:27:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'tres minutos para fechar altar.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 1 min para Fechar Altar ===========================================
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:29:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          Form2.Label1.Caption:='1 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'um minuto para fechar altar.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== Fechar Altar ======================================================
     form1.time1a := StrToTime(form1.ListBox1.Items[i]);
     form1.time2a := StrToTime('00:30:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='Fechou';
          Form2.Image1.Picture.LoadFromFile(DirImg+'altar_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'altar fechou.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
//==============================================================================
    end;
end;

//==============================================================================
//==============================================================================

Procedure DespertadorFornalha;
var i:integer; DirImg,DirSound:String;
begin
//============ Fornalha ========================================================
DirImg := ExtractFileDir(ParamStr(0))+'\Textures\';
DirSound := ExtractFileDir(ParamStr(0))+'\Sound\Fornalha\';
  for i:=0 to Form1.ListBox2.Items.Count-1 do
    begin
    //====== 5 min para abrir Fornalha =========================================
     form1.time1a := StrToTime(form1.ListBox2.Items[i]);
     form1.time2a := StrToTime('00:05:00');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='5 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'cinco minutos para abrir fornalha.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 3 min para abrir Fornalha =========================================
     form1.time1a := StrToTime(form1.ListBox2.Items[i]);
     form1.time2a := StrToTime('00:03:00');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'tres minutos para abrir fornalha.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 1 min para abrir Fornalha =========================================
     form1.time1a := StrToTime(form1.ListBox2.Items[i]);
     form1.time2a := StrToTime('00:01:00');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='1 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'um minuto para abrir fornalha.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== Abrir Fornalha ====================================================
     if form1.hora = form1.ListBox2.Items[i] then
        begin
          Form2.Label1.Caption:='Aberto';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=DirSound+'fornalha abriu.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 5 min para Fechar Fornalha ========================================
     form1.time1a := StrToTime(form1.ListBox2.Items[i]);
     form1.time2a := StrToTime('00:25:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='5 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'cinco minutos para fechar fornalha.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 3 min para Fechar Fornalha ========================================
     form1.time1a := StrToTime(form1.ListBox2.Items[i]);
     form1.time2a := StrToTime('00:27:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'tres minutos para fechar fornalha.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 1 min para Fechar Fornalha ========================================
     form1.time1a := StrToTime(form1.ListBox2.Items[i]);
     form1.time2a := StrToTime('00:29:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='1 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'um minuto para fechar fornalha.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== Fechar Fornalha ===================================================
     form1.time1a := StrToTime(form1.ListBox2.Items[i]);
     form1.time2a := StrToTime('00:30:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='Fechou';
          Form2.Image1.Picture.LoadFromFile(DirImg+'fornalha_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'fornalha fechou.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
//==============================================================================
    end;
end;

//==============================================================================
//==============================================================================


Procedure DespertadorTorre;
var i:integer; DirImg,DirSound:String;
begin
//============ Torre ===========================================================
DirImg := ExtractFileDir(ParamStr(0))+'\Textures\';
DirSound := ExtractFileDir(ParamStr(0))+'\Sound\Torre\';
  for i:=0 to Form1.ListBox3.Items.Count-1 do
    begin
    //====== 5 min para abrir Torre ============================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:05:08');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          Form2.Label1.Caption:='5 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'cinco minutos para abrir torre.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 3 min para abrir Torre ============================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:03:08');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'tres minutos para abrir torre.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 1 min para abrir Torre ============================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:01:08');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='1 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'um minuto para abrir torre.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== Abrir Torre =======================================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:00:08');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='Aberto';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=DirSound+'torre abriu.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 5 min para Fechar Torre ===========================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:15:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='5 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'cinco minutos para fechar torre.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 3 min para Fechar Torre ===========================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:17:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'tres minutos para fechar torre.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 1 min para Fechar Torre ===========================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:19:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='1 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'um minuto para fechar torre.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== Fechar Torre ======================================================
     form1.time1a := StrToTime(form1.ListBox3.Items[i]);
     form1.time2a := StrToTime('00:20:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='Fechou';
          Form2.Image1.Picture.LoadFromFile(DirImg+'torre_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=DirSound+'torre fechou.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
//==============================================================================
    end;
end;

//==============================================================================
//==============================================================================


Procedure DespertadorBerkas;
var i:integer; DirImg,DirSound:String;
begin
//============ Berkas ==========================================================
DirImg := ExtractFileDir(ParamStr(0))+'\Textures\';
DirSound := ExtractFileDir(ParamStr(0))+'\Sound\Berkas\';
  for i:=0 to Form1.ListBox4.Items.Count - 1 do
    begin
    //====== 5 min para abrir Berkas ===========================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:05:08');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          Form2.Label1.Caption:='5 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
          if form1.hora <> '00:05:08' then
            begin
              Form2.Show;
              Form2.Timer1.Enabled:=True;
              Form2.tempo:=0;
                if Form1.CheckBox3.Checked=True then
                  begin
                    Form1.MediaPlayer1.Close;
                    Form1.MediaPlayer1.FileName:=
                      DirSound+'cinco minutos para abrir berkas.mp3';
                    Form1.MediaPlayer1.Open;
                    Form1.MediaPlayer1.Play;
                  end;
            end;
        end;
    //====== 3 min para abrir Berkas ===========================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:03:08');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
          if form1.hora <> '00:03:08' then
            begin
              Form2.Show;
              Form2.Timer1.Enabled:=True;
              Form2.tempo:=0;
                if Form1.CheckBox3.Checked=True then
                  begin
                    Form1.MediaPlayer1.Close;
                    Form1.MediaPlayer1.FileName:=
                      DirSound+'tres minutos para abrir berkas.mp3';
                    Form1.MediaPlayer1.Open;
                    Form1.MediaPlayer1.Play;
                  end;
            end;
        end;
    //====== 1 min para abrir Berkas ===========================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:01:08');
     form1.time3a := form1.time1a-form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='1 min p/ Abrir';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
          if form1.hora <> '00:01:08' then
            begin
              Form2.Show;
              Form2.Timer1.Enabled:=True;
              Form2.tempo:=0;
                if Form1.CheckBox3.Checked=True then
                  begin
                    Form1.MediaPlayer1.Close;
                    Form1.MediaPlayer1.FileName:=
                      DirSound+'um minuto para abrir berkas.mp3';
                    Form1.MediaPlayer1.Open;
                    Form1.MediaPlayer1.Play;
                  end;
            end;
        end;
    //====== Abrir Berkas ======================================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:00:08');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='Aberto';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=DirSound+'berkas abriu.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 5 min para Fechar Berkas ==========================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:15:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='5 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'cinco minutos para fechar berkas.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 3 min para Fechar Berkas ==========================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:17:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='3 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'tres minutos para fechar berkas.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== 1 min para Fechar Berkas ==========================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:19:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='1 min p/ Fechar';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'um minuto para fechar berkas.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
    //====== Fechar Berkas =====================================================
     form1.time1a := StrToTime(form1.ListBox4.Items[i]);
     form1.time2a := StrToTime('00:20:00');
     form1.time3a := form1.time1a+form1.time2a;
     if form1.hora = TimeToStr(form1.time3a) then
        begin
          form2.Label1.Caption:='Fechou';
          Form2.Image1.Picture.LoadFromFile(DirImg+'berkas_popup.PNG');
           Form2.Show;
           Form2.Timer1.Enabled:=True;
           Form2.tempo:=0;
            if Form1.CheckBox3.Checked=True then
              begin
                Form1.MediaPlayer1.Close;
                Form1.MediaPlayer1.FileName:=
                  DirSound+'berkas fechou.mp3';
                Form1.MediaPlayer1.Open;
                Form1.MediaPlayer1.Play;
              end;
        end;
//==============================================================================
    end;
end;

//==============================================================================
//==============================================================================



procedure TForm1.Button10Click(Sender: TObject);
begin
//== Resetar Posição dos forms =================================================
  form1.Top:=0;
  form1.Left:=0;
  form2.Top:=0;
  form2.Left:=0;
  form3.Top:=0;
  form3.Left:=0;
//==============================================================================
end;


procedure TForm1.Button11Click(Sender: TObject);
begin
mouse:=0;
//== Cancelar alteração das posiões dos Forms ==================================
Form2.Hide;
Form3.Hide;
Button1.Enabled:=True;
Button2.Enabled:=False;
Button8.Enabled:=True;
Button9.Enabled:=False;
Button10.Enabled:=False;
button11.Enabled:=False;
CheckBox1.Checked:=True;
Form2.AbrirForm2(Form2,Form2.Name);
Form3.AbrirForm3(Form3,Form3.Name);
//==============================================================================
end;

procedure TForm1.Button12Click(Sender: TObject);
//== Trocar Imagem do Bottom ===================================================
var
path,name,destino,PictureExt: string;
Picture: TIniFile;
begin
//== Copia a Imagem para Textures ==============================================
if OpenPictureDialog1.Execute then
begin
path := ExtractFilePath(OpenPictureDialog1.FileName);
name := ExtractFileName(OpenPictureDialog1.FileName);
destino := ExtractFilePath(ParamStr(0))+'Images\'+name;
if not CopyFile(PChar(path+name), PChar(destino), false) then
      ShowMessage('Erro ao copiar ' + path+name + ' para ' + destino);
end;
//== Salvar Nome da Imagem no .ini =============================================
  Picture := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
  Picture.WriteString('Picture','Name',name);
  Picture.Free;
//== Coloca a imagem no Bottom==================================================
Image1.Picture.LoadFromFile(ExtractFilePath(ParamStr(0))+'Images\'+name);

//== Animando o GIF ============================================================
PictureExt := ExtractFileExt(name);
if PictureExt='.gif' then
TGIFImage(Image1.Picture.Graphic).Animate :=True;
//==============================================================================
end;

procedure TForm1.Button14Click(Sender: TObject);
var
    selDir : string;
begin
//== Escolhendo o Local da Pasta do Grand Chase ================================
  if SelectDirectory('Selecione a pasta do Grand Chase','', selDir) then
    begin
     Edit4.Text:=selDir;
     Label24.Caption:='[ '+selDir+'\ ]';
    end;
//==============================================================================
end;

procedure TForm1.Button15Click(Sender: TObject);
var caminho : string;
    F       : TextFile;
begin
//== Criando .Bat e Abrindo o Grand Chase ======================================
if (fileExists(Edit4.Text+'\grandchase.exe')) then
  begin
    caminho := ExtractFileDir(ParamStr(0))+'\ini.bat' ;
    AssignFile(F,caminho);
    Rewrite(F);
    WriteLn(F, '@cls');
    WriteLn(F, '@'+copy(Edit4.text,1,2));
    WriteLn(F, '@cd '+copy(Edit4.text,1,2)+'\');
    WriteLn(F, '@cd '+Edit4.Text+'\');
    WriteLn(F, 'Start grandchase.exe');
    CloseFile(F);
    if (fileExists(caminho)) then
      ShellExecute(Handle, 'open', PChar(caminho), nil, nil, SW_SHOWNORMAL);
  end else
    begin
      if application.messagebox(
        pchar('Parece que seu Grand Chase não está na pasta '
          +Edit4.Text+'. Deseja Instala-lo?'),
            pchar(Caption),4) = IDYES then Button16.Click;
    end;
//==============================================================================
end;

procedure TForm1.Button17Click(Sender: TObject);
begin
//== Analisar e Limpar Logs e salvar logs modificados ==========================
ListBox5.Items.Clear;
ProgressBar1.Min := 0;
ProgressBar1.Max := 100;
ProgressBar1.Position := 0;

ListBox5.Items.Add('//== Logs Existentes ==// - '+TimeToStr(Time)+' - '+DateToStr(date));

AnalisarLogs('XTrap\*.xtp');      ProgressBar1.Position := 3;
AnalisarLogs('XTrap\*.txt');      ProgressBar1.Position := 6;
AnalisarLogs('XTrap\*.log');      ProgressBar1.Position := 9;
AnalisarLogs('*.zip');            ProgressBar1.Position := 12;
AnalisarLogs('*.txt');            ProgressBar1.Position := 15;
AnalisarLogs('*.log');            ProgressBar1.Position := 18;
AnalisarLogs('*.xml');            ProgressBar1.Position := 21;
AnalisarLogs('*.htm');            ProgressBar1.Position := 24;
AnalisarLogs('*.html');           ProgressBar1.Position := 27;
AnalisarLogs('crashdata.dat');    ProgressBar1.Position := 30;
AnalisarLogs('ResFeedback.dat');  ProgressBar1.Position := 30;
AnalisarLogs('mailsmtp.dll');     ProgressBar1.Position := 33;
AnalisarLogs('images.kom');       ProgressBar1.Position := 36;
AnalisarLogs('grandchasebr.ini'); ProgressBar1.Position := 39;
AnalisarLogs('mailmime.dll');     ProgressBar1.Position := 42;

ListBox5.Items.Add('//== Logs Excluidos_ ==// - '+TimeToStr(Time)+' - '+DateToStr(date));

DeletarLogs('XTrap\*.xtp');      ProgressBar1.Position := 46;
DeletarLogs('XTrap\*.txt');      ProgressBar1.Position := 50;
DeletarLogs('XTrap\*.log');      ProgressBar1.Position := 54;
DeletarLogs('*.zip');            ProgressBar1.Position := 58;
DeletarLogs('*.txt');            ProgressBar1.Position := 62;
DeletarLogs('*.log');            ProgressBar1.Position := 66;
DeletarLogs('*.xml');            ProgressBar1.Position := 70;
DeletarLogs('*.htm');            ProgressBar1.Position := 74;
DeletarLogs('*.html');           ProgressBar1.Position := 78;
DeletarLogs('crashdata.dat');    ProgressBar1.Position := 30;
DeletarLogs('ResFeedback.dat');  ProgressBar1.Position := 30;
DeletarLogs('mailsmtp.dll');     ProgressBar1.Position := 86;
DeletarLogs('images.kom');       ProgressBar1.Position := 90;
DeletarLogs('grandchasebr.ini'); ProgressBar1.Position := 94;
DeletarLogs('mailmime.dll');     ProgressBar1.Position := 100;

if CheckBox2.Checked=True then Button15.Click;

ListBox5.Items.SaveToFile(ExtractFileDir(ParamStr(0))+'\Logs.txt');
//==============================================================================
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
//== Mostrar Relógio ===========================================================
Form3.Show;
Button1.Enabled:=False;
Button2.Enabled:=True;

//==============================================================================
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
//== Esconder Relógio ==========================================================
Form3.Hide;
Button1.Enabled:=True;
Button2.Enabled:=False;
//==============================================================================
end;

procedure TForm1.Button3Click(Sender: TObject);
var altar:integer;
begin
//== Altar da Ruína +1 =========================================================
  altar:=StrToInt(qtdaltar.Text);
  altar:=altar+1;
  qtdaltar.Text:=IntToStr(altar);
  if altar=2 then Button3.Enabled:=false;
//==============================================================================
end;

procedure TForm1.Button4Click(Sender: TObject);
var forn:integer;
begin
//== Fornalha Infernal +1 ======================================================
  forn:=StrToInt(qtdfor.Text);
  forn:=forn+1;
  qtdfor.Text:=IntToStr(forn);
  if forn=2 then Button4.Enabled:=false;
//==============================================================================
end;

procedure TForm1.Button5Click(Sender: TObject);
var torre:integer;
begin
//== Torre das Ilusões +1 ======================================================
  torre:=StrToInt(qtdtorre.Text);
  torre:=torre+1;
  qtdtorre.Text:=IntToStr(torre);
  if torre=3 then Button5.Enabled:=false;
//==============================================================================
end;

procedure TForm1.Button6Click(Sender: TObject);
var berkas:integer;
begin
//== Covil de Berkas +1 ========================================================
  berkas:=StrToInt(qtdberkas.Text);
  berkas:=berkas+1;
  qtdberkas.Text:=IntToStr(berkas);
  if berkas=1 then Button6.Enabled:=false;
//==============================================================================
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
//== Resetar Contagem dos Desafios =============================================
qtdaltar.Text:='0';
qtdfor.Text:='0';
qtdtorre.Text:='0';
qtdberkas.Text:='0';
Button3.Enabled:=true;
Button4.Enabled:=true;
Button5.Enabled:=true;
Button6.Enabled:=true;
//==============================================================================
end;


procedure TForm1.Button8Click(Sender: TObject);
begin
mouse:=1;
//== Mostrar Forms pra Editar a Posição ========================================
form2.Show;
form3.Show;
CheckBox1.Checked:=false;
button8.Enabled:=false;
button9.Enabled:=true;
button10.Enabled:=true;
button11.Enabled:=true;
//==============================================================================
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
mouse:=0;
//== Salvar Posição dos Forms ==================================================
  Form1.SalvarForm1(Form1,form1.Name);
  Form2.SalvarForm2(Form2,form2.Name);
  Form3.SalvarForm3(Form3,form3.Name);
  form2.Hide;
  Form3.Hide;
  Button1.Enabled:=True;
  Button2.Enabled:=False;
  button8.Enabled:=true;
  button9.Enabled:=false;
  button10.Enabled:=false;
  button11.Enabled:=False;
  CheckBox1.Checked:=True;
//==============================================================================
end;


procedure TForm1.FecharTudo1Click(Sender: TObject);
//== PupUp Menu Fechar =========================================================
begin
Application.Terminate;
end;
//==============================================================================

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  DifTime,DirGC: TIniFile;
begin
//== Fechar Form ===============================================================
TrayIcon1.Visible:=False;
Form1.SalvarForm1(Form1,form1.Name);
//== Salvar Horario de Diferença ===============================================
  DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
  DifTime.WriteString('Time','Dif',MaskEdit1.Text);
  DifTime.Free;

//== Salvar CheckBox dos PopsUps ===============================================
  DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
  if CheckBox1.Checked=True then DifTime.WriteString('Time','PopUp','yeh');
  if CheckBox1.Checked=False then DifTime.WriteString('Time','PopUp','nop');
  DifTime.Free;

//== Salvar CheckBox De abrir ou não o GC após os Logs =========================
  DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
  if CheckBox2.Checked=True then DifTime.WriteString('Grand Chase','Logs','yeh');
  if CheckBox2.Checked=False then DifTime.WriteString('Grand Chase','Logs','nop');
  DifTime.Free;

//== Salvar CheckBox dos Sons ==================================================
  DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
  if CheckBox3.Checked=True then DifTime.WriteString('Time','Sound','yeh');
  if CheckBox3.Checked=False then DifTime.WriteString('Time','Sound','nop');
  DifTime.Free;

//== Salvar Sinal da Hora ======================================================
if RadioButton1.Checked then
  begin
    DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    DifTime.WriteString('Time','sinal','-');
    DifTime.Free;
  end else
if RadioButton2.Checked then
  begin
    DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    DifTime.WriteString('Time','sinal','+');
    DifTime.Free;
  end;

//== Salvar Diretório do Grand Chase ===========================================
  DirGC := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
  DirGC.WriteString('Grand Chase','Dir',Edit4.Text);
  DirGC.Free;


//== Terminar Aplicação ========================================================
  Application.Terminate;
//==============================================================================
end;

procedure TForm1.FormCreate(Sender: TObject);
//== Criando o Form ============================================================
var
  DifTime, DirGCini, Picture: TIniFile;
  IniImgPath, IniImgName, SinalTime, DirGCinis, chkbox, IniImgExt : String;
begin
mouse:=0;
//== Carregar Horario de Diferença =============================================
if not FileExists(ExtractFileDir(ParamStr(0))+'\config.ini') then
  begin
    DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    DifTime.WriteString('Time','Dif','00:00:00');
    DifTime.Free;
  end;
  DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
  MaskEdit1.Text := DifTime.ReadString('Time','Dif','');

//== Inicialização dos Forms ===================================================
  Form1.AbrirForm1(Form1,Form1.Name);
  Application.OnMinimize := Minimizando;
  Label22.Caption:='['+VersaoExe+' ]';
  Label23.Caption:='[ '+ExtractFileDir(ParamStr(0))+'\ ]';

//== Carregar Imagem do Bottom =================================================
if FileExists(ExtractFileDir(ParamStr(0))+'\config.ini') then
  begin
    Picture := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    IniImgName:= Picture.ReadString('Picture','Name','Default.png');
    IniImgPath:= ExtractFilePath(ParamStr(0))+'Images\';
    IniImgExt := ExtractFileExt(IniImgName);
If (fileexists(IniImgPath+IniImgName))
    then
      begin
        Image1.Picture.LoadFromFile(IniImgPath+IniImgName);
        //== Animando o GIF ====================================================
          if IniImgExt='.gif' then
            TGIFImage(Image1.Picture.Graphic).Animate :=True;
      end;
  end;
//== Carregar Sinal da Hora ====================================================
if FileExists(ExtractFileDir(ParamStr(0))+'\config.ini') then
  begin
    DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    SinalTime := DifTime.readString('Time','sinal','');
      if SinalTime = '-' then RadioButton1.Checked:=True;
      if SinalTime = '+' then RadioButton2.Checked:=True;
    DifTime.Free;
  end;

//== Carregar Diretório do Grand Chase =========================================
if FileExists(ExtractFileDir(ParamStr(0))+'\config.ini') then
  begin
    DirGCini := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    DirGCinis := DirGCini.readString('Grand Chase','Dir','C:\Level Up Games\Grand Chase');
    Edit4.Text := DirGCinis;
    Label24.Caption := '[ '+DirGCinis+'\ ]';
    DirGCini.Free;
  end;

//== Carregar CheckBox De PopUps ===============================================
if FileExists(ExtractFileDir(ParamStr(0))+'\config.ini') then
  begin
    DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    chkbox := DifTime.readString('Time','PopUp','');
      if chkbox = 'yeh' then CheckBox1.Checked:=True;
      if chkbox = 'nop' then CheckBox1.Checked:=False;
    DifTime.Free;
  end;


//== Carregar CheckBox De abrir ou não o GC após os Logs =======================
if FileExists(ExtractFileDir(ParamStr(0))+'\config.ini') then
  begin
    DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    chkbox := DifTime.readString('Grand Chase','Logs','');
      if chkbox = 'yeh' then CheckBox2.Checked:=True;
      if chkbox = 'nop' then CheckBox2.Checked:=False;
    DifTime.Free;
  end;

//== Carregar CheckBox De Soms =================================================
if FileExists(ExtractFileDir(ParamStr(0))+'\config.ini') then
  begin
    DifTime := TIniFile.Create(ExtractFileDir(ParamStr(0))+'\config.ini');
    chkbox := DifTime.readString('Time','Sound','');
      if chkbox = 'yeh' then CheckBox3.Checked:=True;
      if chkbox = 'nop' then CheckBox3.Checked:=False;
    DifTime.Free;
  end;
//==============================================================================
end;


procedure TForm1.Timer1Timer(Sender: TObject);
var verbugtime1,verbugtime2,verbugtime3,verbugtimeFinn : TDateTime;
begin
//=========== Hora =============================================================
//== Se - estiver selecionado ==================================================
   if RadioButton1.Checked = true then
    begin
      timepc := Time;
      timedif := StrToTime(MaskEdit1.Text);
      if timedif > StrToTime('23:59:59') then
        begin
          MaskEdit1.Text := '23:59:59';
          timedif := StrToTime(MaskEdit1.Text);
        end;
      //hora := TimeToStr(timepc-timedif);
      //Label1.caption := hora;
      //Form3.Label1.Caption := hora;
        //== Correção do Bug da Meia Noite =====================================
          verbugtime1 := timepc-timedif; {Tempo 'Negativo'}
          verbugtime2 := StrToTime('23:59:59');
          verbugtime3 := StrToTime('00:00:01');
          verbugtimeFinn := (verbugtime2+verbugtime1)+verbugtime3;
                           {('23:59:59'+[-]Tempo 'Negativo')+1 segundo}
          hora := TimeToStr(verbugtimeFinn);
          Label1.Caption := TimeToStr(verbugtimeFinn);
          Form3.Label1.Caption := TimeToStr(verbugtimeFinn);

    end else
//== Se + estiver selecionado ==================================================
      if RadioButton2.Checked = true then
         begin
            timepc := Time;
            timedif := StrToTime(MaskEdit1.Text);
            hora := TimeToStr(timepc+timedif);
            Label1.caption := hora;
            Form3.Label1.Caption := hora;
         end;




//== Resetar Contagem dos Desafios a Meia Noite ================================
if hora = '00:00:00' then
  begin
    qtdaltar.Text:='0';
    qtdfor.Text:='0';
    qtdtorre.Text:='0';
    qtdberkas.Text:='0';
    Button3.Enabled:=true;
    Button4.Enabled:=true;
    Button5.Enabled:=true;
    Button6.Enabled:=true;
  end;

//== Despertador ===============================================================
if form1.CheckBox1.Checked=true then
  begin
    if StrToInt(qtdaltar.Text) < 2 then DespertadorAltar;
    if StrToInt(qtdfor.Text) < 2 then DespertadorFornalha;
    if StrToInt(qtdtorre.Text) < 3 then DespertadorTorre;
    if StrToInt(qtdberkas.Text) < 1 then DespertadorBerkas;
  end;

//==============================================================================
end;
procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
ShowWindow(Form1.Handle,SW_RESTORE);
Form1.BringToFront;
Form1.SetFocus;
end;

//==============================================================================
procedure TForm1.Button16Click(Sender: TObject);
var path,destino : string;
begin
//== Verificar Arquivos e perguntar se irá instalar ============================
if not (fileExists(Edit4.Text+'\grandchase.exe')) then
  if application.messagebox(pchar('Deseja instalar o Grand Chase na pasta '
    +Edit4.Text+'\ ?'),pchar(Caption),4) = IDYES then
    begin
      //== Copiar GrandChase.exe ===============================================
      if FileExists(ExtractFileDir(ParamStr(0))+'\Files\grandchase.exe') then
      begin
        path := ExtractFileDir(ParamStr(0))+'\Files\grandchase.exe';
        destino := Edit4.Text+'\grandchase.exe';
        if not CopyFile(PChar(path), PChar(destino), false) then
          ShowMessage('Erro ao copiar arquivos para ' + destino);
      end;
      //== Copiar DSETUP.DLL ===================================================
      if FileExists(ExtractFileDir(ParamStr(0))+'\Files\DSETUP.DLL') then
      begin
        path := ExtractFileDir(ParamStr(0))+'\Files\DSETUP.DLL';
        destino := Edit4.Text+'\DSETUP.DLL';
        if not CopyFile(PChar(path), PChar(destino), false) then
          ShowMessage('Erro ao copiar arquivos para ' + destino);
      end;
      //== Executar exe ==//
      if FileExists(destino+'\Files\DSETUP.DLL')and
        FileExists(destino+'\Files\grandchase.exe') then
      begin
        ShowMessage('[Instalador Por: EXPL01T3R]');
        Button15.Click;
      end;
    end;


end;

end.
