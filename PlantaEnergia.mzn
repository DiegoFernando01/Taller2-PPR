% PlantaEnergia.mzn

include "globals.mzn";

% PARÁMETROS
int: np; % número de plantas
int: nc; % número de clientes
int: nd; % número de días

array[1..np] of string: nombrePlanta;
array[1..nc] of string: nombreCliente;

array[1..np] of float: costo; % costo por MW de cada planta
array[1..np] of int: cap; % capacidad máxima (MW) de cada planta por día
array[1..nc] of float: pago; % pago por MW de cada cliente
array[1..nc,1..nd] of int: dem; % demanda de cada cliente c en el día d

float: G; % porcentaje mínimo de cobertura (0.0 - 1.0)
array[1..np] of float: umbralAlto; % umbral para régimen alto (0.0 - 1.0) por planta
array[1..np] of int: maxDiasAlto; % máx. días consecutivos en alto por planta

% DOMINIOS
int: capMax = max(i in 1..np)(cap[i]);  % capacidad máxima global
% capacidad total disponible por día
array[1..nd] of int: capDiaria = [ sum(pl in 1..np)(cap[pl]) | d in 1..nd ];
% produccion[planta, cliente, día]
array[1..np,1..nc,1..nd] of var 0..capMax: prod;
% alto[planta, día] = 1 si está en régimen alto
array[1..np,1..nd] of var bool: alto;

% RESTRICCIONES
constraint
  % 1) Capacidad diaria de planta
  forall(pl in 1..np, d in 1..nd) (
    sum(c in 1..nc)( prod[pl,c,d] ) <= cap[pl]
  )
  /\
  % 2) Cobertura total o mínimo G%
  forall(c in 1..nc, d in 1..nd) (
    if capDiaria[d] < dem[c,d] then
      % no alcanza para cubrir toda la demanda
      sum(pl in 1..np)( prod[pl,c,d] ) >= G * dem[c,d]
    else
      % sí alcanza, cubrir exactamente
      sum(pl in 1..np)( prod[pl,c,d] ) == dem[c,d]
    endif
  )
  /\
  % 3) Definir régimen alto según umbral
  forall(pl in 1..np, d in 1..nd) (
    alto[pl,d] <-> ( sum(c in 1..nc)( prod[pl,c,d] ) > umbralAlto[pl] * cap[pl] )
  )
  /\
  % 4) Ventana deslizante: no más de maxDiasAlto días consecutivos en alto
  forall(pl in 1..np) (
    forall(inicio in 1..nd - maxDiasAlto[pl]) (
      sum(d in inicio..inicio + maxDiasAlto[pl]) ( bool2int(alto[pl,d]) )
        <= maxDiasAlto[pl]
    )
  );

% FUNCIÓN OBJETIVO
var float: ganancia =
  sum(pl in 1..np, c in 1..nc, d in 1..nd)( prod[pl,c,d] * pago[c] )
  -
  sum(pl in 1..np, c in 1..nc, d in 1..nd)( prod[pl,c,d] * costo[pl] );

% ESTRATEGIAS DE BÚSQUEDA

% Estrategia 0: por defecto
solve maximize ganancia;

% Estrategia 1: heurística first_fail + indomain_min
% solve :: int_search([prod[pl,c,d] | pl in 1..np, c in 1..nc, d in 1..nd], first_fail, indomain_min, complete) maximize ganancia;

% Estrategia 2: orden de entrada + indomain_max
% solve :: int_search([prod[pl,c,d] | pl in 1..np, c in 1..nc, d in 1..nd], input_order, indomain_max, complete) maximize ganancia;

% IMPRESIÓN EN CONSOLA
output [
  "===== Resultado de la optimización =====\n",
  "Ganancia total: ", show(ganancia), "\n\n",
  "--- Producción total por planta y día ---\n",
  concat([ "Día " ++ show(d) ++ ":\n" ++
           concat([ nombrePlanta[pl] ++ ": " ++ show(sum(c in 1..nc)(prod[pl,c,d])) ++ " MW\n" | pl in 1..np ]) ++ "\n"
         | d in 1..nd ]),
  "--- Detalle producción planta->cliente->día ---\n",
  concat([ nombrePlanta[pl] ++ "->" ++ nombreCliente[c] ++
           " (Día " ++ show(d) ++ "): " ++ show(prod[pl,c,d]) ++ "\n"
         | pl in 1..np, c in 1..nc, d in 1..nd ]),
  "\n--- Régimen alto por planta y día ---\n",
  concat([ "Día " ++ show(d) ++ " - " ++ nombrePlanta[pl] ++ ": " ++ show(alto[pl,d]) ++ "\n"
         | d in 1..nd, pl in 1..np ])
];
