unit uFeld;

interface


type
  TFelder = class
  private
    { Private-Deklarationen }
    Fzustand : integer; //gibt den Zustand an: 0=weiﬂ,frei 1=weiﬂ,benutzt 2=schwarz
    Fpositionx : integer; //Gibt die x-Position an
    Fpositiony : integer; //Gibt die y-Position an
    Fbetretbar : boolean; //Einmaliger nicht ‰nderbarer Status, ob das Feld betretbar ist #Sommer
  public
    { Public-Deklarationen }
    constructor erzeugen(status,x,y:integer);
    procedure setstatus(newstatus:integer);
    procedure setbetretbar(b:boolean);
    function getStatus:integer;
    function getbetretbar:boolean;
end;


implementation

constructor TFelder.erzeugen(status: Integer; x: Integer; y: Integer);
begin
  //Initialisierung der Variablen
  self.Fzustand:=status;
  self.Fpositionx:=x;
  self.Fpositiony:=y;
  self.Fbetretbar:=false; //true: wurde betreten
end;


///////////////GETTER UND SETTER////////////////////////////////////

procedure TFelder.setstatus(newstatus: Integer);
begin
  self.Fzustand:=newstatus;
end;

procedure TFelder.setbetretbar(b: Boolean);
begin
  self.Fbetretbar:=b;
end;

function TFelder.getStatus:integer;
begin
  result:=Fzustand;
end;

function TFelder.getbetretbar;
begin
  result:=Fbetretbar;
end;


end.
