<p align='center'>
  <img width='200' heigth='225' src='https://user-images.githubusercontent.com/62605744/171186764-43f7aae0-81a9-4b6e-b4ce-af963564eafb.png'>
</p>

# 🔌 Solución Taller 2 - Optimización de Plantas de Energía

## 🎓 Universidad del Valle - Escuela de Ingeniería de Sistemas y Computación

- **Asignatura:** Programación por Restricciones
- **Semestre:** 2025-I
- **Profesor:** Robinson Andrey Duque Agudelo Ph.D.

---

## 📚 Descripción del Proyecto

Este repositorio contiene la solución al taller 2 de Programación por Restricciones, que aborda un problema de optimización para plantas de energía. El modelo busca maximizar las ganancias en la generación y distribución de energía considerando diferentes tipos de plantas (nuclear, hidroeléctrica, térmica), sus costos, capacidades, y las demandas de múltiples clientes durante varios días.

### 🎯 Objetivos

- Maximizar la ganancia total entre la venta de energía y los costos de producción
- Satisfacer la demanda de los clientes (total o parcialmente según capacidad)
- Respetar restricciones operacionales de las plantas energéticas

---

## 🧑‍💻 Autores

| Nombre                  | Código    | Email                                |
| ----------------------- | --------- | ------------------------------------ |
| Diego Fernando Victoria | 202125877 | diego.victoria@correounivalle.edu.co |
| Janiert Sebastián Salas | 201941265 | janiert.salas@correounivalle.edu.co  |
| Jhon Alexander Valencia | 202042426 | jhon.hilamo@correounivalle.edu.co    |

---

## 📁 Documentación

El informe completo se encuentra disponible en [Google Docs](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?usp=sharing) con acceso exclusivo a correos de la Universidad del Valle. A continuación, enlaces a las secciones específicas:

1. [Introducción](#introducción)
2. [Modelo](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?tab=t.0#heading=h.zeafqmcibwx4)
3. [Parámetros](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?tab=t.0#heading=h.vcuakzs0bh7h)
4. [Variables](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?tab=t.0#heading=h.y14l5layk44a)
5. [Restricciones](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?tab=t.0#heading=h.2qaf7qaoydf8)
6. [Estrategias de búsqueda](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?tab=t.0#heading=h.fanm44rs2g3c)
7. [Pruebas](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?tab=t.0#heading=h.gdb2pcv0qlke)
8. [Conclusión](https://docs.google.com/document/d/1Pcro3WCFTMGUZctdJmgVwsq0c68rhdDTeCZxERA7cCA/edit?tab=t.0#heading=h.a3qfjbmcupt7)

---

## 📘 Introducción <a name="introducción"></a>

Este proyecto aborda un problema de optimización de producción y distribución de energía donde múltiples plantas con diferentes características (nuclear, hidroeléctrica, térmica) deben abastecer a varios clientes durante un período de tiempo determinado.

### 🌟 Características Principales <a name="caracteristicas"></a>

- Múltiples tipos de plantas con diferentes costos y capacidades
- Restricción de régimen de operación alto limitado a ciertos días consecutivos
- Cobertura mínima garantizada de la demanda de cada cliente
- Optimización de ganancias considerando costos de producción y pagos de clientes

---

## 💻 Modelo Implementado <a name="modelo-implementado"></a>

El modelo está implementado en MiniZinc (`PlantaEnergia.mzn`), un lenguaje de modelado para problemas de optimización con restricciones.

### 📊 Variables y Parámetros Principales <a name="parametros"></a>

- **Plantas**: Número de plantas con sus tipos, costos y capacidades
- **Clientes**: Número de clientes con sus demandas y pagos
- **Días**: Horizonte temporal para la planificación
- **Variables de Decisión**: Producción de cada planta para cada cliente en cada día
- **Restricciones**: Capacidad, cobertura mínima, regulación de régimen alto

### 🔍 Restricciones Principales <a name="restricciones"></a>

1. **Capacidad diaria**: Cada planta tiene un límite máximo de producción
2. **Cobertura mínima**: Se debe satisfacer al menos un porcentaje G de la demanda
3. **Régimen alto**: Control sobre días consecutivos de alta producción
4. **Demanda**: No exceder la demanda de cada cliente

---

## 🧪 Escenarios de Prueba <a name="escenarios-de-prueba"></a>

Se incluyen 10 escenarios de prueba con diferentes configuraciones:

- **Prueba 1**: Escenario básico - 2 plantas térmicas, 2 clientes, 3 días
- **Prueba 2-5**: Complejidad incrementada con variación de parámetros
- **Prueba 6-10**: Escenarios más complejos con más plantas, clientes y días

Los archivos de datos (`.dzn`) contienen los parámetros específicos para cada escenario.

---

## 🛠️ Instalación y Uso <a name="instalacion"></a>

1. **Requisitos previos**:

   - MiniZinc IDE
   - Git (opcional, para clonar el repositorio)

2. **Obtener el código**:

   ```bash
   git clone https://github.com/DiegoFernando01/Taller2-PPR.git
   ```

   ```bash
   cd Taller2-PPR
   ```

3. **Ejecutar el modelo**:

   - Abrir MiniZinc IDE
   - Cargar el archivo `PlantaEnergia.mzn`
   - Seleccionar un archivo de datos `.dzn` de la carpeta `Pruebas/`
   - Ejecutar la solución

4. **Interpretar resultados**:
   - La consola mostrará la ganancia total optimizada
   - Detalles de producción por planta, cliente y día
   - Estado de régimen alto para cada planta en cada día

---

## 📊 Resultados <a name="resultados"></a>

Los resultados varían según el escenario de prueba, pero generalmente muestran:

- **Ganancia óptima**: El valor maximizado de la función objetivo
- **Producción**: Cantidad de energía producida por cada planta para cada cliente
- **Estados operativos**: Cuándo cada planta opera en régimen alto

## 📚 Referencias <a name="referencias"></a>

- [Documentación oficial de MiniZinc](https://www.minizinc.org/)
- Material del curso de Programación por Restricciones, Universidad del Valle (2025-I)

---

## 📜 Licencia

Este proyecto está bajo la Licencia MIT.

---
