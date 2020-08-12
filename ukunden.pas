unit ukunden;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, jwawinuser, BCPanel, BCListBox,
  ColorSpeedButton, db, LCLType, Types;

type
  TRecord = class(TObject)
    id : String;
    name : String;
    vorname : string;
    strasse : String;
    land,plz,ort : String;
    telefon : String;
  end;

  { TForm2 }

  TForm2 = class(TForm)
    BCListBox1: TBCListBox;
    BCPanel1: TBCPanel;
    BCPanel2: TBCPanel;
    BCPanel3: TBCPanel;
    Button2: TButton;
    ColorSpeedButton1: TColorSpeedButton;
    ColorSpeedButton2: TColorSpeedButton;
    ColorSpeedButton3: TColorSpeedButton;
    ColorSpeedButton4: TColorSpeedButton;
    ColorSpeedButton5: TColorSpeedButton;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Image1: TImage;
    Image14: TImage;
    Image2: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Notebook1: TNotebook;
    Page1: TPage;
    Page2: TPage;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    pnlKunden: TBCPanel;
    StaticText14: TStaticText;
    StaticText15: TStaticText;
    procedure BCListBox1DrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure BCListBox1SelectionChange(Sender: TObject; User: boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ColorSpeedButton1Click(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image14Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
  private
    procedure RefreshListboxItem;
    procedure FillListbox(aSQLStatement : String);
  public

  end;

var
  Form2: TForm2;

implementation

uses udatamodul;

{$R *.lfm}

{ TForm2 }

procedure TForm2.Button1Click(Sender: TObject);
//var
//  aRecord : TRecord;
//  i : Integer;
//  AnzahlRecords : Integer;
begin
{  AnzahlRecords := 0;
  BCListBox1.Clear;
  ZMQueryDataSet1.TableName:= 'kunden';
  ZMQueryDataSet1.SQL.Text := 'SELECT * from kunden';
  ZMQueryDataSet1.QueryExecute;
  ZMQueryDataSet1.First;
  while not ZMQuerydataSet1.EOF do
  begin
    inc(AnzahlRecords);
    aRecord := TRecord.Create;
    aRecord.id       := ZMQueryDataSet1.FieldByName('id').AsString;
    aRecord.name     := ZMQueryDataSet1.FieldByName('name').AsString;
    aRecord.strasse  := ZMQueryDataSet1.FieldByName('strasse').AsString;
    aRecord.land     := ZMQueryDataSet1.FieldByName('land').AsString;
    aRecord.plz      := ZMQueryDataSet1.FieldByName('plz').AsString;
    aRecord.ort      := ZMQueryDataSet1.FieldByName('ort').AsString;
    aRecord.telefon  := ZMQueryDataSet1.FieldByName('telefon').AsString;
    BCListbox1.AddItem(ZMQueryDataSet1.FieldByName('id').AsString,aRecord);
    ZMQueryDataSet1.Next;
  end;
  BCListbox1.ItemIndex:=0;
  BCListBox1SelectionChange(Sender,true);
  BCListbox1.SetFocus;
  Label1.Caption := Format('Anzahl Kunden: %d',[AnzahlRecords]);
}
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  aRecord : TRecord;
  i : Integer;
  AnzahlRecords : Integer;
begin
//  ShowMessage(DM.DatabaseName);
  BCListBox1.BeginUpdateBounds;
  AnzahlRecords := 0;
  BCListBox1.Clear;
  DM.SQLQuery1.Close;
  DM.SQLQuery1.SQL.Text := 'SELECT * FROM Adressen';
  DM.SQLQuery1.Open;
  DM.SQLQuery1.First;
  while not DM.SQLQuery1.EOF do
  begin
     inc(AnzahlRecords);
     aRecord := TRecord.Create;
     aRecord.id       := DM.SQLQuery1.FieldByName('number').AsString;
     aRecord.name     := DM.SQLQuery1.FieldByName('nachname').AsString;
     aRecord.vorname  := DM.SQLQuery1.FieldByName('vorname').AsString;
     aRecord.strasse  := trim(DM.SQLQuery1.FieldByName('strasse').AsString+' '+
                              DM.SQLQuery1.FieldByName('hausnr').AsString+
                              DM.SQLQuery1.FieldByName('zusatz').AsString);
     aRecord.land     := 'DE';
     aRecord.plz      := DM.SQLQuery1.FieldByName('plz').AsString;
     aRecord.ort      := DM.SQLQuery1.FieldByName('ort').AsString;
     aRecord.telefon  := DM.SQLQuery1.FieldByName('telefon').AsString;
     BCListbox1.AddItem(aRecord.id,aRecord);
     DM.SQLQuery1.Next;
  end;

  if BCListbox1.Items.Count > 0 then
  begin
     BCListbox1.ItemIndex:=0;
     BCListBox1SelectionChange(Sender,true);
  end;
  Label1.Caption := Format('Anzahl Kunden: %d',[AnzahlRecords]);
  BCListBox1.EndUpdateBounds
end;

procedure TForm2.BCListBox1SelectionChange(Sender: TObject; User: boolean);
var
  id : String;
begin
  id := BCListbox1.Items[BCListbox1.ItemIndex];
  DM.SQLQuery1.Close;
  DM.SQLQuery1.SQL.Text := 'SELECT * from Adressen where number='+id;
  DM.SQLQuery1.Open;
  DM.SQLQuery1.First;
  if not DM.SQLQuery1.EOF then
  begin
    Edit2.text  := DM.SQLQuery1.FieldByName('number').AsString;
    Edit3.text  := DM.SQLQuery1.FieldByName('nachname').AsString;
    Edit4.text  := DM.SQLQuery1.FieldByName('vorname').AsString;
    Edit5.text  := DM.SQLQuery1.FieldByName('company').AsString;
    Edit6.text  := DM.SQLQuery1.FieldByName('strasse').AsString;
    Edit7.text  := ''; // ZMQueryDataSet1.FieldByName('mediaberater').AsString;
    Edit8.text  := 'DE'; // ZMQueryDataSet1.FieldByName('land').AsString;
    Edit9.text  := DM.SQLQuery1.FieldByName('plz').AsString;
    Edit10.text := DM.SQLQuery1.FieldByName('ort').AsString;
    Edit11.text := DM.SQLQuery1.FieldByName('email').AsString;
    Edit12.text := ''; //ZMQueryDataSet1.FieldByName('fax').AsString;
    Edit13.text := DM.SQLQuery1.FieldByName('telefon').AsString;
    Edit14.text := DM.SQLQuery1.FieldByName('branche').AsString;
    Edit15.text := ''; //ZMQueryDataSet1.FieldByName('ustid').AsString;
    Edit16.text := ''; //ZMQueryDataSet1.FieldByName('umsatz_vorjahr').AsString;
    Edit17.text := ''; //ZMQueryDataSet1.FieldByName('umsatz_lfd_jahr').AsString;
    Edit18.text := DM.SQLQuery1.FieldByName('hausnr').AsString;
    Edit19.text := DM.SQLQuery1.FieldByName('zusatz').AsString;

    Edit2.ReadOnly := true;
    Edit3.ReadOnly := true;
    Edit4.ReadOnly := true;
    Edit5.ReadOnly := true;
    Edit6.ReadOnly := true;
    Edit7.ReadOnly := true;
    Edit8.ReadOnly := true;
    Edit9.ReadOnly := true;
    Edit10.ReadOnly := true;
    Edit11.ReadOnly := true;
    Edit12.ReadOnly := true;
    Edit13.ReadOnly := true;
    Edit14.ReadOnly := true;
    Edit15.ReadOnly := true;
    Edit16.ReadOnly := true;
    Edit17.ReadOnly := true;
    Edit18.ReadOnly := true;
    Edit19.ReadOnly := true;
  end;
  DM.SQLQuery1.Close;
end;

procedure TForm2.BCListBox1DrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
begin
  with (Control as TListBox).Canvas do begin
     Brush.Style := bsSolid;
     if (Control as TListbox).Selected[Index] then
     begin
        Brush.Color := $00E9AA6D;
     end
     else
     begin
        Brush.Color := $00A05F39;
     end;
     Font.Color := clWhite;
     FillRect(aRect);
     Pen.Style:=psClear;
     Brush.Style := bsClear;
     TextOut(aRect.Left + 4, aRect.Top+14, TRecord((Control as TListBox).Items.Objects[Index]).strasse);
     TextOut(aRect.Left + 4, aRect.Top+28, TRecord((Control as TListBox).Items.Objects[Index]).plz+
                                          ' '+
                                          TRecord((Control as TListBox).Items.Objects[Index]).ort);
     Font.Style :=[fsBold];
     TextOut(aRect.Left + 4, aRect.Top, trim(TRecord((Control as TListBox).Items.Objects[Index]).name + ' '+
                                        TRecord((Control as TListBox).Items.Objects[Index]).vorname));
//     if (odFocused in State) then
//        DrawFocusRect(aRect);
   end;
end;

procedure TForm2.ColorSpeedButton1Click(Sender: TObject);
begin
  Notebook1.PageIndex := (Sender as TColorSpeedButton).Tag;
end;

procedure TForm2.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
     Image3Click(Sender);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
//  ZMConnection1.DatabasePath := '.\data\';
  Button2Click(Sender);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  AnimateWindow(self.Handle, 350, AW_VER_POSITIVE OR AW_SLIDE OR AW_ACTIVATE);
  AnimateWindow(pnlKunden.Handle, 350, AW_VER_POSITIVE OR AW_SLIDE OR AW_ACTIVATE);
  Label1.Caption := Format('Anzahl Kunden: %d',[random(101)]);
  BCListbox1.SetFocus;
end;

procedure TForm2.Image14Click(Sender: TObject);
begin
  AnimateWindow(self.Handle, 350, AW_VER_NEGATIVE OR AW_SLIDE OR AW_HIDE);
end;

procedure TForm2.Image1Click(Sender: TObject);
begin
  Edit2.ReadOnly  := true;
  Edit3.ReadOnly  := false;
  Edit4.ReadOnly  := false;
  Edit5.ReadOnly  := false;
  Edit6.ReadOnly  := false;
  Edit7.ReadOnly  := false;
  Edit8.ReadOnly  := false;
  Edit9.ReadOnly  := false;
  Edit10.ReadOnly := false;
  Edit11.ReadOnly := false;
  Edit12.ReadOnly := false;
  Edit13.ReadOnly := false;
  Edit14.ReadOnly := false;
  Edit15.ReadOnly := false;
  Edit16.ReadOnly := false;
  Edit17.ReadOnly := false;
  Edit18.ReadOnly := false;
  Edit19.ReadOnly := false;

end;

procedure TForm2.Image2Click(Sender: TObject);
var
  id : String;
begin
  id := BCListbox1.Items[BCListbox1.ItemIndex];
  if Edit3.readonly then exit;
  DM.UpdateQuery.Close;
  DM.UpdateQuery.SQL.Text := 'UPDATE Adressen SET '+
                             'nachname = :nachname, '+
                             'vorname = :vorname, '+
                             'company = :company, '+
                             'strasse = :strasse, '+
                             'telefon = :telefon, '+
                             'branche = :branche '+
                             'WHERE number='''+id+''';';
  DM.UpdateQuery.Prepare;
  DM.UpdateQuery.Params.ParamByName('nachname').AsString := Edit3.text;
  DM.UpdateQuery.Params.ParamByName('vorname').AsString := Edit4.text;
  DM.UpdateQuery.Params.ParamByName('company').AsString := Edit5.text;
  DM.UpdateQuery.Params.ParamByName('strasse').AsString := Edit6.text;
  DM.UpdateQuery.Params.ParamByName('telefon').AsString := Edit13.text;
  DM.UpdateQuery.Params.ParamByName('branche').AsString := Edit14.text;
  DM.UpdateQuery.ExecSQL;
  DM.SQLTransaction1.commit;
  RefreshListboxItem;
end;

procedure TForm2.Image3Click(Sender: TObject);
var
  MySQLStatement : String;
begin
  MySQLStatement := 'SELECT * FROM Adressen where nachname like '''+Edit1.text+'%'' or '+
                          'vorname LIKE ''%'+Edit1.text+'%'' or '+
                          'strasse LIKE ''%'+Edit1.text+'%'' or '+
                          'branche LIKE ''%'+Edit1.text+'%'' or '+
                          'company LIKE ''%'+Edit1.Text+'%'' '+
                          'ORDER BY nachname||vorname';
  FillListBox(MySQLStatement);
end;

procedure TForm2.RefreshListboxItem;
var
  id : String;
begin
  id := BCListbox1.Items[BCListbox1.ItemIndex];
  DM.UpdateQuery.Close;
  DM.UpdateQuery.SQL.Text := 'SELECT * FROM Adressen where number='''+id+''';';
  DM.UpdateQuery.Open;
  DM.UpdateQuery.First;
  if not DM.UpdateQuery.EOF then
  begin
    with (BCListbox1.Items.Objects[BCListbox1.ItemIndex] as TRecord) do
    begin
      name := DM.UpdateQuery.FieldByName('nachname').AsString;
      vorname  := DM.UpdateQuery.FieldByName('vorname').AsString;
      strasse  := trim(DM.UpdateQuery.FieldByName('strasse').AsString+' '+
                       DM.UpdateQuery.FieldByName('hausnr').AsString+
                       DM.UpdateQuery.FieldByName('zusatz').AsString);
      land     := 'DE';
      plz      := DM.UpdateQuery.FieldByName('plz').AsString;
      ort      := DM.UpdateQuery.FieldByName('ort').AsString;
      telefon  := DM.UpdateQuery.FieldByName('telefon').AsString;
    end;
  end;
  DM.UpdateQuery.Close;
  BCListBox1.Refresh;
end;

procedure TForm2.FillListbox(aSQLStatement: String);
var
  aRecord : TRecord;
  AnzahlRecords : Integer;
begin
//  ShowMessage(DM.DatabaseName);
  BCListBox1.BeginUpdateBounds;
  AnzahlRecords := 0;
  BCListBox1.Clear;
  DM.SQLQuery1.Close;
  DM.SQLQuery1.SQL.Text := aSQLStatement;
  DM.SQLQuery1.Open;
  DM.SQLQuery1.First;
  while not DM.SQLQuery1.EOF do
  begin
     inc(AnzahlRecords);
     aRecord := TRecord.Create;
     aRecord.id       := DM.SQLQuery1.FieldByName('number').AsString;
     aRecord.name     := DM.SQLQuery1.FieldByName('nachname').AsString;
     aRecord.vorname  := DM.SQLQuery1.FieldByName('vorname').AsString;
     aRecord.strasse  := trim(DM.SQLQuery1.FieldByName('strasse').AsString+' '+
                              DM.SQLQuery1.FieldByName('hausnr').AsString+
                              DM.SQLQuery1.FieldByName('zusatz').AsString);
     aRecord.land     := 'DE';
     aRecord.plz      := DM.SQLQuery1.FieldByName('plz').AsString;
     aRecord.ort      := DM.SQLQuery1.FieldByName('ort').AsString;
     aRecord.telefon  := DM.SQLQuery1.FieldByName('telefon').AsString;
     BCListbox1.AddItem(aRecord.id,aRecord);
     DM.SQLQuery1.Next;
  end;

  if BCListbox1.Items.Count > 0 then
  begin
     BCListbox1.ItemIndex:=0;
     BCListBox1SelectionChange(nil,true);
  end;
  Label1.Caption := Format('Anzahl Kunden: %d',[AnzahlRecords]);
  BCListBox1.EndUpdateBounds
end;

end.

