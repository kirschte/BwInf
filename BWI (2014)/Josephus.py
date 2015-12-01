"""
( ) = noch nicht gemacht
(-) = teils gemacht
(x) = behoben

(–) Variablennamen ändern
(x) Kommentieren
(-) Brute-Forcer ergänzen"""#aktuell falsche Personenzahl (um zwei verschoben! → System hinter fehler) und irgendwas stimmt mit den Listen nicht!
"""
( ) Besten Wert Ausgabe
( ) Lösung für Teilnehmerzahl < Silbenzahl finden
"""
#die Auskommentierungen machen das Arbeiten leichter,
#werden in finaler Version natürlich entfernt!

#teilz = int(input("Gib die Teilnehmerzahl an: "))
teilz = 28
#silbenz = int(input("Gib die Silbenzahl an: "))
silbenz = 16
#teils = int(input("Wie vielter Teilnehmer: "))
teils=1

ls = []

#Nicht benötigte Funktion, die  fertige Liste generiert
"""def lisgen():
        ls = []
        for i in range(1,teilz+1):
                ls.append(i)
"""       

def josephus(ls, skip, numb):
        #Zähler wie oft das G-Kind sprach
        talk = 0
        #Zähler, als wievielter es drankam
        pos = 0

        #generiert die benötigte Liste
        ls = []
        for s in range(1,teilz+1):
                ls.append(s)

        #logisch, oder?
        while len(ls) > 1:
                
                pos = pos+1
                #habe ich abgeändert übernommen, idx ist derjenige der sich Kuchen holt.
                idx = skip % len(ls)
                if idx == 0:
                        idx = len(ls)
                #damit der "Anfangstote" fehlt
                idx -=1

                #hier ist meine Abfrage für den Zähler, an dem ich scheiter.
                #Wenn er davor ist, macht er einmal den Mund auf
                if ls.index(numb) < skip:
                        talk += 1
                        #Logik dahinter war: Wenn die Silbenzahl größer der restlichen Teilnehmerzahl ist
                        #macht er zweimal den Mund auf - stimmt aber leider nicht
                        if len(ls) < skip:
                                talk += 1
                else:
                        talk=talk

                #Der Kuchenholende fliegt aus der Liste
                a= ls.pop(idx)
                print(a)

                #Falls der Kuchenholende das G-Kind ist, mache folgendes
                if a == numb:
                        print("Rausgeflogen als",pos,"te Person")
                        print(talk,"mal gesprochen")
                        return

                #übernommen, ändert die Reihenfolge der Liste in die Reihenfolge der Aufsagenden um
                ls = ls[idx::]+ls[0:idx]
              
                
                        
                

#SCHROTT!!! Die Hauptfunktion, in der sich alles abspielz
"""
def josephus(ls, skip, numb): #Variablennamen werden noch geändert
        #damit der "Anfangstote" fehlt
        rgt = skip
        skip -= 1
        idx = skip
        #mein Zähler für den Rang der Person
        p = 0

        #die Funktion um jede Silbenzahl auszuprobieren
        for i in range(0,4):
                        p = 0
                        idx = rgt -1
                        #damit ich die benötigte Liste habe
                        ls = []
                        for s in range(1,teilz+1):
                                ls.append(s) 

                        #damit ich später die Ausgabe pro Doppelsilbenzahl unterscheiden kann
                        print("")
                        
                        while len(ls) > 1: #logisch, oder?
                                c = 1
                                #siehe zweite if-Abfrage für sinn
                                if i == 0:
                                        #s.o.
                                        c = 0

                                #logisch, oder?      
                                p = p+1

                                #muss gemacht werden, damit (normalerweise) die erste Person stimmt
                                if p == 1:
                                        
                                        #der (idx-c).te holt sich Kuchen
                                        a = ls.pop(idx-c)
                                        ls
                                        #damit anschließen die korrekte Person umgebracht wird
                                        idx = (idx + skip) % len(ls)
                                       
                                
                                                               
                                
                                        if a == teils:
                                                print(a)
                                                #wenn der Kuchenholende unser Kandidat ist, wird seine Position und die gesagte Doppelsilbenzahl ausgespuckt
                                                print("Rausgeflogen als ", p, "te Person bei", i,"Doppelsilben")
                                        else:
                                                print(a)
                                        
                                #für folgende Zeilen gilt: siehe bei "if p == 1:"
                                if p != 1:
                                        a = ls.pop(idx) 
                                        idx = (idx + skip) % len(ls)
                                        print(ls)
                        
                                        if a == teils:
                                                print("Rausgeflogen als ", p, "te Person bei",i,"Doppelsilben")
                                
                                        else:
                                                print(a)
"""                                

#führt die Hauptfunktion aus
josephus(ls,silbenz,teils)
