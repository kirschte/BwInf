unit uKnoten;

interface

uses
  Classes, SysUtils, Forms, Graphics;

type
  TKnoteni = class
  private
    { Private-Deklarationen }
    Fwert: integer;
    Fzeiger: array of integer;
  public
    { Public-Deklarationen }
    constructor erzeuge(wertnew:integer);
    procedure fuegeZeigerhinzu(zeiger:integer);
    function getWert():integer;
    function getZeiger(i:integer): integer;
    function getZeigerlength(): integer;
  end;

implementation

constructor TKnoteni.erzeuge(wertnew: integer);
begin
  self.Fwert:=wertnew;
  setLength(self.Fzeiger,1);
end;

procedure TKnoteni.fuegeZeigerhinzu(zeiger:integer);
begin
  setlength(Fzeiger,length(Fzeiger)+1);
  Fzeiger[length(Fzeiger)-1]:=zeiger;
end;


function TKnoteni.getWert;
begin
  result:=Fwert;
end;

function TKnoteni.getZeiger(i:integer):integer;
begin
  result:=FZeiger[i];
end;

function TKnoteni.getZeigerlength;
begin
  result:=length(FZeiger)-1;
end;

end.

