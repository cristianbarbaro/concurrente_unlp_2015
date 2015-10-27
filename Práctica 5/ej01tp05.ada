TASK Puente is
  entry solicitarEntradaCamion();
  entry solicitarEntradaAuto();
  entry solicitarEntradaCamioneta();
  entry avisarSalidaCamion();
  entry avisarSalidaAuto();
  entry avisarSalidaCamioneta();
END Puente;

TASK BODY Puente IS
  cantAutos, cantCamionetas, cantCamiones integer := 0;
BEGIN
  loop
    SELECT
      WHEN ((cantAutos == 0) and (cantCamionetas == 0) and (cantCamiones == 0)) =>
        ACCEPT solicitarEntradaCamion() DO
          cantCamiones = 1;
        END solicitarEntradaCamion;
      OR WHEN ((cantAutos == 0) and (cantCamionetas < 2) and (cantCamiones == 0)) =>
        ACCEPT solicitarEntradaCamioneta() DO
          cantCamionetas = cantCamionetas + 1;
        END solicitarEntradaCamioneta;
      OR WHEN ((cantAutos < 3) and (cantCamionetas == 0) and (cantCamiones == 0) =>
        ACCEPT solicitarEntradaAuto() DO
          cantAutos = cantAutos + 1;
        END solicitarEntradaAuto;
      OR ACCEPT  avisarSalidaAuto() DO
        cantAutos = cantAutos - 1;
      END avisarSalidaAuto;
      OR ACCEPT avisarSalidaCamion() DO
        cantCamiones = cantCamiones - 1;
      END avisarSalidaCamion;
      ACCEPT avisarSalidaCamioneta() DO
        cantCamionetas = cantCamionetas - 1;
      END avisarSalidaCamioneta;
    END SELECT;
  end loop;
END Puente;


TASK Camioneta;
TASK BODY Camioneta IS
  Puente.solicitarEntradaCamioneta();
  "Atraviesa el puente";
  Puente.avisarSalidaCamioneta();
END Camioneta;

TASK Camion;
TASK BODY Camion IS
  Puente.solicitarEntradaCamion();
  "Atraviesa el puente";
  Puente.avisarSalidaCamion():
END Camion;

TASK Auto;
TASK BODY Auto IS
  Puente.solicitarEntradaAuto();
  "Atraviesa el puente";
  Puente.avisarSalidaAuto();
END Auto;
