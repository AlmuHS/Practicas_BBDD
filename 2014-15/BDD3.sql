set serveroutput on;

create or replace
procedure hola(nombre varchar) is
begin
	dbms_output.put_line('Hola' || nombre);
end;


1.

	set serveroutput on;
	
	create
	function facturacion(telefono TELEFONO.numero%type, año INTEGER)
		return NUMBER;	
		numero_no_existe EXCEPTION;
		facturacion_minima EXCEPTION;		
		
		begin
			
		EXCEPTION
			WHEN numero_no_existe then 
				dbms_output.put_line('El numero ' || telefono || ' no existe en la base de datos');
				return -1;
			WHEN facturacion_minima then
				dbms_output.put_line('La facturacion de ' || telefono || ' es menor a 1 euro');
				return -1;
	end;


	select sum()
	from Telefono Tlf INNER JOIN Llamada L INNER JOIN Tarifa T
	where extract(year from fecha_hora)=año and numero=telefono
