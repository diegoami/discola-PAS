unit UPunteggio;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls, Global;

type
  TPunteggioDlg = class(TForm)
    OKBtn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Io: TLabel;
    Tu: TLabel;
    Image1: TImage;
    procedure Exit1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PunteggioDlg: TPunteggioDlg;

implementation

{$R *.DFM}

procedure TPunteggioDlg.Exit1Click(Sender: TObject);
begin
     Close;
end;

end.
