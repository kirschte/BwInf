unit uBaum;

interface

uses
  Classes, SysUtils, Forms, Graphics, Math, uKnoten;

type
  TBaumi = class
  private
    { Private-Deklarationen }
    FFlaschenanzahl:integer;
    FBehaelteranzahl:integer;
    Fzaehler:integer; //Zählt die möglichen Kombinationen
    FKnotenarray: array of TKnoteni; //Das dynamische Array, in der alle Knoten drin sind
    FAnzahldurchlaufendenKnoten:extended; //Anzahl der durchlaufenden Knoten
    FGesamtmaxVolumen: integer; //Das Volumen aller Behälter zusammengerechnet
    FmaxFlaschenInputproBehaelter: array of integer;  //Von dem letzten Behälter zu dem jeweiligen i-ten Behälter
    FBehaelterarray: array of integer;
  public
    { Public-Deklarationen }
    constructor erzeuge(Flaschenanzahl,Behaelteranzahl:integer;Behaelterarray: array of integer);
    procedure partition(rootKnoten:integer;wert:integer;stufe:integer);
    Procedure QuickSortRekursiv( l,r : Integer );
    function getzaehler():integer;
    function getKnotendurchlauf():extended;
  end;

implementation

constructor TBaumi.erzeuge(Flaschenanzahl: Integer; Behaelteranzahl: Integer; Behaelterarray: array of Integer);
var i,j,k:integer;
begin
  FFlaschenanzahl:=Flaschenanzahl;
  FBehaelteranzahl:=Behaelteranzahl;
  setlength(FBehaelterarray,length(Behaelterarray));
  for I := 0 to length(Behaelterarray) do begin
    FBehaelterarray[i]:=Behaelterarray[i];
  end;
  QuickSortRekursiv(0,length(FBehaelterarray)); //Sortieren aus Optimierungsgruenden
  FBehaelterarray[0]:=0;

  setlength(FKnotenarray,1);
  FKnotenarray[0]:=TKnoteni.erzeuge(0); //Wurzel des Baums; jeder Knoten bekommt einen Wert zugewiesen
  for i:=1 to FBehaelteranzahl do begin //fuer jede Stufe tue
    for j:=0 to FBehaelterarray[i] do begin //fuer jede moegliche Flaschenanzahl in dem i-ten Behaelter tue
      setlength(FKnotenarray,length(FKnotenarray)+1);
      FKnotenarray[length(FKnotenarray)-1]:=TKnoteni.erzeuge(j); //erzeuge einen neuen Knoten mit dem Wert
    end;
    for j:=0 to FBehaelterarray[i-1] do begin //und erstelle einen Zeiger von den Elternknoten zu dem neuen Knoten
      for k:=0 to FBehaelterarray[i] do begin
        FKnotenarray[length(FKnotenarray)-j-FBehaelterarray[i]-2].fuegeZeigerhinzu(length(FKnotenarray)-k-1); //auf alle Knoten einer Ebene darunter
      end;
    end;
  end;
  FGesamtmaxVolumen:= SumInt(FBehaelterarray);
  setlength(FmaxFlaschenInputproBehaelter,length(FBehaelterarray));
  for I:=0 to length(FBehaelterarray)-1 do begin //Erstelle das Array, wo man fuer jede Stufe die maximal moeglichen Flaschen, die unter dieser Stufe hineinpassen, herausfinden kann
    for J:=I+1 to length(FBehaelterarray)-1 do begin
      FmaxFlaschenInputproBehaelter[i]:=FmaxFlaschenInputproBehaelter[i]+FBehaelterarray[j];
    end;

  end;

end;

procedure TBaumi.partition(rootKnoten:integer;wert:integer;stufe:integer);
var i:integer;
begin
    FAnzahldurchlaufendenKnoten:=FAnzahldurchlaufendenKnoten+1;
    if wert=FFlaschenanzahl then begin Fzaehler:=Fzaehler+1; exit end; //Eine Kombination gefunden; braucht nicht mehr weiterzuschauen
    if wert>FFlaschenanzahl then exit; //zu gross --> braucht nicht mehr weiter suchen
    if FmaxFlaschenInputproBehaelter[stufe]+wert<FFlaschenanzahl then exit; //zu klein --> keine Kombination mehr moeglich

    for i:=1 to FKnotenarray[rootKnoten].getZeigerlength do begin
        partition(FKnotenarray[rootKnoten].getZeiger(i),FKnotenarray[FKnotenarray[rootKnoten].getZeiger(i)].getWert+wert,stufe+1)
    end;
end;





Procedure TBaumi.QuickSortRekursiv( l,r : Integer );
var i : Integer;
Function PartitionQuickSort( l,r : Integer ) : Integer;
var v,t,i,j : Integer;
Begin
  v:= FBehaelterarray[r];
  i:= l-1;
  j:= r;
  Repeat
    Repeat inc( i ); Until (FBehaelterarray[i] <= v);
    Repeat dec( j ); Until (FBehaelterarray[j] >= v);
    t:= FBehaelterarray[i]; FBehaelterarray[i]:= FBehaelterarray[j]; FBehaelterarray[j]:= t;
  Until (j<=i);

  FBehaelterarray[j]:= FBehaelterarray[i]; FBehaelterarray[i]:= FBehaelterarray[r]; FBehaelterarray[r]:= t;
  Result:= i;
End;
Begin
  If (r > l) Then
  Begin
    i:= PartitionQuickSort(l, r);
    QuickSortRekursiv( l, i-1 );
    QuickSortRekursiv( i+1, r );
  End;
End;


function TBaumi.getzaehler;
begin
  result:=Fzaehler;
end;

function TBaumi.getKnotendurchlauf;
begin
  result:=FAnzahldurchlaufendenKnoten;
end;



end.
