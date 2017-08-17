unit UDifficulty;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Global;

type
  TDifficultyDlg = class(TForm)
    OKBtn: TButton;
    RadioGroup1: TRadioGroup;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DifficultyDlg: TDifficultyDlg;

implementation

{$R *.DFM}

procedure TDifficultyDlg.OKBtnClick(Sender: TObject);
begin
       //Opzioni.Difficolta := RadioGroup1.ItemIndex;
       Close;
end;

end.
