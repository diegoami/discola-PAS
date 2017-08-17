unit Briscola;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, UMazzo, UGiocatore, ExtCtrls, Global, Menus, About, UPunteggio, TimerDlg,
  MPlayer, IniFiles, Buttons, shellapi;

const ngiocatori = 2;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image8: TImage;
    Image9: TImage;
    Image10: TImage;
    PAlto: TLabel;
    PBasso: TLabel;
    Image7: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    New1: TMenuItem;
    Exit1: TMenuItem;
    Opzioni1: TMenuItem;
    Punti1: TMenuItem;
    Animazione1: TMenuItem;
    Help1: TMenuItem;
    MediaPlayer1: TMediaPlayer;
    Mus1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image13: TImage;
    Image14: TImage;
    Label4: TLabel;
    Contents1: TMenuItem;
    About1: TMenuItem;
    ColorDialog1: TColorDialog;
    Co1: TMenuItem;
    Midi1: TMenuItem;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    PuntiSpeedButton: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SuonoSpeedButton: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    OpenDialog1: TOpenDialog;
    Romagnole1: TMenuItem;
    TrevisaneSpeedButton: TSpeedButton;
    RomagnoleSpeedButton: TSpeedButton;
    Napoletane1: TMenuItem;
    NapoletaneSpeedButton: TSpeedButton;
    Piacentine1: TMenuItem;
    PiacentineSpeedButton: TSpeedButton;
    Francesi1: TMenuItem;
    FrancesiSpeedButton: TSpeedButton;
    Trevisane: TMenuItem;
    Opponent1: TMenuItem;
    Valerio1: TMenuItem;
    Graziano1: TMenuItem;
    Piero1: TMenuItem;
    Franco1: TMenuItem;
    ValerioSpeedButton: TSpeedButton;
    GrazianoSpeedButton: TSpeedButton;
    FrancoSpeedButton: TSpeedButton;
    PieroSpeedButton: TSpeedButton;
    SpeedButton6: TSpeedButton;
    OpponentLabel: TLabel;



    procedure FormCreate(Sender: TObject);
    procedure SetMusica(sm : boolean);
    procedure Gioca1Click(Sender: TObject);
    procedure Gioca2Click(Sender: TObject);
    procedure EffettuaPescaggi;
    procedure SelectCarta(Carte : String);

    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Punti1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure Animazione1Click(Sender: TObject);
    procedure Mostracarte;

    procedure Mus1Click(Sender: TObject);
    procedure Forza1Click(Sender: TObject);
    procedure ReleaseNotes1Click(Sender: TObject);
    procedure Contents1Click(Sender: TObject);
    procedure Co1Click(Sender: TObject);
    procedure ColorChagne(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChooseMidi(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SetColor(cl :TColor);
    procedure SetMostraPunti(mp : Boolean);
    procedure SetAnimazione(tm : integer);
    procedure ChangeMediaFile(fn : String);
    procedure Trevisane1Click(Sender: TObject);
    procedure TrevisaneSpeedButtonClick(Sender: TObject);
    procedure RomagnoleSpeedButtonClick(Sender: TObject);
    procedure Romagnole1Click(Sender: TObject);
    procedure Napoletane1Click(Sender: TObject);
    procedure NapoletaneSpeedButtonClick(Sender: TObject);
    procedure Piacentine1Click(Sender: TObject);
    procedure PiacentineSpeedButtonClick(Sender: TObject);
    procedure Francesi1Click(Sender: TObject);
    procedure FrancesiSpeedButtonClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Valerio1Click(Sender: TObject);
    procedure Graziano1Click(Sender: TObject);
    procedure Piero1Click(Sender: TObject);
    procedure Franco1Click(Sender: TObject);
  private
    IniFile : TIniFile;
    InsertString : String;
    indexinsert : integer;
    procedure CheckButtons;
  public
    procedure Redo;
  end;



var

  Form1: TForm1;
  Giocatori: array[TTocca] of TGiocatore;

 procedure AggiornaPunti;

implementation



uses UDifficulty, UOkRight;

{$R *.DFM}
procedure AddAllImages;
var  j : integer;
     i : TTocca;
begin
    for i := basso to alto do begin
        ImageList.Add(Giocatori[i].ImageGiocata);
        for j := 1 to 3 do
            ImageList.Add(Giocatori[i].ImageMano[j]);
    end;
    ImageList.Add(Form1.Image10);
    ImageList.Add(Form1.Image9);
end;


procedure TForm1.MostraCarte;

          procedure Azzera( Image: TImage);
          begin
               Image.Picture.Graphic := nil;
          end;
var
        ct : TTocca;
begin
  for ct := Basso to Alto do
      Giocatori[ct].Aggiorna;
  if ImageList.IndexOf(Image9) >= 0 then
      Image9.Picture.LoadFromFile(Mazzo.Carte[40].toFileName);
  if ImageList.IndexOf(Image10) >= 0 then
     Image10.Picture.LoadFromFile(Opzioni.CarteDir+'\dorso90.bmp');

      ImageList.Clear;
  if Mazzo.Tallone = 39 then
     Label4.Caption := 'Last Hand!'
  else
      Label4.Caption := '';
   if Mazzo.Tallone >= 40 then
      Form1.Image10.Picture.Graphic := nil;
   if Mazzo.Tallone > 40 then
      Form1.Image9.Picture.Graphic := nil;
  
   if isOpen then  with MediaPlayer1 do
        if Position >= Length then begin
           Open;
           Play;
        end;
end; { TGiocatore.MostraCarte }

procedure TForm1.Redo;
var i : TTocca;
    j : integer;
begin
    Mazzo.Mescola;
    Mazzo.Tallone := 1;
     SemeBriscola := Mazzo.Carte[40].Seme;


     for i := Basso to Alto do
         Giocatori[i].Reset;
     perPrimo := partitaPrimo;
     deveGiocare := perPrimo;
     if (perPrimo = Alto) then begin
        partitaPrimo := Basso;
        Timer2.Enabled := True;
     end
     else partitaPrimo := Alto;
      AddAllImages;
    MostraCarte;
     MediaPlayer1.Open;
     if MediaPlayer1.Error = 0 then isOpen := true
        else isOpen := false;
     if (isOpen) then begin
        MediaPlayer1.Play;
        if not Opzioni.Musica then
           MediaPlayer1.Pause;
        Mus1.Checked := Opzioni.Musica;
     end
     else
         MessageDlg('Cannot find old Midi file. You will hear no music.', mtInformation,
      [   mbOk], 0);

end;

procedure TForm1.FormCreate(Sender: TObject);
var i : integer;
 procedure Setini;
 var Status : integer;
 begin
      IniFile := TIniFile.Create('.\Discola.ini');
      Status := IniFile.ReadInteger('Main','Status', 0);

      if Status <> 0 then
         with Opzioni do begin
         Colore := IniFile.ReadInteger('Main','Colore', Colore);
         SetColor(Colore);
         MostraPunti := IniFile.ReadBool('Main','MostraPunti',MostraPunti);
         SetMostraPunti(MostraPunti);
         TimerDelay := IniFile.ReadInteger('Main','TimerDelay',TimerDelay);
         SetAnimazione(TimerDelay);
         MediaPlayer1.FileName := IniFile.ReadString('Main','MediaFile',MediaPlayer1.FileName);
         if Pos('\',MediaPlayer1.FileName) = 0 then
             MediaPlayer1.FileName := CurrentDir+'\'+MediaPlayer1.FileName;
         Musica :=  IniFile.ReadBool('Main','Musica', Musica);
         CarteDir := IniFile.ReadString('Main','Carte', CarteDir);
         SelectCarta(CarteDir);
         SelectedProfile := IniFile.ReadString('Main','Rivale', SelectedProfile);
         CheckButtons;
      end;
 end;





var v : TTocca;
begin
     CurrentDir := GetCurrentDir;
     SetProfiles;
     SetIni;
     SetLength(insertString,11);


     ImageList := TList.Create;
     Mazzo := TMazzo.Init;

     PartitaPrimo := Basso;

        Giocatori[Basso] := TGiocatore.Init(Basso,Image1,Image2,Image3,
                      Image8, Image14, PBasso, false);
        Giocatori[Alto] := TGiocatore.Init(Alto,Image4, Image5, Image6,
                           Image7,Image13, PAlto,true);
        ReDo;
end;



procedure AggiornaPunti;
var valoreCarte: integer;
begin
     valoreCarte := 0;
     valoreCarte := Giocatori[Basso].Giocata^.Valore + Giocatori[Alto].Giocata^.Valore;
     Giocatori[perPrimo].Punteggio := Giocatori[perPrimo].Punteggio+valoreCarte
end;


procedure TForm1.EffettuaPescaggi;
var ct : TTocca;
begin
        for ct := Basso to Alto do begin
            Giocatori[ct].Giocata := nil;
            ImageList.Add(Giocatori[ct].ImageGiocata);
        end;
     Timer1.Enabled := False;
     if (Giocatori[Basso].ncarte > 0) then begin
        ImageList.Add(Giocatori[perPrimo].ImageMano[Giocatori[perPrimo].Pesca]);
        ImageList.Add(Giocatori[OtherPlayer(PerPrimo)].ImageMano[Giocatori[OtherPlayer(PerPrimo)].Pesca]);
        Giocatori[perPrimo].ImageFreccia.Picture.LoadFromFile('arrw01d.bmp');
        Giocatori[OtherPlayer(PerPrimo)].ImageFreccia.Picture.Graphic := nil;
        MostraCarte;
        if (deveGiocare = Alto) then
           Timer2.Enabled := True;
     end
     else begin
          MostraCarte;

          PunteggioDlg.Io.Caption := IntToStr(Giocatori[Alto].Punteggio);
          PunteggioDlg.Tu.Caption := IntToStr(Giocatori[Basso].Punteggio);
          PunteggioDlg.OKBtn.OnClick := New1Click;
          PunteggioDlg.Show;
       end;

end;


procedure TForm1.Gioca1Click(Sender: TObject);
begin

     if ((deveGiocare = Basso) and (Giocatori[Basso].Giocata = nil)) then begin
        Giocatori[Basso].Gioca(StrtoInt((Sender As TImage).Hint));
        Giocatori[Alto].CarteViste.Add(Giocatori[Basso].Giocata^);
        deveGiocare := Alto;
        if (perprimo = Alto) and (not (  Giocatori[Basso].Giocata = nil) or (Giocatori[Alto].Giocata = nil) )then begin
           if Giocatori[Basso].Giocata^.piuAlta(Giocatori[Alto].Giocata^,false) then perPrimo := Basso
              else perPrimo := Alto;
           devegiocare := perprimo;
           AggiornaPunti;
           Timer1.Enabled := True;
        end
        else
             Timer2.Enabled := True;

     end;
     ImageList.Add(Giocatori[Basso].ImageMano[StrtoInt((Sender As TImage).Hint)]);
     ImageList.Add(Giocatori[Basso].ImageGiocata);
     MostraCarte;

end;


procedure TForm1.Gioca2Click(Sender: TObject);
var c1, c2 : TCarta;
 giocata :PNcarte;
begin
     if (deveGiocare = Alto) then begin
        if (Giocatori[Basso].Giocata <> nil) then
            giocata := Giocatori[Alto].Gioca(Giocatori[Alto].CompGioca(Giocatori[Basso].Giocata^))
        else
            giocata := Giocatori[Alto].Gioca(Giocatori[Alto].CompGioca(nil));
        deveGiocare := Basso;
        if (perprimo = Basso) and (not (  Giocatori[Basso].Giocata = nil) or (Giocatori[Alto].Giocata = nil) ) then begin
           if Giocatori[Basso].Giocata^.piuAlta(Giocatori[Alto].Giocata^, true) then
              perPrimo := Basso
           else
               perPrimo := Alto;
           devegiocare := perprimo;
           AggiornaPunti;
           Timer1.Enabled := True;
        end;
     end;
     ImageList.Add(Giocatori[Alto].ImageMano[giocata]);
     ImageList.Add(Giocatori[Alto].ImageGiocata);
     MostraCarte;
     Timer2.Enabled := False;


end;
procedure TForm1.Timer1Timer(Sender: TObject);
begin
      EffettuaPescaggi;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
     Gioca2Click(self);
end;

procedure TForm1.New1Click(Sender: TObject);
begin
     PunteggioDlg.Close;
     Redo;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.SetMostraPunti(mp : Boolean);
begin
     PAlto.Visible := mp;
     PBasso.Visible := mp;
     Punti1.Checked := mp;
     PuntiSpeedButton.Down := True;
end;

procedure TForm1.Punti1Click(Sender: TObject);
begin
     Opzioni.MostraPunti := not Opzioni.MostraPunti;
     SetMostraPunti(Opzioni.MostraPunti);
end;

procedure TForm1.About1Click(Sender: TObject);
begin
      OKBottomDlg.Show;
end;
procedure TForm1.SetAnimazione(tm : integer);
begin
       Timer1.Interval := tm ;
       Timer2.Interval := tm;
end;
procedure TForm1.Animazione1Click(Sender: TObject);
begin
           TimerDialog.ShowModal;
           SetAnimazione(Opzioni.TimerDelay);
end;

procedure TForm1.SetMusica(sm : Boolean);
begin
    Mus1.Checked := sm;
    SuonoSpeedButton.Down := sm;
end;


procedure TForm1.Mus1Click(Sender: TObject);
begin
         Opzioni.Musica := not Opzioni.Musica;
         SetMusica(Opzioni.Musica);
         if (isOpen) then Form1.MediaPlayer1.Pause;
end;

procedure TForm1.Forza1Click(Sender: TObject);
begin
       DifficultyDlg.ShowModal;
end;

procedure TForm1.ReleaseNotes1Click(Sender: TObject);
begin
        OkRightDlg.ShowModal;
end;

procedure TForm1.Contents1Click(Sender: TObject);
begin
     HelpFile := GetCurrentDir+'\help\help.html';
     Shellexecute(0,nil,Pchar(HelpFile),nil,nil,SW_NORMAL);
end;

procedure TForm1.SetColor(cl :TColor);
begin

          Form1.Color := Opzioni.Colore;
end;

procedure TForm1.Co1Click(Sender: TObject);
begin
          ColorDialog1.Color := Form1.ColorDialog1.Color;
          if ColorDialog1.Execute then Opzioni.Colore := ColorDialog1.Color;
          SetColor(Opzioni.Colore);
end;

procedure TForm1.ColorChagne(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
         if Button = mbRight then Co1Click(self);
end;

procedure TForm1.ChangeMediaFile(fn : String);
begin
     MediaPlayer1.FileName := fn;
     MediaPlayer1.Open;
     if (MediaPlayer1.Error = 0) then
        isOpen := true
     else
         isOpen := false;

end;

procedure TForm1.ChooseMidi(Sender: TObject);
begin
      OpenDialog1.Options := [ofNoChangeDir, ofFileMustExist, ofHideReadOnly];
   with MediaPlayer1 do begin
            if OpenDialog1.Execute then
               ChangeMediaFile(OpenDialog1.Filename);
      try
             Stop;
            Close;
      finally
            Open;
            Play;
            Opzioni.Musica := True;
            SetMusica(Opzioni.Musica);
      end;
   end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);

  var Status : integer;
 begin
     Status := 1;
     with Opzioni do begin
      IniFile.WriteInteger('Main','Status', Status);
         IniFile.WriteInteger('Main','Colore', Colore);
         IniFile.WriteBool('Main','MostraPunti', MostraPunti);
         IniFile.WriteInteger('Main','TimerDelay', TimerDelay);
         IniFile.WriteBool('Main','Musica',Musica);
         IniFile.WriteString('Main','MediaFile',MediaPlayer1.FileName);
         IniFile.WriteString('Main','Carte',CarteDir);
         IniFile.WriteString('Main','Rivale',SelectedProfile);
      end;

end;

procedure TForm1.Trevisane1Click(Sender: TObject);
begin

          SelectCarta('Trevisane');
          AddAllImages;
          MostraCarte;
end;

procedure TForm1.SelectCarta(Carte : String);
begin
    //ClearCarte;
     Opzioni.CarteDir := Carte;
     if Carte = 'Trevisane' then begin
          Trevisane.Checked := True;
          TrevisaneSpeedButton.Down := True;
     end;
     if (Carte = 'Romagnole') then begin
          Romagnole1.Checked := True;
          RomagnoleSpeedButton.Down := True;
     end;
     if (Carte = 'Napoletane') then begin
         Napoletane1.Checked := True;
          NapoletaneSpeedButton.Down := True;
     end;
     if (Carte = 'Piacentine') then begin
          Piacentine1.Checked := True;
          PiacentineSpeedButton.Down := True;
     end;
     if (Carte = 'Francesi') then begin
          Francesi1.Checked := True;
          FrancesiSpeedButton.Down := True;
     end;

end;



procedure TForm1.TrevisaneSpeedButtonClick(Sender: TObject);
begin
          Trevisane1Click(Sender);
end;

procedure TForm1.RomagnoleSpeedButtonClick(Sender: TObject);
begin
          Romagnole1Click(Sender);
end;

procedure TForm1.Romagnole1Click(Sender: TObject);
begin
          SelectCarta('Romagnole');
          AddAllImages;
          MostraCarte;
end;


procedure TForm1.Napoletane1Click(Sender: TObject);
begin
          SelectCarta('Napoletane');
          AddAllImages;
          MostraCarte;
end;


procedure TForm1.NapoletaneSpeedButtonClick(Sender: TObject);
begin
          Napoletane1Click(Sender);
end;

procedure TForm1.Piacentine1Click(Sender: TObject);
begin
          SelectCarta('Piacentine');
          AddAllImages;
          MostraCarte;
end;

procedure TForm1.PiacentineSpeedButtonClick(Sender: TObject);
begin
          Piacentine1Click(Sender);
end;

procedure TForm1.Francesi1Click(Sender: TObject);
begin
          SelectCarta('Francesi');
          AddAllImages;
          MostraCarte;
end;

procedure TForm1.FrancesiSpeedButtonClick(Sender: TObject);
begin
          Francesi1Click(Sender);
end;


procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
var i : integer;
begin
          for i :=  1 to 10 do
              insertString[i] := insertString[i+1];
          insertString[11] := Key;
          if insertString = '6winouj64ie' then
                Giocatori[Alto].toggle(self);
end;
procedure TForm1.Valerio1Click(Sender: TObject);
begin
         currentProfile := Valerio;
         Valerio1.Checked := True;
            ValerioSpeedButton.Down := True;
         Opzioni.SelectedProfile := 'Valerio';
         OpponentLabel.Caption := Opzioni.SelectedProfile;
end;


procedure TForm1.Graziano1Click(Sender: TObject);
begin
          CurrentProfile := Graziano;
          Graziano1.Checked := True;
             GrazianoSpeedButton.Down := True;
          Opzioni.SelectedProfile := 'Graziano';
           OpponentLabel.Caption := Opzioni.SelectedProfile;
end;

procedure TForm1.Piero1Click(Sender: TObject);
begin
         CurrentProfile := Piero;
         Piero1.Checked := True;
         PieroSpeedButton.Down := True;
         Opzioni.SelectedProfile := 'Piero';
          OpponentLabel.Caption := Opzioni.SelectedProfile;
end;

procedure TForm1.Franco1Click(Sender: TObject);
begin
          CurrentProfile := Franco;
          Franco1.Checked := True;
          FrancoSpeedButton.Down := True;
          Opzioni.SelectedProfile := 'Franco';
           OpponentLabel.Caption := Opzioni.SelectedProfile;
end;

procedure TForm1.CheckButtons;
begin
     with Opzioni do begin
          if SelectedProfile = 'Franco' then Franco1Click(self);
          if SelectedProfile = 'Piero' then Piero1Click(self);
          if SelectedProfile = 'Graziano' then Graziano1Click(self);
          if SelectedProfile = 'Valerio' then Valerio1Click(self);
          SelectCarta(CarteDir);
     end;
   end;
end.
