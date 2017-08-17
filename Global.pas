unit Global;

interface
uses Graphics, extctrls, forms;

type

   TSeme = ( Denari, Coppe, Spade, Bastoni );
   PNCarte = 1..3;
   TNumero = 1..10;
   TTallone = 1..40;
   TLivello = 0..3;
   Topzione = record
              MostraPunti : Boolean;
              TimerDelay : longint;
              Scoperte : boolean;
              Musica : boolean;
              Difficolta : TLivello;
              Colore : TColor;
              CarteDir : String;
              SelectedProfile : String;
              end;
   TTocca = (Basso, Alto);
   TMano = array[PNCarte] of TImage;
   TProfile = record
            FIXED_BRISCOLA_PENALTY : real;
            VARIANT_BRISCOLA_PENALTY : real;
            VARIANT_CARICO_PENALTY : real;
            VARIANT_STROZZO_PENALTY : real;
            FIXED_TRE_PENALTY : real;
            VARIANT_WINNING_CARD_PENALTY : real;
            FIXED_WINNER_BRISCOLA_PENALTY : real;
            VARIANT_WINNER_BRISCOLA_PENALTY : real;
            FIXED_LOSER_BRISCOLA_PENALTY : real;
            VARIANT_LOSER_BRISCOLA_PENALTY : real;
            VARIANT_PASSIVE_STROZZO_PENALTY : real;
            ASSO_PENALTY : real;
   end;

var
   
  perPrimo, deveGiocare : TTocca;
   PartitaPrimo : TTocca;
   Opzioni : Topzione = (
           MostraPunti : False;
           TimerDelay : 1000;
           Scoperte : False;
           Musica : True;
           Difficolta :2;
           Colore : clGreen;
           CarteDir : 'Trevisane';
   );
   Graziano, Franco, Piero, Valerio, CurrentProfile : TProfile;
   CurrentDir        : String;
   isOpen            : Boolean;
  
function OtherPlayer(ct : TTocca) : TTocca;
procedure SetProfiles;

implementation
function OtherPlayer(ct : TTocca) : Ttocca;
begin
     if ct = Alto then OtherPlayer := Basso;
     if ct = Basso then OtherPlayer := Alto;
end;

procedure SetProfiles;
begin
     with Valerio do begin
       FIXED_BRISCOLA_PENALTY := 3;
       VARIANT_BRISCOLA_PENALTY := 0.7;
       VARIANT_CARICO_PENALTY := 0.045;
       VARIANT_STROZZO_PENALTY := 0.45;
       FIXED_TRE_PENALTY := 2.5;
       VARIANT_WINNING_CARD_PENALTY := 0.6;
       FIXED_WINNER_BRISCOLA_PENALTY := 4;
       VARIANT_WINNER_BRISCOLA_PENALTY := 1.2;
       FIXED_LOSER_BRISCOLA_PENALTY := 5.5;
       VARIANT_LOSER_BRISCOLA_PENALTY := 1.6;
       VARIANT_PASSIVE_STROZZO_PENALTY := 0.18;
       ASSO_PENALTY := 1.5;
     end;

     with Graziano do begin
       FIXED_BRISCOLA_PENALTY := 2;
       VARIANT_BRISCOLA_PENALTY := 0.8;
       VARIANT_CARICO_PENALTY := 0.065;
       VARIANT_STROZZO_PENALTY := 0.30;
       FIXED_TRE_PENALTY := 1.5;
       VARIANT_WINNING_CARD_PENALTY := 0.5;
       FIXED_WINNER_BRISCOLA_PENALTY := 3;
       VARIANT_WINNER_BRISCOLA_PENALTY := 1.1;
       FIXED_LOSER_BRISCOLA_PENALTY := 4.5;
       VARIANT_LOSER_BRISCOLA_PENALTY := 1.4;
       VARIANT_PASSIVE_STROZZO_PENALTY := 0.1;
       ASSO_PENALTY := 1;
     end;

     with Piero do begin
       FIXED_BRISCOLA_PENALTY := 2+Random(3);
       VARIANT_BRISCOLA_PENALTY := 0.5 + Random/3;
       VARIANT_CARICO_PENALTY := 0.045 + Random/20;
       VARIANT_STROZZO_PENALTY := 0.3 + Random/5;
       FIXED_TRE_PENALTY := 1 +Random(2);
       VARIANT_WINNING_CARD_PENALTY := 0.5+Random/4;
       FIXED_WINNER_BRISCOLA_PENALTY := 3+Random(2);
       VARIANT_WINNER_BRISCOLA_PENALTY := 0.9+Random;
       FIXED_LOSER_BRISCOLA_PENALTY := 5+Random(2);
       VARIANT_LOSER_BRISCOLA_PENALTY := 0.8+Random/2;
       VARIANT_PASSIVE_STROZZO_PENALTY := 0.15+Random/10;
       ASSO_PENALTY := 1+Random;
     end;
     with Franco do begin
       FIXED_BRISCOLA_PENALTY := 4.5;
       VARIANT_BRISCOLA_PENALTY :=0.5;
       VARIANT_CARICO_PENALTY := 0.085;
       VARIANT_STROZZO_PENALTY := 0.50;
       FIXED_TRE_PENALTY := 3;
       VARIANT_WINNING_CARD_PENALTY := 0.7;
       FIXED_WINNER_BRISCOLA_PENALTY := 5;
       VARIANT_WINNER_BRISCOLA_PENALTY := 1;
       FIXED_LOSER_BRISCOLA_PENALTY := 6;
       VARIANT_LOSER_BRISCOLA_PENALTY := 1.2;
       VARIANT_PASSIVE_STROZZO_PENALTY := 0.23;
       ASSO_PENALTY := 2;
     end;
     CurrentProfile := Valerio;
     Opzioni.selectedProfile := 'Valerio';
  end;


end.
