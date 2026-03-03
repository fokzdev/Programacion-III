Code.require_file("util.ex", __DIR__)

defmodule Saludador do
  @moduledoc """
  Programa simple de saludo por franja horaria.

  Flujo general:
  1. Solicita el nombre del usuario.
  2. Obtiene la hora local del sistema.
  3. Define el saludo con `cond`:
     - Antes de las 12: "Buenos dias"
     - Antes de las 18: "Buenas tardes"
     - En otro caso: "Buenas noches"
  4. Construye y muestra el mensaje final.

  El programa termina justo despues de imprimir el saludo.
  """

  @doc """
  Punto de entrada del script.

  Lee el nombre, calcula el saludo segun la hora y lo imprime.
  """
  def main do
    # Entrada del nombre del usuario.
    nombre = Util.ingresar("Ingrese su nombre: ", :texto)

    # Se extrae la hora actual del sistema local.
    {{_, _, _}, {hora, _, _}} = :calendar.local_time()

    # Seleccion del saludo segun la hora.
    saludo = cond do
      hora < 12 -> "Buenos dias"
      hora < 18 -> "Buenas tardes"
      true -> "Buenas noches"
    end

    # Se genera y muestra el mensaje final.
    generar_mensaje(saludo, nombre)
    |> Util.mostrar_mensaje()
  end


  defp generar_mensaje(saludo, nombre) do
    "#{saludo} #{nombre}"
  end
end

Saludador.main()
