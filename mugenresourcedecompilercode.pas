unit mugenresourcedecompilercode;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Forms, Controls, Dialogs,
  ExtCtrls, StdCtrls, LazFileUtils;

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

  var Form1: TForm1;

implementation

function convert_file_name(const source:string): string;
var target:string;
begin
 target:=source;
 if Pos(' ',source)>0 then
 begin
  target:='"'+source+'"';
 end;
 convert_file_name:=target;
end;

function execute_program(const executable:string;const argument:string):Integer;
var code:Integer;
begin
 try
  code:=ExecuteProcess(executable,argument,[]);
 except
  code:=-1;
 end;
 execute_program:=code;
end;

procedure extract_resource(const target:string);
var host,status:string;
var index:Integer;
var message:array[0..5] of string=('Operation was successfully completed','Cant open the input file','Cant create the output file','Cant jump to the target offset','Cant allocate memory','Invalid format');
begin
 status:='Can not execute an external program';
 host:=ExtractFilePath(Application.ExeName)+'sffdecompiler.exe';
 if Form1.RadioButton2.Checked=True then
 begin
  host:=ExtractFilePath(Application.ExeName)+'sndextract.exe';
 end;
 index:=execute_program(host,convert_file_name(target));
 if index>0 then
 begin
  status:=message[index];
 end;
 ShowMessage(status);
end;

procedure window_setup();
begin
 Application.Title:='MUGEN RESOURCE DECOMPILER';
 Form1.Caption:='MUGEN RESOURCE DECOMPILER 1.9.7';
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
 Form1.LabeledEdit1.Text:='';
end;

procedure language_setup();
begin
 Form1.Button1.Caption:='Open';
 Form1.Button2.Caption:='Extract';
 Form1.Label1.Caption:='Target:';
 Form1.LabeledEdit1.EditLabel.Caption:='File';
 Form1.RadioButton1.Caption:='Graphics';
 Form1.RadioButton2.Caption:='Sound';
end;

procedure set_graphic_target();
begin
 Form1.OpenDialog1.Title:='Open a graphics container';
 Form1.OpenDialog1.Filter:='Mugen graphics container|*.sff';
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
 language_setup();
 set_graphic_target();
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TForm1.LabeledEdit1Change(Sender: TObject);
begin
 Form1.Button2.Enabled:=Form1.LabeledEdit1.Text<>'';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 if Form1.OpenDialog1.Execute()=True then Form1.LabeledEdit1.Text:=Form1.OpenDialog1.FileName;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 extract_resource(Form1.LabeledEdit1.Text);
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
