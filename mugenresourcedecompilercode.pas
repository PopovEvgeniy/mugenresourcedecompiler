unit mugenresourcedecompilercode;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Dialogs,
  ExtCtrls, StdCtrls, LazUTF8;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

  function check_input(input:string):Boolean;
  function convert_file_name(source:string): string;
  function execute_program(executable:string;argument:string):Integer;
  procedure window_setup();
  procedure interface_setup();
  procedure set_graphic_target();
  procedure set_sound_target();
  procedure setup();
  procedure extract_resource(target:string);
  var Form1: TForm1;

implementation

function check_input(input:string):Boolean;
var target:Boolean;
begin
target:=True;
if input='' then
begin
target:=False;
end;
check_input:=target;
end;

function convert_file_name(source:string): string;
var target:string;
begin
target:=source;
if Pos(' ',source)>0 then
begin
target:='"';
target:=target+source+'"';
end;
convert_file_name:=target;
end;

function execute_program(executable:string;argument:string):Integer;
var code:Integer;
begin
try
code:=ExecuteProcess(UTF8ToWinCP(executable),UTF8ToWinCP(argument),[]);
except
On EOSError do code:=-1;
end;
execute_program:=code;
end;

procedure window_setup();
begin
 Application.Title:='MUGEN RESOURCE DECOMPILER';
 Form1.Caption:='MUGEN RESOURCE DECOMPILER 1.8.4';
 Form1.Font.Name:=Screen.MenuFont.Name;
 Form1.Font.Size:=14;
 Form1.BorderStyle:=bsDialog;
end;

procedure interface_setup();
begin
Form1.Button1.ShowHint:=False;
Form1.Button2.ShowHint:=Form1.Button1.ShowHint;
Form1.LabeledEdit1.LabelPosition:=lpLeft;
Form1.LabeledEdit1.Enabled:=False;
Form1.RadioButton1.Checked:=True;
Form1.Button1.Caption:='Open';
Form1.Button2.Caption:='Extract';
Form1.Label1.Caption:='Target:';
Form1.LabeledEdit1.Caption:='File';
Form1.LabeledEdit1.Text:='';
Form1.RadioButton1.Caption:='Graphic';
Form1.RadioButton2.Caption:='Sound';
end;

procedure set_graphic_target();
begin
Form1.OpenDialog1.Title:='Open a graphic container';
Form1.OpenDialog1.Filter:='Mugen graphic container|*.sff';
Form1.OpenDialog1.FileName:='*.sff';
Form1.OpenDialog1.DefaultExt:='*.sff';
end;

procedure set_sound_target();
begin
Form1.OpenDialog1.Title:='Open a sound container';
Form1.OpenDialog1.Filter:='Mugen sound container|*.snd';
Form1.OpenDialog1.FileName:='*.snd';
Form1.OpenDialog1.DefaultExt:='*.snd';
end;

procedure setup();
begin
window_setup();
interface_setup();
set_graphic_target();
end;

procedure extract_resource(target:string);
var host,argument:string;
var index:Integer;
var message:array[0..3] of string;
begin
message[0]:='Operation successfuly complete';
message[1]:='Can not allocate memory';
message[2]:='File operation error';
message[3]:='Invalid format';
host:=ExtractFilePath(Application.ExeName)+'sffdecompiler';
if Form1.RadioButton2.Checked=True then
begin
host:=ExtractFilePath(Application.ExeName)+'sndextract';
end;
argument:=convert_file_name(target);
index:=execute_program(host,argument);
if index=-1 then
begin
ShowMessage('Can not execute a external program');
end
else
begin
ShowMessage(message[index]);
end;

end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
setup();
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
if Form1.OpenDialog1.Execute()=True then
begin
Form1.LabeledEdit1.Text:=Form1.OpenDialog1.FileName;
end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
extract_resource(Form1.LabeledEdit1.Text);
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
Form1.Button2.Enabled:=check_input(Form1.LabeledEdit1.Text);
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
set_graphic_target();
end;

procedure TForm1.RadioButton2Click(Sender: TObject);
begin
set_sound_target();
end;

{$R *.lfm}

end.