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


Task Cliente IS
  entry estado(OUT estado: String);
END Cliente;

TASK BODY Cliente IS
  SELECT
    Empleado.atender();
  OR DELAY 600
    "El cliente se va";
  END SELECT;
END Cliente;

/*
Tener en cuenta un par de cosas:
1. Si ejecuto un entry call, este proceso queda bloqueado hasta que se finaliza el accept del que se llamó.
2. Si un proceso se va, se quita de la cola de los entries. De esta forma se hace la vida más fácil.
3. El or delay espera ese tiempo hasta que se atienda el entry call, sino ejecuta el código opcional (en este problema se va).
*/
