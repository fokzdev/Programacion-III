Code.require_file("util.ex", __DIR__)

defmodule Validador do
  @moduledoc """
  Validador de nombre de usuario para plataforma academica.

  Reglas de validacion:
  1. Debe tener entre 5 y 12 caracteres.
  2. Debe estar completamente en minuscula.
  3. No debe contener espacios.
  4. No debe contener @, #, $, %.
  5. Debe contener al menos una letra.

  El resultado final es:
  - {:ok, "Usuario valido"} cuando no hay errores.
  - {:error, "mensaje"} cuando falla una o varias reglas.
  """

  @doc """
  Punto de entrada del script.

  Solicita el usuario, lo valida y muestra la tupla de resultado.
  """
  def main do
    # Entrada del nombre de usuario.
    usuario = Util.ingresar("Ingrese nombre de usuario: ", :texto)

    # Resultado de la validacion.
    resultado = validar_usuario(usuario)

    # Salida en consola.
    Util.mostrar_mensaje("Resultado: #{inspect(resultado)}")
  end

  @doc """
  Ejecuta todas las validaciones encadenadas con pipe.

  Retorna:
  - {:ok, "Usuario valido"} si no hay errores.
  - {:error, "..."} con todas las reglas que fallaron.
  """
  def validar_usuario(usuario) do
    {_, errores} =
      {usuario, []}
      |> validar_longitud()
      |> validar_minusculas()
      |> validar_espacios()
      |> validar_especiales()
      |> validar_al_menos_una_letra()

    if errores == [] do
      {:ok, "Usuario valido"}
    else
      {:error, Enum.join(errores, " | ")}
    end
  end

  # Valida que la longitud este entre 5 y 12.
  defp validar_longitud({usuario, errores}) do
    longitud = String.length(usuario)

    if longitud < 5 or longitud > 12 do
      {usuario, errores ++ ["Debe tener entre 5 y 12 caracteres"]}
    else
      {usuario, errores}
    end
  end

  # Valida que todo el texto este en minuscula.
  defp validar_minusculas({usuario, errores}) do
    if usuario != String.downcase(usuario) do
      {usuario, errores ++ ["Debe estar completamente en minuscula"]}
    else
      {usuario, errores}
    end
  end

  # Valida que no existan espacios usando replace para comparar.
  defp validar_espacios({usuario, errores}) do
    sin_espacios = String.replace(usuario, " ", "")

    if sin_espacios != usuario do
      {usuario, errores ++ ["No debe contener espacios"]}
    else
      {usuario, errores}
    end
  end

  # Valida que no tenga caracteres especiales prohibidos.
  defp validar_especiales({usuario, errores}) do
    tiene_especial =
      String.contains?(usuario, "@") or
        String.contains?(usuario, "#") or
        String.contains?(usuario, "$") or
        String.contains?(usuario, "%")

    if tiene_especial do
      {usuario, errores ++ ["No debe contener @, #, $, %"]}
    else
      {usuario, errores}
    end
  end

  # Valida que exista al menos una letra (a-z o A-Z).
  defp validar_al_menos_una_letra({usuario, errores}) do
    tiene_letra =
      usuario
      |> String.to_charlist()
      |> Enum.any?(fn c -> (c >= ?a and c <= ?z) or (c >= ?A and c <= ?Z) end)

    unless tiene_letra do
      {usuario, errores ++ ["Debe contener al menos una letra"]}
    else
      {usuario, errores}
    end
  end
end

Validador.main()
