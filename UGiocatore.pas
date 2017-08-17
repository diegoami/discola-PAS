unit UGiocatore;


interface
uses  Umazzo, Global, classes, extctrls, stdctrls, sysutils, forms;

type
 TMostraCartaProc = procedure (Carta: TCarta;  Image: TImage);
  TMano = array[PNCarte] of PCarta;
  TGiocatore = class

              ImageMano : array[PNCarte] of TImage;
             ImageGiocata : TImage;
             ImageFreccia : Timage;
             PunteggioLabel : TLabel;
             MostraCartaProc : procedure (Carta: TCarta;  Image: TImage);
             CarteViste : TList;
             WhoAmI : TTocca;
             Mano : TMano;
             Giocata : PCarta;
             Punteggio : 0..120;
             isCoperta : boolean;
             function ncarte : TTallone;
             function ha(carta : PNcarte) : boolean;
             procedure Aggiorna;
             function Pesca : PNCarte;
             procedure Reset;
             function Gioca(carta : PNcarte) : PNcarte;
             constructor init(Chisono : TTocca;Image1, Image2, Image3, ImageG, ImageF : TImage;
                                    PunteggioL : TLabel; Coperta : boolean);
             function CompGioca(Carta : TCarta) : PNCarte;
             procedure Toggle(form : TForm);
         
      end;
var ImageList : Tlist;

implementation



procedure Modifica(Carta: TCarta;  Image: TImage);
begin

     Image.Picture.LoadFromFile(Carta.toFileName);
end;
procedure Copri(Carta: TCarta;  Image: TImage);
begin
     Image.Picture.LoadFromFile(Opzioni.CarteDir+'\dorso.bmp');
end;

procedure TGIocatore.Reset;
var i :PNCarte;
begin
 CarteViste.Clear;
 for i := 1 to 3 do
         Mano[i]:= nil;
     Punteggio := 0;
     Pesca;
     Pesca;
     Pesca;
end;

constructor TGiocatore.init(Chisono : TTocca;Image1, Image2, Image3, ImageG, ImageF : TImage;
                                    PunteggioL : TLabel; Coperta: boolean);

begin
        WhoAmI := ChiSono;
        ImageMano[1] :=  Image1;
        ImageMano[2] :=  Image2;
        ImageMano[3] := Image3;
        ImageGiocata := ImageG;
        if Coperta then  MostraCartaProc := Copri
           else MostraCartaProc := Modifica;
        PunteggioLabel := PunteggioL;
        ImageFreccia := ImageF;
        CarteViste := TList.Create;
        isCoperta := Coperta;
end; {  TGiocatore.init }

procedure TGIocatore.Toggle(form : TForm);
var i : PNCArte;
begin
     isCoperta :=not isCoperta;
     if not isCoperta then
        MostraCartaProc := Modifica
     else MostraCartaProc := Copri;
     for i := 1 to 3 do
         ImageList.Add(ImageMano[i]);
     Aggiorna;
end;
function TGiocatore.ha(carta : PNCarte) : boolean;
begin
     if Mano[carta] = nil then
        ha := false
     else ha := true;
end; { TGiocatore.ha }

function TGiocatore.ncarte : TTallone;
var i : TTallone;
    nc : 0..3;
begin
     nc := 0;
     for i := 1 to 3 do
         if ha(i) then inc(nc);
     ncarte := nc;
end; { TGiocatore.ncarte }

function TGiocatore.pesca : PNcarte;
var Carta : PCarta;
    i : TTallone;
begin

    if Mazzo.Tallone <= 40 then  begin
       i := 1;
       Carta := Mazzo.pop;
       if Carta <> nil then CarteViste.Add(Carta^);
       while ((ha(i)) and (i < 3)) do
          inc(i);
       if i <=3 then
         Mano[i] := Carta;
       Giocata := nil;
       Pesca := i;
    end

end; { TGiocatore.pesca }

function TGiocatore.Gioca(carta : PNcarte) : PNcarte;
begin
     if Mano[carta] <> nil then Giocata := Mano[carta];
     Mano[carta] := nil;
     Gioca := carta;
end;

function TGiocatore.CompGioca(Carta : TCarta) : PNCarte;
var
    i : PNCarte;
    punteggio : array[PNCarte] of real;
    cartaval, miaval : integer;
    prende : boolean;



var tempcarta : PNCarte;
    tempunt : real;

    CompCarta : TCarta;
  function SemiAndati(ts :TSeme) : integer;
  var valore, i : integer;
  begin
     valore := 0;
     for i := 1 to CarteViste.Count-1 do
         if TCarta(CarteViste.Items[i]).Seme = ts then
            valore := valore + TCarta(CarteViste.Items[i]).Valore;
     SemiAndati := valore;
  end;

  function CountCarte(ts :TSeme) : integer;
  var count, i : integer;
  begin
     count := 0;
     for i := 1 to CarteViste.Count-1 do
         if TCarta(CarteViste.Items[i]).Seme = ts then
            inc(count);
     CountCarte := count;
  end;



  begin
  with CurrentProfile do begin
    tempcarta := 1;
    tempunt := -150;
    if Carta = nil then begin
       for i := 1 to 3 do if Mano[i] <> nil then begin
           CompCarta := Mano[i]^;
           if CompCarta.Seme = SemeBriscola
              then punteggio[i] := 100 - FIXED_BRISCOLA_PENALTY -  CompCarta.Valore*VARIANT_BRISCOLA_PENALTY
           else begin
               punteggio[i] := 100 - CompCarta.Valore*(1-VARIANT_CARICO_PENALTY*CountCarte(SemeBriscola));
               if CompCarta.Valore < 10 then punteggio[i] := punteggio[i] + SemiAndati(CompCarta.Seme)*VARIANT_STROZZO_PENALTY;
           end;
           if CompCarta.Valore = 10 then punteggio[i] := punteggio[i]-FIXED_TRE_PENALTY;
           if punteggio[i] > tempunt then begin
              tempunt := punteggio[i];
              tempcarta := i;
           end;
       end;
    end
    else begin
       cartaval := Carta.valore;
       for i := 1 to 3 do if Mano[i] <> nil then begin
          CompCarta := Mano[i]^;
          if perprimo = Alto then prende:= true
             else prende := false;
          prende := CompCarta.piuAlta(Carta,prende);
          miaval := CompCarta.Valore;
          if prende then punteggio[i] := cartaval+miaval*VARIANT_WINNING_CARD_PENALTY
              else punteggio[i] := -cartaval*VARIANT_WINNING_CARD_PENALTY-miaval;
           if CompCarta.Seme = SemeBriscola then begin
              if prende then
                 punteggio[i] := punteggio[i]- CompCarta.Valore*VARIANT_WINNER_BRISCOLA_PENALTY-FIXED_WINNER_BRISCOLA_PENALTY
              else
                 punteggio[i] := punteggio[i]- CompCarta.Valore*VARIANT_LOSER_BRISCOLA_PENALTY -FIXED_LOSER_BRISCOLA_PENALTY
           end

           else if CompCarta.Valore < 10 then
              punteggio[i] := punteggio[i]-SemiAndati(CompCarta.Seme)* VARIANT_PASSIVE_STROZZO_PENALTY;
           if (Mazzo.Tallone = 39) and (prende) then
              punteggio[i] := punteggio[i]-Mazzo.Carte[40].Valore*VARIANT_WINNER_BRISCOLA_PENALTY-  FIXED_WINNER_BRISCOLA_PENALTY;
           if CompCarta.Valore = 11 then punteggio[i]:= punteggio[i]-ASSO_PENALTY;
           if punteggio[i] > tempunt then begin
              tempunt := punteggio[i];
              tempcarta := i;
           end;
       end;
    end;
    CompGioca := tempcarta;
  end;
end;



procedure TGiocatore.Aggiorna;
          procedure Azzera( Image: TImage);
          begin
               Image.Picture.Graphic := nil;
          end;

var i : PNCarte;
begin
   for i := 1 to 3 do
      if ImageList.IndexOf(ImageMano[i]) >= 0 then begin
          if Mano[i] <> nil then MostraCartaProc(Mano[i]^,ImageMano[i])
                          else Azzera(ImageMano[i]);
            ImageList.Remove(ImageMano[i])
      end;
      if ImageList.IndexOf(ImageGiocata) >= 0 then begin
            if Giocata <> nil then Modifica(Giocata^,ImageGiocata)
                           else Azzera(ImageGiocata);
            ImageList.Remove(ImageGiocata);
      end;
      PunteggioLabel.Caption := InttoStr(Punteggio);
end;

end.






