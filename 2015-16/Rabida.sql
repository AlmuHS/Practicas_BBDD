create or replace FUNCTION rallyCompletado (p_rally RALLY.nombre%type, p_piloto PILOTO.nombreP%type) 
  RETURN INTEGER IS
  
  num_tramos INTEGER;
  existe_piloto INTEGER;
  existe_rally INTEGER;
  no_existe_piloto EXCEPTION;
  no_existe_rally EXCEPTION;
  
  BEGIN
    
    SELECT COUNT(*) INTO existe_piloto
    FROM PILOTO
    WHERE nombreP=p_piloto;
    
    IF existe_piloto=0 THEN
      RAISE no_existe_piloto;
    END IF;
    
    SELECT COUNT(*) INTO existe_rally
    FROM RALLY
    WHERE nombre=p_rally;
    
    IF existe_rally=0 THEN
      RAISE no_existe_rally;
    END IF
    
    
  EXCEPTION
    WHEN no_existe_rally then
      return('No existe el rally ' || p_rally);
      
    WHEN no_existe_piloto then
      return('No existe el piloto ' || p_piloto);
  END