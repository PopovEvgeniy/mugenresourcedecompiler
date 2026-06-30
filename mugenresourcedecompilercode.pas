unit mugenresourcedecompilercode;

{
 This software was made by Popov Evgeniy Alekseyevich.
 It is distributed under the GNU GENERAL PUBLIC LICENSE (Version 2 or higher).
}

{$mode objfpc}
{$H+}

interface

uses Classes, SysUtils,Forms, Controls, Dialogs, ExtCtrls, StdCtrls;

type

  { TMainWindow }

  TMainWindow = class(TForm)
    OpenButton: TButton;
    ExtractButton: TButton;
    FileField: TLabeledEdit;
    OpenDialog: TOpenDialog;
    procedure OpenButtonClick(Sender: TObject);
    procedure ExtractButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileFieldChange(Sender: TObject);
  private
    procedure window_setup();
    procedure interface_setup();
    procedure language_setup();
    procedure dialog_setup();
    procedure setup();
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
var message:array[0..7] of string=('The operation was successfully completed','Cannot open the input file','Cannot create the output file','Cannot read data','Cannot write data','Cannot jump to the target offset','Cannot allocate memory','The invalid format');
begin
 status:='Cannot execute an external program';
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

procedure TMainWindow.window_setup();
begin
 Application.Title:='MUGEN RESOURCE DECOMPILER';
 Self.Caption:='MUGEN RESOURCE DECOMPILER 2.0.6';
 Self.Font.Name:=Screen.MenuFont.Name;
 Self.Font.Size:=14;
 Self.BorderStyle:=bsDialog;
end;

procedure TMainWindow.interface_setup();
begin
 Self.OpenButton.ShowHint:=False;
 Self.ExtractButton.ShowHint:=False;
 Self.FileField.LabelPosition:=lpLeft;
 Self.FileField.Enabled:=False;
 Self.FileField.Text:='';
end;

procedure TMainWindow.language_setup();
begin
 Self.OpenButton.Caption:='Open';
 Self.ExtractButton.Caption:='Extract';
 Self.FileField.EditLabel.Caption:='File';
  Self.OpenDialog.Title:='Open a resource container';
end;

procedure TMainWindow.dialog_setup();
begin
 Self.OpenDialog.Filter:='All suported files|*.sff; *.snd';
 Self.OpenDialog.FileName:='*.sff; *.snd';
 Self.OpenDialog.DefaultExt:='*.sff';
end;

procedure TMainWindow.setup();
begin
 Self.window_setup();
 Self.interface_setup();
 Self.language_setup();
 Self.dialog_setup();
end;

{ TMainWindow }

procedure TMainWindow.FormCreate(Sender: TObject);
begin
 Self.setup();
end;

procedure TMainWindow.FileFieldChange(Sender: TObject);
begin
 Self.ExtractButton.Enabled:=Self.FileField.Text<>'';
end;

procedure TMainWindow.OpenButtonClick(Sender: TObject);
begin
 if Self.OpenDialog.Execute()=True then Self.FileField.Text:=Self.OpenDialog.FileName;
end;

procedure TMainWindow.ExtractButtonClick(Sender: TObject);
begin
 extract_resource(Self.FileField.Text);
end;

{$R *.lfm}

end.
