unit TimerDlg;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Global;

type
  TTimerDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    ScrollBar1: TScrollBar;
    Label2: TLabel;
    Label3: TLabel;
    procedure SetEdit1Text(Sender: TObject);
    procedure SetTimer(Sender: TObject);
    procedure DialogClose(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TimerDialog: TTimerDialog;

implementation

{$R *.DFM}

procedure TTimerDialog.SetEdit1Text(Sender: TObject);
begin
    
     Scrollbar1.Position :=  Opzioni.TimerDelay;
end;

procedure TTimerDialog.SetTimer(Sender: TObject);
begin
           Opzioni.TimerDelay := ScrollBar1.Position;
           Close;
end;

procedure TTimerDialog.DialogClose(Sender: TObject);
begin
     Close;
end;


end.
