/*
postgres=# select * from personaxes;
 codper | nomper  | graduacion | codper2
--------+---------+------------+---------
 p1     | kirk    | capitan    |
 p2     | spoke   | tenente    | p1
 p3     | maccoy  | coronel    | p2
 p4     | scott   | mayor      | p3
 p5     | chekov  | oficial    | p4
 p6     | ubura   | coronel    | p2
 p7     | ear     | oficial    | p4
 p8     | trio    | mayor      | p6
 p9     | prak    | oficial    | p8
 p10    | jono    | cabo       | p9
 p11    | word    | cabo       | p10
 p12    | vekor   | soldado    |
 p13    | divot   | soldado    | p11
 p14    | sovak   | soldado    | p11
 p15    | kor     | soldado    | p11
 p16    | tomalak | oficial    | p8
 p17    | ronin   | oficial    | p4
 p18    | devour  | soldado    | p11
 p19    | letek   | cabo       | p7
 p20    | ardor   | cabo       | p7
 p21    | solok   | soldado    | p20
 p29    | yuta    | cabo       | p7
 p22    | lag     | soldado    |
 p23    | kurn    | alferez    | p9
 p24    | comic   | alferez    | p9
 p25    | karnas  | coronel    | p2
 p26    | lian    | soldado    | p20
 p27    | lures   | soldado    | p19
 p28    | kamala  | soldado    |
 p30    | tagana  | soldado    | p19
 p31    | gilora  | soldado    | p19
 p32    | kraal   | soldado    | p19
 p33    | grilka  | soldado    | p19
 p34    | morn    | soldado    | p20
 p35    | garak   | soldado    |
 p36    | nog     | soldado    | p21
 p37    | rom     | soldado    | p21
 p38    | tiron   | soldado    | p21
 p39    | brunt   | soldado    | p21
 p41    | ducat   | soldado    | p21
 p42    | boogie  | soldado    | p21
 p43    | gull    | soldado    | p19
 p44    | quark   | soldado    | p19
 p45    | dax     | soldado    | p21
 p46    | sissy   | oficial    |
 p47    | kira    | oficial    | p4
(46 filas)

tlimitesol
impedir que una personaxe poda ter por xefe a un soldado (inserindo)

puntuacion: 2,5

insert into personaxes values ('p48','zira','soldado','p21');
'este personaxe non debe ter por xefe a un soldado'

insert into personaxes values ('p48','zira','soldado','p46');
'rexistro inserido'

*/

DROP FUNCTION tlimitesol() CASCADE;
CREATE FUNCTION tlimitesol()
    RETURNS TRIGGER
    LANGUAGE PLPGSQL
    AS 
$$  
DECLARE
fila record;
code record;
x integer;

BEGIN
x=0;
FOR fila IN SELECT * FROM personaxes WHERE graduacion='soldado' LOOP
	IF new.codper2 = fila.codper THEN
		x=1;
	END IF;
END LOOP;
IF x=0 THEN
	RAISE NOTICE 'rexistro inserido';
ELSE
	RAISE EXCEPTION 'este peronaxe non debe ter por sefe a un soldado';
END IF;
--END LOOP;
return new;
END;
$$;
CREATE TRIGGER tlimitesolt before INSERT ON personaxes for each row EXECUTE PROCEDURE tlimitesol();