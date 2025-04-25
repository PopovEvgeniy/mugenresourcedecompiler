unit mugenresourcedecompilercode;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,Forms, Controls, Dialogs,
  ExtCtrls, StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    OpenButton: TButton;
    ExtractButton: TButton;
    TargetPanel: TLabel;
    FileField: TLabeledEdit;
    OpenDialog: TOpenDialog;
    GraphicRadioButton: TRadioButton;
    SoundRadioButton: TRadioButton;
    procedure OpenButtonClick(Sender: TObject);
    procedure ExtractButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileFieldChange(Sender: TObject);
    procedure GraphicRadioButtonClick(Sender: TObject);
    procedure SoundRadioButtonClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

  var MainWindow: TMainWindow;

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
var message:array[0..5] of string=('The operation was successfully completed','Cant open the input file','Cant create the output file','Cant jump to the target offset','Cant allocate memory','Invalid format');
begin
 status:='Can not execute an external program';
 host:=ExtractFilePath(Application.ExeName)+'sffdecompiler.exe';
 if ExtractFileExt(target)='.snd' then
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
 MainWindow.Caption:='MUGEN RESOURCE DECOMPILER 2.0';
 MainWindow.Font.Name:=Screen.MenuFont.Name;
 MainWindow.Font.Size:=14;
 MainWindow.BorderStyle:=bsDialog;
end;

procedure interface_setup();
begin
 MainWindow.OpenButton.ShowHint:=False;
 MainWindow.ExtractButton.ShowHint:=MainWindow.OpenButton.ShowHint;
 MainWindow.FileField.LabelPosition:=lpLeft;
 MainWindow.FileField.Enabled:=False;
 MainWindow.GraphicRadioButton.Checked:=True;
 MainWindow.FileField.Text:='';
end;

procedure language_setup();
begin
 MainWindow.OpenButton.Caption:='Open';
 MainWindow.ExtractButton.Caption:='Extract';
 MainWindow.TargetPanel.Caption:='Target:';
 MainWindow.FileField.EditLabel.Caption:='File';
 MainWindow.GraphicRadioButton.Caption:='Graphics';
 MainWindow.SoundRadioButton.Caption:='Sound';
end;

procedure set_graphic_target();
begin
 MainWindow.OpenDialog.Title:='Open a graphics container';
 MainWindow.OpenDialog.Filter:='Mugen graphics container|*.sff';
 MainWindow.OpenDialog.FileName:='*.sff';
 MainWindow.OpenDialog.DefaultExt:='*.sff';
end;

procedure set_sound_target();
begin
 MainWindow.OpenDialog.Title:='Open a sound container';
 MainWindow.OpenDialog.Filter:='Mugen sound container|*.snd';
 MainWindow.OpenDialog.FileName:='*.snd';
 MainWindow.OpenDialog.DefaultExt:='*.snd';
end;

procedure setup();
begin
 window_setup();
 interface_setup();
 language_setup();
 set_graphic_target();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 setup();
end;

procedure TMainWindow.FileFieldChange(Sender: TObject);
begin
 MainWindow.ExtractButton.Enabled:=MainWindow.FileField.Text<>'';
end;

procedure TMainWindow.OpenButtonClick(Sender: TObject);
begin
 if MainWindow.OpenDialog.Execute()=True then MainWindow.FileField.Text:=MainWindow.OpenDialog.FileName;
end;

procedure TMainWindow.ExtractButtonClick(Sender: TObject);
begin
 extract_resource(MainWindow.FileField.Text);
end;

procedure TMainWindow.GraphicRadioButtonClick(Sender: TObject);
begin
 set_graphic_target();
end;

procedure TMainWindow.SoundRadioButtonClick(Sender: TObject);
begin
 set_sound_target();
end;

{$R *.lfm}

end.
