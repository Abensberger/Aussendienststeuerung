program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lazcontrols, tachartlazaruspkg, umain, ukunden, udatamodul, udashboard,
  uInfoFrame, uStatistics
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmDashboard, frmDashboard);
  Application.CreateForm(TfrmStatistiken, frmStatistiken);
//  Application.ShowMainForm:=False;
  Application.Run;
end.

