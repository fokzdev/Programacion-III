Code.require_file("util.ex", __DIR__)

# ==============================================
#  CRUD DE ESTUDIANTES EN ELIXIR
#  Conceptos: Listas · Tuplas · Mapas · Enum
# ==============================================
# ==============================================

defmodule Main do

  # --------------------------------------------------
  # ESTADO: una lista de mapas (cada estudiante es un mapa)
  # %{ id: 1, nombre: "Ana", edad: 20, carrera: "Sistemas" }
  # --------------------------------------------------

  def iniciar do
    estudiantes = [
      %{id: 1, nombre: "Ana García",   edad: 20, carrera: "Sistemas"},
      %{id: 2, nombre: "Luis Pérez",   edad: 22, carrera: "Diseño"},
      %{id: 3, nombre: "Sofía Torres", edad: 21, carrera: "Sistemas"}
    ]

    menu(estudiantes)
  end

  # --------------------------------------------------
  #  MENÚ PRINCIPAL
  # --------------------------------------------------
  def menu(estudiantes) do
    Util.mostrar_mensaje("""
    \n========================================
       GESTIÓN DE ESTUDIANTES
    ========================================
    1. Ver todos
    2. Buscar por ID
    3. Agregar estudiante
    4. Editar estudiante
    5. Eliminar estudiante
    6. Estadísticas
    0. Salir
    ----------------------------------------
    """)

    case Util.ingresar("Elige una opción: ", :texto) do
      "1" -> ver_todos(estudiantes)
      "2" -> buscar(estudiantes)
      "3" -> agregar(estudiantes)
      "4" -> editar(estudiantes)
      "5" -> eliminar(estudiantes)
      "6" -> estadisticas(estudiantes)
      "0" ->
        Util.mostrar_mensaje("\n¡Hasta luego! 👋")
        System.halt(0)
      _ ->
        Util.mostrar_mensaje("Opción no válida.")
        menu(estudiantes)
    end
  end

  # --------------------------------------------------
  #  1. VER TODOS  — Enum.each + Enum.sort_by
  # --------------------------------------------------
  def ver_todos(estudiantes) do
    Util.mostrar_mensaje("\n--- LISTA DE ESTUDIANTES ---")

    # Enum.sort_by ordena la lista por el campo :id
    estudiantes
    |> Enum.sort_by(& &1.id)
    |> Enum.each(fn e ->
      Util.mostrar_mensaje("  [#{e.id}] #{e.nombre} | #{e.edad} años | #{e.carrera}")
    end)

    Util.mostrar_mensaje("Total: #{Enum.count(estudiantes)} estudiante(s)")
    menu(estudiantes)
  end

  # --------------------------------------------------
  #  2. BUSCAR POR ID  — Enum.find + tuplas {:ok} {:error}
  # --------------------------------------------------
  def buscar(estudiantes) do
    id = Util.ingresar("\nID a buscar: ", :entero)

    # Enum.find devuelve el primero que cumple la condición, o nil
    case Enum.find(estudiantes, fn e -> e.id == id end) do
      nil ->
        Util.mostrar_mensaje("❌ No se encontró el estudiante con ID #{id}.")

      estudiante ->
        Util.mostrar_mensaje("""
        \n✅ Encontrado:
           Nombre  : #{estudiante.nombre}
           Edad    : #{estudiante.edad}
           Carrera : #{estudiante.carrera}
        """)
    end

    menu(estudiantes)
  end

  # --------------------------------------------------
  #  3. AGREGAR  — Agregar mapa a la lista
  # --------------------------------------------------
  def agregar(estudiantes) do
    Util.mostrar_mensaje("\n--- AGREGAR ESTUDIANTE ---")

    # Generamos el próximo ID con Enum.max_by
    nuevo_id =
      case estudiantes do
        [] -> 1
        _  -> Enum.max_by(estudiantes, & &1.id).id + 1
      end

    nombre  = Util.ingresar("Nombre  : ", :texto)
    edad    = Util.ingresar("Edad    : ", :entero)
    carrera = Util.ingresar("Carrera : ", :texto)

    # Creamos un nuevo mapa y lo agregamos a la lista
    nuevo = %{id: nuevo_id, nombre: nombre, edad: edad, carrera: carrera}
    nueva_lista = estudiantes ++ [nuevo]

    Util.mostrar_mensaje("✅ Estudiante agregado con ID #{nuevo_id}.")
    menu(nueva_lista)
  end

  # --------------------------------------------------
  #  4. EDITAR  — Enum.map para reemplazar un elemento
  # --------------------------------------------------
  def editar(estudiantes) do
    Util.mostrar_mensaje("\n--- EDITAR ESTUDIANTE ---")
    id = Util.ingresar("ID del estudiante a editar: ", :entero)

    case Enum.find(estudiantes, fn e -> e.id == id end) do
      nil ->
        Util.mostrar_mensaje("❌ No encontrado.")
        menu(estudiantes)

      encontrado ->
        Util.mostrar_mensaje("""
        Datos actuales: #{encontrado.nombre} | #{encontrado.edad} años | #{encontrado.carrera}
        (Deja en blanco para no cambiar el campo)
        """)

        nombre   = Util.ingresar("Nuevo nombre  : ", :texto)
        edad_str = Util.ingresar("Nueva edad    : ", :texto)
        carrera  = Util.ingresar("Nueva carrera : ", :texto)

        # Actualizamos solo los campos que el usuario llenó
        actualizado = %{encontrado |
          nombre:  if(nombre   == "", do: encontrado.nombre,  else: nombre),
          edad:    if(edad_str == "", do: encontrado.edad,    else: String.to_integer(edad_str)),
          carrera: if(carrera  == "", do: encontrado.carrera, else: carrera)
        }

        # Enum.map recorre la lista y reemplaza el elemento con el ID correcto
        nueva_lista = Enum.map(estudiantes, fn e ->
          if e.id == id, do: actualizado, else: e
        end)

        Util.mostrar_mensaje("✅ Estudiante actualizado.")
        menu(nueva_lista)
    end
  end

  # --------------------------------------------------
  #  5. ELIMINAR  — Enum.reject para quitar un elemento
  # --------------------------------------------------
  def eliminar(estudiantes) do
    Util.mostrar_mensaje("\n--- ELIMINAR ESTUDIANTE ---")
    id = Util.ingresar("ID del estudiante a eliminar: ", :entero)

    case Enum.find(estudiantes, fn e -> e.id == id end) do
      nil ->
        Util.mostrar_mensaje("❌ No encontrado.")
        menu(estudiantes)

      encontrado ->
        confirmacion =
          Util.ingresar("¿Eliminar a #{encontrado.nombre}? (s/n): ", :texto)
          |> String.downcase()

        if confirmacion == "s" do
          # Enum.reject devuelve una nueva lista SIN los que cumplen la condición
          nueva_lista = Enum.reject(estudiantes, fn e -> e.id == id end)
          Util.mostrar_mensaje("✅ Estudiante eliminado.")
          menu(nueva_lista)
        else
          Util.mostrar_mensaje("Cancelado.")
          menu(estudiantes)
        end
    end
  end

  # --------------------------------------------------
  #  6. ESTADÍSTICAS  — Varias funciones de Enum
  # --------------------------------------------------
  def estadisticas(estudiantes) do
    Util.mostrar_mensaje("\n--- ESTADÍSTICAS ---")

    case estudiantes do
      [] ->
        Util.mostrar_mensaje("No hay estudiantes registrados.")

      _ ->
        total     = Enum.count(estudiantes)
        edad_prom = estudiantes |> Enum.map(& &1.edad) |> Enum.sum() |> div(total)
        mas_joven = Enum.min_by(estudiantes, & &1.edad)
        mas_mayor = Enum.max_by(estudiantes, & &1.edad)

        # Enum.group_by agrupa en un mapa de listas por carrera
        por_carrera = Enum.group_by(estudiantes, & &1.carrera)

        Util.mostrar_mensaje("""
        Total de estudiantes : #{total}
        Edad promedio        : #{edad_prom} años
        Más joven            : #{mas_joven.nombre} (#{mas_joven.edad} años)
        De mayor edad        : #{mas_mayor.nombre} (#{mas_mayor.edad} años)
        \nEstudiantes por carrera:
        """)

        # Enum.each sobre el mapa devuelto por group_by
        Enum.each(por_carrera, fn {carrera, lista} ->
          Util.mostrar_mensaje("  #{carrera}: #{Enum.count(lista)} estudiante(s)")
        end)
    end

    menu(estudiantes)
  end

end

# Punto de entrada
Main.iniciar()
