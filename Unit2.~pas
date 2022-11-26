unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Timer1: TTimer;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Label8Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  pic: HDC;
  l, t, w, h, pw, ph: Integer;

implementation

uses Unit3;

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
begin
Randomize;
end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
l := Random(2);
t := Random(2);

if Random(2) = 0
then l := 0 - l;
if Random(2) = 0
then t := 0 - t;

Label1.Left := Label1.Left + l;
Label1.Top := Label1.Top + t;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TForm2.Label1Click(Sender: TObject);
begin
Timer1.Enabled := not Timer1.Enabled;
end;

procedure TForm2.Label7Click(Sender: TObject);
begin
ShowMessage('nobootrecord.github.io');
end;

procedure TForm2.Label8Click(Sender: TObject);
begin
ShowMessage('vk.com/id557789540');
end;

procedure TForm2.Label9Click(Sender: TObject);
begin
ShowMessage('clck.ru/TC8aH');
end;

procedure TForm2.Label10Click(Sender: TObject);
begin
Form3.Show;
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
Form3.Show;
end;

end.
