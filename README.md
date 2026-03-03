<div align="center">

# Programacion III
### Ejercicios de Elixir - Programacion 3

<p>
  <img src="https://img.shields.io/badge/Elixir-4B275F?style=for-the-badge&logo=elixir&logoColor=white" alt="Elixir" />
  <img src="https://img.shields.io/badge/Estado-En%20progreso-0A66C2?style=for-the-badge" alt="Estado" />
  <img src="https://img.shields.io/badge/Nivel-Basico-1F6FEB?style=for-the-badge" alt="Nivel" />
</p>

</div>

---

## Sobre este repositorio
Coleccion de ejercicios practicos en **Elixir** para la materia **Programacion III**.

Aqui se practican conceptos base de programacion funcional:
- entrada y salida por consola
- validaciones por reglas
- funciones privadas y publicas
- uso de `if`, `case`, `cond` y guardas (`when`)
- composicion con `pipe` (`|>`)

---

## Ejercicios incluidos

| Archivo | Descripcion | Conceptos clave |
|---|---|---|
| `Ejercicios/saludador.exs` | Saludo segun la hora actual del sistema. | `cond`, fecha/hora local, interpolacion |
| `Ejercicios/validador.exs` | Valida nombre de usuario con varias reglas acumuladas. | pipelines, acumulacion de errores, tuplas |
| `Ejercicios/parqueadero.exs` | Calcula tarifa base y descuentos de parqueadero. | guardas, `case`, `cond`, calculo de porcentajes |
| `Ejercicios/util.ex` | Funciones auxiliares para entrada y salida en consola. | reutilizacion de codigo, conversion de tipos |

---

## Como ejecutar
Requisitos:
- Tener **Elixir** instalado (`elixir -v`)

Comandos (desde la raiz del repositorio):

```bash
elixir Ejercicios/saludador.exs
elixir Ejercicios/validador.exs
elixir Ejercicios/parqueadero.exs
```

---

## Estructura del proyecto

```text
Programacion III/
├── README.md
└── Ejercicios/
    ├── util.ex
    ├── saludador.exs
    ├── validador.exs
    └── parqueadero.exs
```

---

## Objetivo academico
Fortalecer logica de programacion en Elixir mediante ejercicios secuenciales y validaciones de datos orientadas a consola.

---

<div align="center">
  Hecho por Juan Jose Marin con Elixir para Programacion III
</div>
