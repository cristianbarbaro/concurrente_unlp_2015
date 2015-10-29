TASK BaseDatos IS
  ENTRY escribir(IN dato: String);
  ENTRY leer(OUT dato: String);
  ENTRY finEscritura();
  ENTRY finLectura();
END BaseDatos;

TASK BODY BaseDatos IS
  integer cantLeyendo = 0;
BEGIN
  loop
    SELECT
      when (escribir'count == 0)  =>
        accept leer(OUT dato: String) do
          cantLeyendo = cantLeyendo + 1;
          dato = "Se lee de alguna manera y se le retorna";
        end escribir;
      or when (cantLeyendo == 0 ) =>
        accept escribir(IN dato: String) do
          "Se escribe en la base de datos el dato recibido";
        end escribir;
        accept finEscritura();   /* No voy a aceptar a nadie más hasta que el que escribe avise que finalizó.
      or accept finLectura() do
        cantLeyendo = cantLeyendo - 1;
      end finLectura;
  end loop;
END BaseDatos;


TASK TYPE Tipo1;

TASK TYPE BODY Tipo1 IS
  String dato = "";
BEGIN
  dato = crearDato();
  loop
    SELECT
      BaseDatos.escribir(dato);
      "El chaboncito escribe en la base de datos";
      BaseDatos.finEscritura();
      dato = "Crear más datos para el loco";
    OR DELAY 120
      delay(300);
    END SELECT;
  end loop;
END Tipo1;


TASK TYPE Tipo2;

TASK TYPE BODY Tipo2 IS
  String datoEscribir = "";
  String datoLectura = "";
BEGIN
  datoEscribir = crearDato();
  loop
    select BaseDatos.escribir(datoEscribir);   /*Este es el call del select, el otro es código común.
      BaseDatos.finEscritura();
      datoEscribir = crearDato();
    or delay 300
      select
        BaseDatos.leer(datoLectura);
        "Leo el dato que quiero. Luego aviso que termino. Esto le demanda tiempo.";
        BaseDatos.finLectura();
      or delay 300
        //No se hace absolutamente nada, debe volver a intentarlo.
      end select;
    end select;
  end loop;
END Tipo2;


TASK TYPE Tipo3;

TASK TYPE BODY Tipo3 IS
  String datoEscribir, datoLectura = "";
BEGIN
  datoEscribir = crearDato();
  loop
    select
      BaseDatos.leer(datoLectura);
      "Leo de la base de datos";
      BaseDatos.finLectura();
    else
      /* Al ejecutar el else, ya se asume que no se está seleccionando nada, por lo tanto es posible poner otro call.
      BaseDatos.escribir(datoEscribir);
      "Escribo en la bd.";
      BaseDatos.finEscritura();
      datoEscribir = crearDato();
    end select;
  end loop;
END Tipo3;

var tipos1: array(1..A) of Tipo1;
var tipos2: array(1..B) of Tipo2;
var tipos3: array(1..C) of Tipo3;

//Luego viene el programa principal. No tiene mucha importancia darle bola, ya que nadie llama a los tipos, no tienen entries calls.