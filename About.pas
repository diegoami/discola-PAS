unit About;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TOKBottomDlg = class(TForm)
    OKBtn: TButton;
    Bevel1: TBevel;
    Label1: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Label3: TLabel;
    Versione: TStaticText;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OKBottomDlg: TOKBottomDlg;

implementation

{$R *.DFM}

procedure TOKBottomDlg.OKBtnClick(Sender: TObject);
begin
          Close;
end;

end.
