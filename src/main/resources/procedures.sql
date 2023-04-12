DROP PROCEDURE IF EXISTS formazione;
DROP FUNCTION IF EXISTS controlla_partita;
DROP PROCEDURE IF EXISTS squadra_appartenenza;

DELIMITER $
CREATE PROCEDURE formazione (idsquadra integer unsigned, anno smallint)
BEGIN
 SELECT f.numero, g.nome, g.cognome
  FROM formazione f JOIN giocatore g ON (g.ID=f.ID_giocatore)
  WHERE f.anno=anno AND f.ID_squadra=idsquadra
  ORDER BY f.numero asc;
END$

CREATE PROCEDURE squadra_appartenenza
(IN idgiocatore integer unsigned, IN anno smallint,
OUT nome_squadra varchar(100))
BEGIN
 SELECT s.nome
  FROM squadra s
   JOIN formazione f ON (f.ID_squadra=s.ID)
  WHERE f.ID_giocatore=idgiocatore AND f.anno=anno
 INTO nome_squadra;
END$

CREATE FUNCTION controlla_partita(idpartita integer unsigned) 
 RETURNS varchar(100) DETERMINISTIC
BEGIN
 
 DECLARE risultato varchar(100);
 
 DECLARE punti CURSOR FOR SELECT f.ID_squadra, count(*) AS punti
  FROM segna e
   JOIN formazione f ON (e.ID_giocatore = f.ID_giocatore)
   JOIN partita p ON (p.ID = e.ID_partita)
   JOIN campionato c ON (c.ID = p.ID_campionato)
  WHERE p.ID=idpartita AND f.anno=c.anno
  GROUP BY f.ID_squadra;

 
 SET risultato = "ok";
 
 OPEN punti;

 
 controlli: BEGIN
 
  DECLARE ids1 integer unsigned;
  DECLARE ids2 integer unsigned;
  DECLARE ps1 integer unsigned;
  DECLARE ps2 integer unsigned;
  
  DECLARE pcs1 integer unsigned;
  DECLARE pcs2 integer unsigned;
  
  SET pcs1=0;
  SET pcs2=0;
  
  SELECT ID_squadra_1,punti_squadra_1,ID_squadra_2,punti_squadra_2
   FROM partita
   WHERE ID=idpartita
  INTO ids1,ps1,ids2,ps2;
  ricalcolo: BEGIN
   DECLARE ids integer unsigned;
   DECLARE pcs integer unsigned;
   DECLARE EXIT HANDLER FOR NOT FOUND BEGIN END;   
   LOOP
    FETCH punti INTO ids,pcs;
    IF (ids=ids1) THEN SET pcs1 = pcs;
    ELSEIF (ids=ids2) THEN SET pcs2 = pcs;
    ELSE BEGIN
     SET risultato = concat("La squadra ",(SELECT nome FROM squadra WHERE ID=ids)," ha segnato ",pcs," punti ma non risulta in partita");     
     LEAVE controlli;
     END;
    END IF;
   END LOOP;
  END;  
  IF (ps1<>pcs1) THEN SET risultato = concat("I punti della squadra ",(SELECT nome FROM squadra WHERE ID=ids1),
  " sono ",pcs1," ma la tabella partita riporta ", ps1);
  ELSEIF (ps2<>pcs2) THEN SET risultato = concat("I punti della squadra ",(SELECT nome FROM squadra WHERE ID=ids2),
  " sono ",pcs2," ma la tabella partita riporta ", ps2);
  END IF;
 END; 
 CLOSE punti; 
 RETURN risultato;
END$
DELIMITER ;