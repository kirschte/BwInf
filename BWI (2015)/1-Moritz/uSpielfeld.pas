unit uSpielfeld;

interface

uses
  Classes, uFeld, SysUtils, Forms, Graphics;

type
  TSpielfeld = class
  private
    { Private-Deklarationen }
    breite : integer; //Die Breite des Spielfeld
    hoehe : integer; //Die Hoehe des Spielfeld
    moeglich : boolean; //Gibt an, ob das Beteten aller weissen Felder moeglich ist
    loesung : boolean; //True=Loesung gefunden; False=noch keine gefunden/keine verfuegbar
    pfad : string;  //Gibt den Pfad im Format 'NWOONSO' o.ae. an
    Felder : array of array of TFelder; //dynamisches Array: x=breite; y=hoehe
    aktx : integer; //aktuelle x-Position der turtle
    akty : integer; //aktuelle y-Position der turtle
    schritte : extended; //gibt die Anzahl der Geh-Vorgaenge an s. Laufzeitoptimierung
    mehrmalsausgefuehrt : boolean; //false: einmal den Hamiltonalgorithmus ausgefuehrt; true: zweimal oder mehrmals ausgefuehrt
	Buffer  : TBitmap; //Puffer, wird zum Zeichnen an die Hauptklasse uebergeben
    Schwarz : TBitmap; //Bild eines schwarzen Stuecks im ResourceStream zum Zeichnen
    Turtle  : TBitmap; //Bild einer Schildkroete im ResourceStream zum Zeichnen
    vg      : integer; //Vergroesserungsfaktor, mit denen die Bilder skaliert werden --> es legt die Groesse des zu zeichnenden Feldes fest
    procedure erzeugeFelder(x,y,status:integer);
  public
    { Public-Deklarationen }
    constructor erzeuge(h,b:integer;SL:TStringList);
    procedure hamilton(direction:integer);
    function sommer():boolean;
    procedure zeichneFeld();
    procedure macherealeSchritte(); //Bei einem mehrmaligen Ausfuehren eines Feldes, wird der Hamiltonalgorithmus immer wieder ausgefuehrt, obwohl dies nicht notwendig ist, da einmal ausreicht, da alle errechneten Werte sich nicht aendern. Daher wird nach dem Ausfuehren des Algorithmus mehrmalsausgefuehrt=true gesetzt
    function getBuffer():TBitmap;
    function getloesung():boolean;
    function getpfad():string;
    function getschritte():extended;
  end;

implementation

constructor TSpielfeld.erzeuge(h,b:integer;SL:TStringList);
  procedure weissZeichnen(i,j:integer);
  begin
    Buffer.Canvas.MoveTo(j*(vg+1),i*(vg+1));
    Buffer.Canvas.LineTo(j*(vg+1),i*(vg+1)+vg);
    Buffer.Canvas.MoveTo(j*(vg+1),i*(vg+1));
    Buffer.Canvas.LineTo(j*(vg+1)+vg,i*(vg+1));
  end;
var i,j:integer;
begin
  //Initialisierung der Variablen
  breite:=b;
  hoehe:=h;
  moeglich:=false;
  pfad:='';
  vg:=30;
  loesung:=false;
  mehrmalsausgefuehrt:=false;
  setlength(Felder,breite+1,hoehe+1);
  zeichneFeld();
  for I := 1 to hoehe do begin
    for J := 1 to breite do begin
      if SL.Strings[i][j]='#' then begin
        erzeugeFelder(j,i,2);
        Buffer.Canvas.StretchDraw(rect(j*(vg+1),i*(vg+1),j*(vg+1)+vg,i*(vg+1)+vg),Schwarz);
      end;
      if SL.Strings[i][j]=' ' then begin
        erzeugeFelder(j,i,0);
        weissZeichnen(i,j);
      end;
      if SL.Strings[i][j]='K' then begin
        erzeugeFelder(j,i,1);
        Buffer.Canvas.StretchDraw(rect(j*(vg+1),i*(vg+1),j*(vg+1)+vg,i*(vg+1)+vg),Turtle);
        weissZeichnen(i,j);
        aktx:=j;
        akty:=i;
      end;
    end;
  end;
end;

procedure TSpielfeld.hamilton(direction: Integer);
var i,j:integer;weissda:boolean;
  procedure gehe(direction:integer);
  begin
    schritte:=schritte+1;
    if Felder[aktx,akty].getbetretbar=false then Felder[aktx,akty].setbetretbar(true);
    //Gehen
    if direction=0 then begin   //Gehe nach Norden
      akty:=akty-1;
      pfad:=pfad+'N';
    end;
    if direction=1 then begin   //Gehe nach Osten
      aktx:=aktx+1;
      pfad:=pfad+'O';
    end;
    if direction=2 then begin   //Gehe nach Sueden
      akty:=akty+1;
      pfad:=pfad+'S';
    end;
    if direction=3 then begin   //Gehe nach Westen
      aktx:=aktx-1;
      pfad:=pfad+'W';
    end;
    Felder[aktx,akty].setstatus(1);
    if Felder[aktx,akty].getbetretbar=false then Felder[aktx,akty].setbetretbar(true);
  end;
  function frei(direction:integer):boolean;
  begin
    result:=false;
    if direction=0 then begin
      if Felder[aktx,akty-1].getStatus=0 then result:=true; //true=frei; false=belegt
    end;
    if direction=1 then begin
      if Felder[aktx+1,akty].getStatus=0 then result:=true; //true=frei; false=belegt
    end;
    if direction=2 then begin
      if Felder[aktx,akty+1].getStatus=0 then result:=true; //true=frei; false=belegt
    end;
    if direction=3 then begin
      if Felder[aktx-1,akty].getStatus=0 then result:=true; //true=frei; false=belegt
    end;
  end;
  procedure gehezurueck(direction:string);
  begin
      Felder[aktx,akty].setstatus(0);
      if direction='N' then begin
        akty:=akty+1;
        Delete(pfad, Length(pfad), 1);
      end;
      if direction='O' then begin
        aktx:=aktx-1;
        Delete(pfad, Length(pfad), 1);
      end;
      if direction='S' then begin
        akty:=akty-1;
        Delete(pfad, Length(pfad), 1);
      end;
      if direction='W' then begin
        aktx:=aktx+1;
        Delete(pfad, Length(pfad), 1);
      end;
  end;
begin
  weissda:=false;
  if loesung=true then exit;  //Abbruch: Um Rechenleistung zu sparen, da das Checken nach dem frei sein, nichts mehr bringt s. Kommentar unten
  if mehrmalsausgefuehrt=true then exit; //Abbruch: Es aendert nichts den Algorithmus mehrmals auszufuehren
  if direction>=0 then gehe(direction);
  if frei(0)=true then hamilton(0); //Wenn im Norden frei ist, dann hamilton(north)
  if frei(1)=true then hamilton(1); //Wenn im Osten frei ist, dann hamilton(east)
  if frei(2)=true then hamilton(2); //Wenn im Sueden frei ist, dann hamilton(south)
  if frei(3)=true then hamilton(3); //Wenn im Westen frei ist, dann hamilton(west)
    for I := 1 to hoehe do begin
      for J := 1 to breite do begin
        if Felder[j,i].getStatus=0 then begin
          if weissda=false then begin
            if pfad<>'' then begin
              gehezurueck(pfad[length(pfad)]); //Wenn noch irgendwo ein weisses Feld ist, dann gehe zurueck und fahre dort fort
            end;
            weissda:=true;
         end;
        end;
      end;
    end;
  if weissda=false then loesung:=true else weissda:=false;   //sage mir den Pfad, wenn der richtige Weg gefunden wurde
end; //Wenn die Loesung gefunden wurde, dann wird nicht mehr zurueckgegangen, sodass dann keine unoetige Strecke gelaufen wird, obwohl schon eine Loesung existiert.

procedure TSpielfeld.erzeugeFelder(x: Integer; y: Integer; status: Integer);
begin
  Felder[x,y]:=TFelder.erzeugen(status,x,y);
end;

procedure TSpielfeld.zeichneFeld;
begin
  Schwarz:=TBitmap.Create;
  Schwarz.LoadFromResourceName(HInstance,'Black');
  Turtle:=TBitmap.Create;
  Turtle.LoadFromResourceName(HInstance,'Turtle');
  Turtle.Transparent:=true;
  Turtle.TransparentColor := Turtle.Canvas.Pixels[0, 0];

  ////////BUFFER////////
  Buffer:=TBitmap.Create;
  Buffer.Width:=round(Screen.Width);
  Buffer.Height:=round(Screen.Height*4/5);
end;

function TSpielfeld.sommer():boolean;
var i,j:integer;
begin
  hamilton(-1);
  for I := 1 to hoehe do begin
    for J := 1 to breite do begin
      if (Felder[j,i].getbetretbar=false) AND (Felder[j,i].getStatus<>2) then begin
        result:=false;
        exit;
      end else result:=true;
    end;
  end;
end;




//////////////GETTER UND SETTER///////////////////
procedure TSpielfeld.macherealeSchritte;
begin
  mehrmalsausgefuehrt:=true;
end;

function TSpielfeld.getBuffer:TBitmap;
begin
  result:=self.Buffer;
end;

function TSpielfeld.getloesung:boolean;
begin
  result:=self.loesung;
end;

function TSpielfeld.getpfad:string;
begin
  result:=self.pfad;
end;

function TSpielfeld.getschritte:extended;
begin
  result:=self.schritte;
end;

end.
