; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppId={{74939DD5-910E-4FEA-AF81-487E30ED451B}
AppName=Geonkick
AppVersion=3.0.0
AppPublisher=Iurie Nistor
AppPublisherURL=https://geonkick.org
AppSupportURL=https://geonkick.org
AppUpdatesURL=https://geonkick.org
DefaultDirName={pf64}\Geonkick
DefaultGroupName=Geonkick
AllowNoIcons=yes
LicenseFile=D:\a\geonkick\geonkick\LICENSE
PrivilegesRequired=lowest
Compression=lzma
SolidCompression=yes
WizardStyle=modern
DisableDirPage=yes


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Types]
Name: "custom"; Description: "Custom Installation"; Flags: iscustom

[Files]
Source: "D:\a\geonkick\build\plugins\plugins\geonkick.lv2\*"; DestDir: "{code:GetLV2Path}\geonkick.lv2"; Flags: ignoreversion recursesubdirs createallsubdirs;
Source: "D:\a\geonkick\build\plugins\Geonkick.vst3\*"; DestDir: "{code:GetVST3Path}\Geonkick.vst3"; Flags: ignoreversion recursesubdirs createallsubdirs;


[Code]
var
  PluginFormatPage: TWizardPage;
  PluginFormatCheckListBox: TNewCheckListBox;
  LV2PathEdit: TEdit;
  VST3PathEdit: TEdit;
  LV2BrowseButton: TNewButton;
  VST3BrowseButton: TNewButton;
  LV2Path: String;
  VST3Path: String;

procedure BrowseButtonOnClickPath(Sender: TObject);
var
  ChosenPath: string;
  EditControl: TEdit;
begin
  EditControl := TEdit((Sender as TNewButton).Tag);
  ChosenPath := '';
  if BrowseForFolder('Choose a folder for the plugin format', ChosenPath, False) then
    EditControl.Text := ChosenPath
  else
    EditControl.Text := '';
end;

procedure FormatCheckBoxClick(Sender: TObject);
begin
  if PluginFormatCheckListBox.Checked[0] or PluginFormatCheckListBox.Checked[1] then
  begin
    LV2PathEdit.Enabled := True;
    LV2BrowseButton.Enabled := True;
  end
  else
  begin
    LV2PathEdit.Enabled := False;
    LV2BrowseButton.Enabled := False;
  end;

  if PluginFormatCheckListBox.Checked[2] then
  begin
    VST3PathEdit.Enabled := True;
    VST3BrowseButton.Enabled := True;
  end
  else
  begin
    VST3PathEdit.Enabled := False;
    VST3BrowseButton.Enabled := False;
  end;
end;


procedure InitializeWizard;
begin

  PluginFormatPage := CreateCustomPage(wpSelectDir, 'Select Plugin Formats', 'Choose which plugin formats & version to install:');
  PluginFormatCheckListBox := TNewCheckListBox.Create(WizardForm);
  PluginFormatCheckListBox.Parent := PluginFormatPage.Surface;
  PluginFormatCheckListBox.Left := 18;
  PluginFormatCheckListBox.Top := 0;
  PluginFormatCheckListBox.Width := PluginFormatPage.SurfaceWidth;
  PluginFormatCheckListBox.Height := PluginFormatPage.SurfaceHeight - 120;
  PluginFormatCheckListBox.AddCheckBox('Geonkick Plugin LV2', '', 0, True, True, False, False, nil);
  PluginFormatCheckListBox.AddCheckBox('Geonkick Plugin VST3', '', 0, True, True, False, False, nil);
  PluginFormatCheckListBox.OnClickCheck := @FormatCheckBoxClick;

  LV2PathEdit := TEdit.Create(WizardForm);
  LV2PathEdit.Parent := PluginFormatPage.Surface;
  LV2PathEdit.Left := 18;
  LV2PathEdit.Top := PluginFormatCheckListBox.Top + PluginFormatCheckListBox.Height + 16;
  LV2PathEdit.Width := PluginFormatPage.SurfaceWidth - 82;
  LV2PathEdit.Text := ExpandConstant('{pf64}\Common Files\LV2');
  LV2PathEdit.Name := 'LV2PathEdit';
  LV2PathEdit.Enabled := True;

  LV2BrowseButton := TNewButton.Create(WizardForm);
  LV2BrowseButton.Parent := PluginFormatPage.Surface;
  LV2BrowseButton.Left := LV2PathEdit.Left + LV2PathEdit.Width + 6;
  LV2BrowseButton.Top := LV2PathEdit.Top;
  LV2BrowseButton.Width := 80;
  LV2BrowseButton.Caption := 'Browse...';
  LV2BrowseButton.OnClick := @BrowseButtonOnClickPath;
  LV2BrowseButton.Tag := Integer(LV2PathEdit);

  VST3PathEdit := TEdit.Create(WizardForm);
  VST3PathEdit.Parent := PluginFormatPage.Surface;
  VST3PathEdit.Left := 18;
  VST3PathEdit.Top := LV2PathEdit.Top + LV2PathEdit.Height + 16;
  VST3PathEdit.Width := PluginFormatPage.SurfaceWidth - 82;
  VST3PathEdit.Text := ExpandConstant('{pf64}\Common Files\VST3');
  VST3PathEdit.Name := 'VST3PathEdit';
  VST3PathEdit.Enabled := True;

  VST3BrowseButton := TNewButton.Create(WizardForm);
  VST3BrowseButton.Parent := PluginFormatPage.Surface;
  VST3BrowseButton.Left := VST3PathEdit.Left + VST3PathEdit.Width + 6;
  VST3BrowseButton.Top := VST3PathEdit.Top;
  VST3BrowseButton.Width := 80;
  VST3BrowseButton.Caption := 'Browse...';
  VST3BrowseButton.OnClick := @BrowseButtonOnClickPath;
  VST3BrowseButton.Tag := Integer(VST3PathEdit);
end;

function GetLV2Path(Param: String): String;
begin
  Result := LV2Path;
end;

function GetVST3Path(Param: String): String;
begin
  Result := VST3Path;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;

  if CurPageID = PluginFormatPage.ID then
  begin
    LV2Path := LV2PathEdit.Text;
    VST3Path := VST3PathEdit.Text;
  end;
 end;
