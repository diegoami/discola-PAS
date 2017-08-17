program Discola;

uses
  Forms,
  Briscola in 'Briscola.pas' {Form1},
  UMazzo in 'UMazzo.pas',
  UGiocatore in 'UGiocatore.pas',
  Global in 'Global.pas',
  About in 'About.pas' {OKBottomDlg},
  UPunteggio in 'UPunteggio.pas' {PunteggioDlg},
  TimerDlg in 'TimerDlg.pas' {TimerDialog};


{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.CreateForm(TPunteggioDlg, PunteggioDlg);
  Application.CreateForm(TTimerDialog, TimerDialog);
  Application.Title := 'Discola!';
  Application.HelpFile := 'Discola.hlp';
  Application.Run;
end.
