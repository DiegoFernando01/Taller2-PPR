TALLER 2 - OPTIMIZACIÓN DE PLANTAS DE ENERGÍA
==========================================================

UNIVERSIDAD DEL VALLE
Escuela de Ingeniería de Sistemas y Computación
Programación con Restricciones
Semestre: 2025-I
Profesor: Robinson Andrey Duque Agudelo Ph.D.

AUTORES:
- Diego Fernando Victoria (202125877) - diego.victoria@correounivalle.edu.co
- Janiert Sebastián Salas (201941265) - janiert.salas@correounivalle.edu.co
- Jhon Alexander Valencia (202042426) - jhon.hilamo@correounivalle.edu.co

DESCRIPCIÓN DEL PROYECTO:
------------------------
Este repositorio contiene la solución al taller 2 de Programación por Restricciones, 
que aborda un problema de optimización para plantas de energía. El modelo busca 
maximizar las ganancias en la generación y distribución de energía considerando 
diferentes tipos de plantas (nuclear, hidroeléctrica, térmica), sus costos, 
capacidades, y las demandas de múltiples clientes durante varios días.

OBJETIVOS:
---------
- Maximizar la ganancia total entre la venta de energía y los costos de producción
- Satisfacer la demanda de los clientes (total o parcialmente según capacidad)
- Respetar restricciones operacionales de las plantas energéticas

ARCHIVOS INCLUIDOS:
-----------------
1. PlantaEnergia.mzn: Modelo principal de optimización en MiniZinc.
2. Datos.dzn: Archivo de datos principal para probar el modelo.
3. Pruebas/: Carpeta que contiene 10 escenarios de prueba diferentes:
   - Prueba1.dzn: Escenario básico - 2 plantas térmicas, 2 clientes, 3 días
   - Prueba2.dzn - Prueba5.dzn: Complejidad incremental con variación de parámetros
   - Prueba6.dzn - Prueba10.dzn: Escenarios más complejos con más plantas, clientes y días
4. README.MD: Documentación detallada del proyecto en formato Markdown.

MODELO IMPLEMENTADO:
------------------
El modelo está implementado en MiniZinc (PlantaEnergia.mzn) y considera:

- Variables y Parámetros Principales:
  * Plantas: Número de plantas con sus tipos, costos y capacidades
  * Clientes: Número de clientes con sus demandas y pagos
  * Días: Horizonte temporal para la planificación
  * Variables de Decisión: Producción de cada planta para cada cliente en cada día

- Restricciones Principales:
  1. Capacidad diaria: Cada planta tiene un límite máximo de producción
  2. Cobertura mínima: Se debe satisfacer al menos un porcentaje G de la demanda
  3. Régimen alto: Control sobre días consecutivos de alta producción
  4. Demanda: No exceder la demanda de cada cliente

- Función Objetivo:
  Maximizar la ganancia total: ingresos por venta de energía menos costos de producción

INSTRUCCIONES DE USO:
-------------------
Para ejecutar el modelo, es necesario tener instalado MiniZinc IDE (versión 2.6 o superior).

1. Abrir MiniZinc IDE
2. Cargar el archivo PlantaEnergia.mzn
3. Seleccionar un archivo de datos .dzn de la carpeta Pruebas/
4. Ejecutar la solución

La consola mostrará:
- La ganancia total optimizada
- Detalles de producción por planta, cliente y día
- Estado de régimen alto para cada planta en cada día

ENLACES IMPORTANTES:
------------------
- Documentación oficial de MiniZinc: https://www.minizinc.org/documentation.html
- Informe en Google Docs: https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?usp=sharing

Para información más detallada sobre el proyecto, consultar el archivo README.md