unit UMazzo;


interface
uses Sysutils, Global;
type

  TCartaString = String[3];
  TCarta = class(TObject)
         Seme : TSeme;
         Numero : TNumero;
         constructor Init(s: TSeme; n: TNumero);
         function toFileName : String;
         function Valore : integer;
         function piuAlta( c2: TCarta; giocaPerPrimo : Boolean) : boolean;
  end; { TCarta }
  PCarta = ^TCarta;
  TMazzo = class
  public
          Carte : array[TTallone] of TCarta;
          Tallone : TTallone;
          constructor Init;
          function pop : PCarta;
          procedure Mescola;
          function Count : TTallone;


  end; { TMazzo }
  var Mazzo : TMazzo;
      SemeBriscola : TSeme;



implementation

constructor TCarta.Init(s: TSeme; n: TNumero);
begin
     Seme := s;
     Numero := n;
end; { TCarta.Init }


constructor TMazzo.Init;
var SemeIterator : TSeme;
    NumeroIterator : TNumero;
    index : TTallone;
    Carta : Tcarta;
begin
    Tallone := 1;
    index := 1;
    for SemeIterator := Denari to Bastoni do
         for NumeroIterator := 1 to 10 do
             begin
                 Carta := TCarta.Init(SemeIterator,NumeroIterator);
                 Carte[index] := Carta;
                 inc(index);
             end;
end; { TMazzo.Init }

procedure TMazzo.Mescola;
var Carta1, Carta2: TCarta;
    c1,c2: TTallone;
    Scambi, i: integer;
begin
     Randomize;
     Scambi := 200+Random(100);
     for i := 1 to Scambi do begin
        c1 := 1+Random(40);
        c2 := 1+Random(40);
        Carta1 := Carte[c1];
        Carta2 := Carte[c2];
        Carte[c1] := Carta2;
        Carte[c2] := Carta1;
     end;
end; { TMazzo.Mescola }

function TMazzo.pop : PCarta;
begin
     pop := @Carte[Tallone];
     inc(Tallone);
end; { TMazzo.pop }

function TMazzo.count : TTallone;
begin
     count := 41 - Tallone;
end;  { TMazzo.count }

function TCarta.toFileName : String;
var nomeFile, CartaOut : String;
begin
     nomeFile := CurrentDir+'\'+Opzioni.CarteDir+'\';
     case Seme of
        Denari  : CartaOut := 'o';
        Coppe   : CartaOut := 'c';
        Spade   : CartaOut := 's';
        Bastoni : CartaOut := 'b';
   end;
   nomeFile := nomeFile+InttoStr(Numero)+CartaOut+'.bmp';
   toFileName := nomeFile;
end; { TCarta.toFileName }

function TCarta.piuAlta( c2: TCarta; giocaPerPrimo : Boolean) : boolean;
         function veroValore(tt : TNumero) : integer;
         begin
              veroValore := tt;
              if tt = 3 then
                 veroValore := 11;
              if tt = 1
                     then veroValore := 12
         end;
        
         begin
              if Seme = SemeBriscola then
                 if c2.Seme <> SemeBriscola then
                    piuAlta := true
                 else
                    if veroValore(Numero) > veroValore(c2.Numero) then
                       piuAlta := true
                    else
                        piuAlta := false
              else  { Basso non ha giocato Briscola }
                  if c2.Seme = SemeBriscola then
                     piuAlta := false
                  else { non vi sono briscole in campo }
                       if Seme <> c2.Seme then
                          piuAlta := giocaPerPrimo
                       else { carte dello stesso seme }
                           if veroValore(Numero) > veroValore(c2.Numero) then
                              piuAlta := true
                           else
                              piuAlta := false;

end;
function TCarta.Valore : integer;
begin
     Valore := 0;
     if Numero = 1 then Valore := 11;
     if Numero = 3 then Valore := 10;
     if Numero >= 8 then Valore := Numero - 6;
end;

end.
