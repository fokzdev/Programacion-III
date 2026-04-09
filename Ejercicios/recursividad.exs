Code.require_file("util.ex", __DIR__)

defmodule Recursividad do
  @moduledoc """
  Ejercicios simples de recursividad.
  """

  @doc """
  Punto de entrada con ejemplos cortos.
  """
  def main do
    Util.mostrar_resultado("Vocales con graphemes", contar_vocales_con_graphemes("Hola Mundo"))
    Util.mostrar_resultado("Vocales sin graphemes", contar_vocales_sin_graphemes("Hola Mundo"))
    Util.mostrar_resultado("16 es potencia de 2", es_potencia?(16, 2))
    Util.mostrar_resultado("6 es perfecto", numero_perfecto?(6))
    Util.mostrar_resultado("Cadena mas larga", cadena_mas_larga(["sol", "luna", "universo"]))
    Util.mostrar_resultado("36 es reversible", numero_reversible?(36))
  end

  @doc """
  Cuenta vocales usando String.graphemes/1.
  """
  def contar_vocales_con_graphemes(texto) when is_binary(texto) do
    texto
    |> String.graphemes()
    |> contar_vocales_lista()
  end

  @doc """
  Cuenta vocales sin usar String.graphemes/1.
  """
  def contar_vocales_sin_graphemes(texto) when is_binary(texto) do
    contar_vocales_binario(texto)
  end

  @doc """
  Dice si n es potencia de b.
  """
  def es_potencia?(n, b) when not is_integer(n) or not is_integer(b), do: false
  def es_potencia?(1, b) when Util.entero_positivo?(b), do: true
  def es_potencia?(n, 1) when is_integer(n), do: n == 1
  def es_potencia?(n, b) when n <= 0 or b <= 0, do: false

  def es_potencia?(n, b) do
    if rem(n, b) != 0 do
      false
    else
      es_potencia?(div(n, b), b)
    end
  end

  @doc """
  Dice si un numero es perfecto.
  """
  def numero_perfecto?(n) when not Util.entero_positivo?(n), do: false
  def numero_perfecto?(1), do: false

  def numero_perfecto?(n) do
    sumar_divisores_propios(n, 1, 0) == n
  end

  @doc """
  Retorna la cadena mas larga de la lista.
  """
  def cadena_mas_larga([]), do: nil
  def cadena_mas_larga([cadena | resto]), do: cadena_mas_larga(resto, cadena)

  @doc """
  Dice si un numero positivo es reversible.
  """
  def numero_reversible?(n) when not Util.entero_positivo?(n), do: false

  def numero_reversible?(n) do
    invertido = invertir_numero(n, 0)
    todos_digitos_impares?(n + invertido)
  end

  defp contar_vocales_lista([]), do: 0

  defp contar_vocales_lista([letra | resto]) do
    if Util.es_vocal?(letra) do
      1 + contar_vocales_lista(resto)
    else
      contar_vocales_lista(resto)
    end
  end

  defp contar_vocales_binario(<<>>), do: 0

  defp contar_vocales_binario(<<char::utf8, resto::binary>>) do
    if Util.es_vocal?(char) do
      1 + contar_vocales_binario(resto)
    else
      contar_vocales_binario(resto)
    end
  end

  # Recursividad de cola para sumar divisores.
  defp sumar_divisores_propios(n, divisor, acumulado) when divisor == n, do: acumulado

  defp sumar_divisores_propios(n, divisor, acumulado) do
    if rem(n, divisor) == 0 do
      sumar_divisores_propios(n, divisor + 1, acumulado + divisor)
    else
      sumar_divisores_propios(n, divisor + 1, acumulado)
    end
  end

  defp cadena_mas_larga([], mayor), do: mayor

  defp cadena_mas_larga([cadena | resto], mayor) do
    cadena_mas_larga(resto, Util.cadena_mas_larga(cadena, mayor))
  end

  # Invierte el numero sin pasarlo a texto.
  defp invertir_numero(0, invertido), do: invertido

  defp invertir_numero(n, invertido) do
    invertir_numero(div(n, 10), invertido * 10 + rem(n, 10))
  end

  # Verifica que todos los digitos del resultado sean impares.
  defp todos_digitos_impares?(n) when n < 10, do: Util.digito_impar?(n)

  defp todos_digitos_impares?(n) do
    if Util.digito_impar?(rem(n, 10)) do
      todos_digitos_impares?(div(n, 10))
    else
      false
    end
  end
end

Recursividad.main()
