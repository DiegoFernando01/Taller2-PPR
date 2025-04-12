% objetivo: maximizar la ganancia = (ingresos totales) - (costos totales).

include "globals.mzn";

% Parámetros
int: p;  % número de plantas
int: m;  % número de clientes
int: n;  % número de días

array[int] of string: plantNames;   % Nombres simbólicos
array[int] of string: clientNames;  % Nombres simbólicos
array[int] of float: cost;          % Costo por MW de cada planta
array[int] of int: capacity;        % Capacidad máxima de cada planta por día
array[int] of float: payment;       % Pago por MW para cada cliente
array[1..m,1..n] of int: demand;    % Demanda de cada cliente (filas) vs días (columnas)
float: G;  % porcentaje mínimo a cubrir, ej. 0.50 = 50%
array[int] of float: highThreshold;  % régimen alto en cada planta
array[int] of int: maxConsecutiveHigh; % días consecutivos permitido en régimen alto por planta

% Variables
array[1..p, 1..m, 1..n] of var 0..10000: X; % Cantidad de MW que la planta p produce para el cliente c en el día d
array[1..p,1..n] of var bool: isHigh; % si una planta p en día d está en régimen alto

% restricciones

constraint
  forall(p_ in 1..p, d in 1..n) (
    % 1) no exceder la capacidad diaria de la planta p_
    sum(c in 1..m)( X[p_, c, d] ) <= capacity[p_]
  )
  /\
  forall(c_ in 1..m, d in 1..n) (
    % 2) Cubrir al menos G% de la demanda de cada cliente c_ en día d
    sum(p_ in 1..p)( X[p_, c_, d] ) >= G * demand[c_, d]
    /\
    % no superar la demanda real
    sum(p_ in 1..p)( X[p_, c_, d] ) <= demand[c_, d]
  )
  /\
  forall(p_ in 1..p, d in 1..n) (
    % 3) Definir isHigh[p_, d] según si sobrepasa o no el umbral highThreshold[p_]
    isHigh[p_, d] <-> ( sum(c in 1..m)(X[p_, c, d]) > highThreshold[p_] * capacity[p_] )
  )
  /\
  forall(p_ in 1..p) (
    % 4) Prohibir exceder 'maxConsecutiveHigh[p_]' días consecutivos en régimen alto
    forall(d in 1..(n-1)) (
      if maxConsecutiveHigh[p_] = 1 then
        isHigh[p_, d] + isHigh[p_, d+1] <= 1
      else
        true
      endif
    )
  );

% función objetivo: Maximizar Ganancia.

% Ganancia = Ingresos - Costos
% Ingresos = sum(p, c, d)( X[p,c,d] * payment[c] )
% Costos   = sum(p, c, d)( X[p,c,d] * cost[p] )

var float: totalProfit = 
  sum(p_ in 1..p, c_ in 1..m, d in 1..n) (
    X[p_, c_, d] * payment[c_]
  )
  - 
  sum(p_ in 1..p, c_ in 1..m, d in 1..n) (
    X[p_, c_, d] * cost[p_]
  );

solve maximize totalProfit;

output [
  "Ganancia total = ", show(totalProfit), "\n",
  "Distribución (MW) por planta-cliente-día:\n",
  join("", 
    [ 
      "Planta: " ++ show(plantNames[p_]) ++ 
      ", Cliente: " ++ show(clientNames[c_]) ++ 
      ", Día: " ++ show(d) ++ 
      " -> " ++ show(X[p_,c_,d]) ++ "\n"
      | p_ in 1..p, c_ in 1..m, d in 1..n
    ]
  ),
  "\nRégimen alto por planta/día:\n",
  join("", 
    [
      "Planta: " ++ show(plantNames[p_]) ++
      ", Día: " ++ show(d) ++ 
      ", Régimen alto = " ++ show(isHigh[p_,d]) ++ "\n"
      | p_ in 1..p, d in 1..n
    ]
  )
];