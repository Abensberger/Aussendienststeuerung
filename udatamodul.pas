unit udatamodul;

{$mode objfpc}{$H+}

interface

uses
  Forms, Classes, SysUtils, SQLite3Conn, SQLDB, Dialogs;

type

  { TDM }

  TDM = class(TDataModule)
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    UpdateQuery: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    FIsConnected: Boolean;
    function GetIsConnected : Boolean;
    procedure FillNewDB(aSQLFile  : String);
  public
    DatabaseName : String;
    property IsConnected : Boolean read GetIsConnected;
  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
var
  bNewDB : Boolean;
begin
  ForceDirectories(ExtractFilePath(Application.ExeName)+'\data');
  DatabaseName := ExtractFilePath(Application.ExeName)+'\data\Aussendienst.sqlite';
  bNewDB := not Fileexists(DatabaseName);
  // ---------------------------------------------------------------------------
  SQLite3Connection1.DatabaseName := DatabaseName;
  SQLTransaction1.Database:=SQLite3Connection1;
  SQLQuery1.Transaction:=SQLTransaction1;
  UpdateQuery.Transaction:=SQLTransaction1;
  SQLite3Connection1.Open;
  // ---------------------------------------------------------------------------
  if IsConnected and bNewDB then
     FillNewDB(ExtractFilePath(Application.ExeName)+'FakeData.SQL');
end;

function TDM.GetIsConnected: Boolean;
begin
  result := SQLite3Connection1.Connected;
end;

procedure TDM.FillNewDB(aSQLFile: String);
VAR
  SL : TStringList;
  s : string;
  i : integer;
begin
  ShowMessage('DB not found. Create newDB : '+aSQLFile);
  SQLQuery1.Close;
  SQLQuery1.SQL.Text:= 'CREATE TABLE if not Exists  Adressen ('+
                             ' number INTEGER PRIMARY KEY AUTOINCREMENT, '+
                             ' gender varchar(6), '+
                             ' company varchar(70), '+
                             ' nachname varchar(25), '+
                             ' vorname varchar(25), '+
                             ' strasse varchar(100), '+
                             ' hausnr varchar(5), '+
                             ' zusatz varchar(5), '+
                             ' plz varchar(10), '+
                             ' ort varchar(35), '+
                             ' vorwahl varchar(10), '+
                             ' telefon varchar(15), '+
                             ' email varchar(35), '+
                             ' url varchar(35), '+
                             ' branche varchar(50), '+
                             ' beruf varchar(50))';
  SQLQuery1.ExecSQL;
  SQLTransaction1.commit;

  SL := TStringlist.create;
  SL.LoadFromFile(aSQLFile);

  for i := 0 to SL.Count-1 do
  begin
      s := SL[i];
      if s.StartsWith('insert into Adressen',true) then
      begin
        SQLQuery1.SQL.Text := s;
        SQLQuery1.ExecSQL;
      end;
  end;
  SQLTransaction1.commit;
  SL.Free;
end;


end.

