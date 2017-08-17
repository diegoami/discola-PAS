program Briscolino;

uses
  Forms,
  Briscola in 'Briscola.pas' {Form1},
  UMazzo in 'UMazzo.pas',
  UGiocatore in 'UGiocatore.pas',
  Global in 'Global.pas',
  About in 'About.pas' {OKBottomDlg},
  UPunteggio in 'UPunteggio.pas' {PunteggioDlg},
  TimerDlg in 'TimerDlg.pas' {TimerDialog},
  UDifficulty in 'UDifficulty.pas' {DifficultyDlg},
  UOkRight in 'UOkRight.pas' {OKRightDlg};


{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TOKBottomDlg, OKBottomDlg);
  Application.CreateForm(TPunteggioDlg, PunteggioDlg);
  Application.CreateForm(TTimerDialog, TimerDialog);
  Application.CreateForm(TDifficultyDlg, DifficultyDlg);
  Application.CreateForm(TOKRightDlg, OKRightDlg);
  Application.Title := 'Discola!';
  Application.HelpFile := 'C:\Programmi\Borland\Delphi 3\Miei\discola\Discola.hlp';
  Application.Run;
end.
