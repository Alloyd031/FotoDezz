unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, XPMan, ExtDlgs, JPEG;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Button1: TButton;
    XPManifest1: TXPManifest;
    Image1: TImage;
    RadioGroup1: TRadioGroup;
    Button3: TButton;
    Button4: TButton;
    RadioGroup2: TRadioGroup;
    FadeIn: TTimer;
    FadeOut: TTimer;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Label2: TLabel;
    RadioGroup3: TRadioGroup;
    FontDialog1: TFontDialog;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FadeInTimer(Sender: TObject);
    procedure FadeOutTimer(Sender: TObject);
    procedure Label2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioGroup3Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  pic: HDC;
  pcnvs: TCanvas;
  pw, ph, l, t: Integer;
  noFileLoadedErr, noEffChoseErr, demMsgT, demMsgB, demMsgTS, mMsgT, errMsg: string;
  jpgpic: TJPEGImage;
  bmppic: TBitmap;

implementation

{$R *.dfm}

uses Unit2, Unit3;

{ Дальше будут процедуры для тех или иных вещей.
  Позже я буду их объявлять. }

procedure GetDesktop;
begin
pw := Form1.Image1.Picture.Width;
ph := Form1.Image1.Picture.Height;
pcnvs := Form1.Image1.Canvas;
pic := pcnvs.Handle;
l := Random(pw);
t := Random(ph);
end;
procedure DrawWatermark;  { Водяной знак }
begin
GetDesktop;
pcnvs.Brush.Color := $FFFFFF;
pcnvs.Font.Color := $000000;
pcnvs.Font.Name := 'System';
pcnvs.Font.Size := 8;
pcnvs.TextOut(0, ph - 16, 'FotoDezz made by NobootRecord (vk.com/NobootRecord)');
end;

procedure Sickness;  { Жмых }
begin
pic := Form1.Image1.Canvas.Handle;
GetDesktop;
StretchBlt(pic, 1, t, pw+2, t, pic, 0, t, pw, t, SRCCOPY);
StretchBlt(pic, l, 1, l, ph+2, pic, l, 0, l, ph, SRCCOPY);
StretchBlt(pic, 0, t, pw, t, pic, 1, t, pw+2, t, SRCCOPY);
StretchBlt(pic, l, 0, l, ph, pic, l, 1, l, ph+2, SRCCOPY);
end;

procedure Otval; { ОТВАЛ видеокарты :) }
begin
GetDesktop;
StretchBlt(pic, 0, 0, pw, ph, pic, l, t, 1, 1, SRCINVERT);
end;

procedure Inversia; { Инверсия, как в MEMZ Trojan }
begin
GetDesktop;
BitBlt(pic, 0, 0, pw, ph, pic, 0, 0, NOTSRCCOPY);
end;

procedure Demotivator; { Мем-демотиватор (криво работает) }
var
ttxt, btxt: string;
txtsyz: Integer;
begin
ttxt := InputBox('FotoDezz', demMsgT, 'TOP TEXT');
btxt := InputBox('FotoDezz', demMsgB, 'BOTTOM TEXT');
txtsyz := StrToInt(InputBox('FotoDezz', demMsgTS, '24'));

GetDesktop;

pcnvs.Brush.Color := $000000;
pcnvs.Font.Color := $FFFFFF;
pcnvs.Font.Name := 'Impact';
pcnvs.Font.Size := txtsyz;
pcnvs.TextOut(pw div 2 - (pw div 8), 0, ttxt);
pcnvs.TextOut(pw div 2 - (pw div 8), ph - (ph div 16), btxt);
end;

procedure NewMeme; { Мем с красивой подписью }
var
mtxt: string;
begin
mtxt := InputBox('FotoDezz', mMsgT, 'Sample Text');
if Form1.FontDialog1.Execute then begin

GetDesktop;

pcnvs.Font := Form1.FontDialog1.Font;;
pcnvs.TextOut(Round(Form1.FontDialog1.Font.Size * 2), ph - (Form1.FontDialog1.Font.Size * 3), mtxt);
pcnvs.Brush.Color := not Form1.FontDialog1.Font.Color;
DrawWatermark;
end;
end;

procedure ShirokyPutin; { Широкий Путин }
begin
GetDesktop;
StretchBlt(pic, -20, 0, pw+40, ph, pic, 0, 0, pw, ph, SRCCOPY);
DrawWatermark;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
{ Открываем фотку.
  Если что-то пошло не так,
  вызываем пояснительную бригаду }

if OpenDialog1.Execute
then begin
try
bmppic := TBitmap.Create;
jpgpic := TJPEGImage.Create;

jpgpic.LoadFromFile(OpenDialog1.FileName);
bmppic.Assign(jpgpic);
Image1.Picture.Assign(bmppic);

pic := Image1.Canvas.Handle;
pw := Image1.Picture.Width;
ph := Image1.Picture.Height;

Edit1.Text := OpenDialog1.FileName;

jpgpic.Free;
bmppic.Free;

Image1.Center := (Image1.Picture.Width < Image1.Width) or (Image1.Picture.Height < Image1.Height);
Image1.Stretch := (Image1.Picture.Width > Image1.Width) or (Image1.Picture.Height > Image1.Height);
except on E: Exception do MessageBoxA(Form1.Handle, PChar(errMsg), '>_<', MB_ICONERROR);
end;
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
i: Integer;
begin
{ Если надо, выдаём сообщения.
  Если всё в порядке, "уничтожаем" картинку
  с помощью наших процедур }

if Edit1.Text = ''
then MessageBoxA(Form1.Handle, PChar(noFileLoadedErr), 'FotoDezz', MB_ICONERROR)
else begin
if RadioGroup1.ItemIndex = -1
then MessageBoxA(Form1.Handle, PChar(noEffChoseErr), 'FotoDezz', MB_ICONWARNING)
else begin

if RadioGroup1.ItemIndex = 0
then begin
for i := 1 to Random(1000)
do Sickness;
end;

if RadioGroup1.ItemIndex = 1
then Inversia;

if RadioGroup1.ItemIndex = 2
then Otval;

if RadioGroup1.ItemIndex = 3
then Demotivator;

if RadioGroup1.ItemIndex = 4
then begin
for i := 1 to Random(10)
do ShirokyPutin;
end;

if RadioGroup1.ItemIndex = 5
then NewMeme;

DrawWatermark; { Рисуем ватермарк }

{ Сохраняем наш мировой шедевр искусства }
if SaveDialog1.Execute
then begin
Image1.Picture.SaveToFile(SaveDialog1.FileName);
Edit1.Text := SaveDialog1.FileName;
Image1.Refresh;
end;
end;
end;
end;

procedure SetEnglish; { Английская локализация }
begin
Form1.Label1.Caption := 'Picture:';
Form1.Button1.Caption := 'Import';
Form1.RadioGroup1.Caption := 'Destruction:';
Form1.RadioGroup1.Items.CommaText := 'Sickness'+#13+'Inverse'+#13+'Glitch'+#13+'Demotivator'+#13+'WidePutin'+#13+'BottomTextMeme';
Form1.RadioGroup2.Caption := 'Language:';
Form1.Button3.Caption := 'Destroy it!';
Form1.Button4.Caption := 'About';
Form1.RadioGroup3.Caption := 'Theme:';
Form1.RadioGroup3.Items.CommaText := 'Dark'+#13+'Light';
noFileLoadedErr := 'You did not load any picture!';
noEffChoseErr := 'You did not choice any effect!';
demMsgT := 'Please enter a top text of your demotivator:';
demMsgB := 'Please enter a bottom text of your demotivator:';
demMsgTS := 'Please enter a integer value of text size:';
errMsg := 'Sorry, but something gone wrong...'+#13+'Please try again later.'+#13+'If nothing helps, contact to developer (my contacts are in "About" window)';
Form2.Caption := 'About FotoDezz';
mMsgT := 'Please enter a text for meme:';
Form2.Label3.Caption := 'Author:'+#13+'Coded in:'+#13+'Version:'+#13+'Build Date:';
Form2.Label2.Caption := 'Ivan Movchan (NobootRecord)'+#13+'Borland Delphi 7.0'+#13+'1.5'+#13+'April 13, 2021';
Form2.Label4.Caption := 'Made';
Form2.Label5.Caption := 'in';
Form2.Label6.Caption := 'Russia';
Form2.Label7.Caption := 'Website';
Form2.Label8.Caption := 'VKontakte';
Form2.Label9.Caption := 'YouTube';
Form2.Label10.Caption := 'About modification';
Form3.Caption := 'About modification';
Form3.Label1.Caption := 'Creator: Alloyd Robloxian';
Form3.Label2.Caption := 'Please subscribe to my channel!';
Form1.Image3.Hint := 'Close';
Form1.Image4.Hint := 'Minimize';
end;

procedure SetRussian; { Русская локализация }
begin
Form1.Label1.Caption := 'Картинка:';
Form1.Button1.Caption := 'Импорт';
Form1.RadioGroup1.Caption := 'Извращения:';
Form1.RadioGroup1.Items.CommaText := 'Жмых'+#13+'Инверсия'+#13+'Наркомания'+#13+'Демотиватор'+#13+'ШирокийПутин'+#13+'МемСКрасивойПодписью';
Form1.RadioGroup2.Caption := 'Язык:';
Form1.Button3.Caption := 'Уничтожить!';
Form1.Button4.Caption := 'О программе';
Form1.RadioGroup3.Caption := 'Тема:';
Form1.RadioGroup3.Items.CommaText := 'Тёмная'+#13+'Светлая';
noFileLoadedErr := 'Вы ещё не загрузили картинку!';
noEffChoseErr := 'Вы не выбрали эффект для картинки.'+#13+'Не, ну так неинтересно... :(';
demMsgT := 'Введите верхний текст демотиватора:';
demMsgB := 'Введите нижний текст демотиватора:';
demMsgTS := 'Введите целое значение размера текста:';
mMsgT := 'Введите текст для мема:';
errMsg := 'Кажется, что-то пошло не так...'+#13+'Попробуйте сделать это заново чуть позже.'+#13+'Ничего не работает? Свяжитесь со мной через окно "О программе"...';
Form2.Caption := 'О FotoDezz';
Form2.Label3.Caption := 'Автор:'+#13+'Инструмент:'+#13+'Версия:'+#13+'Дата сборки:';
Form2.Label2.Caption := 'Иван Мовчан (NobootRecord)'+#13+'Borland Delphi 7.0'+#13+'1.5'+#13+'13 апреля 2021 г.';
Form2.Label4.Caption := 'Сделано';
Form2.Label5.Caption := 'в';
Form2.Label6.Caption := 'России';
Form2.Label7.Caption := 'Веб-сайт';
Form2.Label8.Caption := 'ВКонтакте';
Form2.Label9.Caption := 'Ютуб';
Form2.Label10.Caption := 'О модификации';
Form3.Caption := 'О модификации';
Form3.Label1.Caption := 'Создатель: Alloyd Robloxian';
Form3.Label2.Caption := 'Пожалуйста, подпишитесь на мой канал!';
Form1.Image3.Hint := 'Закрыть';
Form1.Image4.Hint := 'Свернуть';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Randomize;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Form2.Show;
end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin
if RadioGroup2.ItemIndex = 0
then SetEnglish;
if RadioGroup2.ItemIndex = 1
then SetRussian;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action := caNone;
Image1.Free;
FadeOut.Enabled := true;
end;

procedure TForm1.FadeInTimer(Sender: TObject);
begin
Form1.AlphaBlendValue := Form1.AlphaBlendValue + 15;

if Form1.AlphaBlendValue = 255
then begin
FadeIn.Enabled := false;
SetEnglish;
end;
end;

procedure TForm1.FadeOutTimer(Sender: TObject);
begin
Form1.AlphaBlendValue := Form1.AlphaBlendValue - 15;

if Form1.AlphaBlendValue = 0
then Halt(0);
end;

procedure TForm1.Label2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer); { Двигаем окно, держа его за "шкирку" }
begin
ReleaseCapture;
Form1.Perform(WM_SysCommand, $F012, 0);
end;

procedure TForm1.RadioGroup3Click(Sender: TObject); { Переключаем тёмную и светлую тему }
begin
if RadioGroup3.ItemIndex = 0
then Form1.Color := $000000;
if RadioGroup3.ItemIndex = 1
then Form1.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 1
then Label2.Font.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 0
then Label2.Font.Color := $000000;
if RadioGroup3.ItemIndex = 1
then Label1.Font.Color := $000000;
if RadioGroup3.ItemIndex = 0
then Label1.Font.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 0
then Form2.Color := $000000;
if RadioGroup3.ItemIndex = 1
then Form2.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 0
then Form2.Label1.Font.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 1
then Form2.Label1.Font.Color := $000000;
if RadioGroup3.ItemIndex = 0
then Form2.Label4.Font.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 1
then Form2.Label4.Font.Color := $000000;
if RadioGroup3.ItemIndex = 0
then Form2.Label7.Font.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 1
then Form2.Label7.Font.Color := $000000;
RadioGroup1.Font.Color := Form1.Color;
RadioGroup2.Font.Color := Form1.Color;
RadioGroup3.Font.Color := Form1.Color;
if RadioGroup3.ItemIndex = 1
then Edit1.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 0
then Edit1.Color := $000000;
if RadioGroup3.ItemIndex = 0
then Edit1.Font.Color := $FFFFFF;
if RadioGroup3.ItemIndex = 1
then Edit1.Font.Color := $000000;
if RadioGroup3.ItemIndex = 0
then Form3.Color := $000000;
if RadioGroup3.ItemIndex = 1
then Form3.Color := $FFFFFF;
end;

procedure TForm1.Image3Click(Sender: TObject);
begin
Close;
end;

procedure TForm1.Image4Click(Sender: TObject);
begin
Application.Minimize;
end;

end.
