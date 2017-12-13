create or replace procedure penalizar(p_piloto IN PILOTO.nombreP%TYPE, p_rally IN RALLY.nombre%TYPE, p_penalizacion IN PARTICIPA.penalizacion%TYPE) IS

  existe_piloto INTEGER;
  no_existe_piloto EXCEPTION;
  existe_rally INTEGER;
  no_existe_rally EXCEPTION;
  
  CURSOR c_piloto IS
    SELECT P.nombreP, PA.penalizacion
    FROM RALLY R INNER JOIN PARTICIPA PA USING(codRally) INNER JOIN PILOTO P USING(codPiloto)
    WHERE R.nombre=p_rally;
      
  BEGIN

  SELECT COUNT(*) INTO existe_piloto
  FROM PILOTO P
  WHERE nombreP=p_piloto;
  
  IF existe_piloto = 0 THEN
    RAISE no_existe_piloto;
  END IF;
  
  SELECT COUNT(*) INTO existe_rally
  FROM RALLY R
  WHERE nombre=p_rally;
  
  IF existe_rally = 0 THEN
    RAISE no_existe_rally;
  END IF;
  
  dbms_output.put_line(' ' || p_rally || '  (Original)');
  dbms_output.put_line('------------------------------------');
  
  FOR r_piloto IN c_piloto LOOP
     dbms_output.put_line(r_piloto.nombreP || ' ' || c_piloto.penalizacion);
  END LOOP;
  
  
  EXCEPTION
    
    WHEN no_existe_rally then
      dbms_output.put_line('No existe el rally ' || p_rally);
      
    WHEN no_existe_piloto then
      dbms_output.put_line('No existe el piloto ' || p_piloto);            
END;
  
  
  
  
  