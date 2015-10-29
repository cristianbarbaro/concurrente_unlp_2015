TASK Empleado IS
  entry atender();
END Empleado;

TASK BODY Empleado IS
  LOOP
    ACCEPT atender() DO
      "Atiende al cliente";
    end atender;
  END LOOP;
END Empleado;


Task TYPE Cliente IS
  entry id(int);
  entry estado(OUT estado: String);
END Cliente;

TASK TYPE BODY Cliente IS
  var int miID;
BEGIN
  ACCEPT id(in valor: int) DO
    miID = valor;
  end id;
  
  SELECT
    Empleado.atender();
  OR DELAY 600
    "El cliente se va";
  END SELECT;
END Cliente;


/* 
Asumo que hay N clientes.
Cuando tengo muchas tareas, necesito declarar a la tarea con un TYPE y luego meterlo en un arreglo, por ejemplo. Si tuviera un entry asociado,
lo llamaría como a un arreglo común. En este ejercicio no hay problema.
*/

VAR clientes: array(1..N) of Cliente;

/* Programa principal */
BEGIN 
  for i = 1..N
    personas(i).id(i)
  end for;
END

/*
Tener en cuenta un par de cosas:
1. Si ejecuto un entry call, este proceso queda bloqueado hasta que se finaliza el accept del que se llamó.
2. Si un proceso se va, se quita de la cola de los entries. De esta forma se hace la vida más fácil.
3. El or delay espera ese tiempo hasta que se atienda el entry call, sino ejecuta el código opcional (en este problema se va).
*/
