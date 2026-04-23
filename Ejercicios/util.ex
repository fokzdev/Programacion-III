defmodule Util do
  @vocales ["a", "e", "i", "o", "u", "á", "é", "í", "ó", "ú"]
  @vocales_codigo [?a, ?e, ?i, ?o, ?u, ?A, ?E, ?I, ?O, ?U, ?á, ?é, ?í, ?ó, ?ú, ?Á, ?É, ?Í, ?Ó, ?Ú]

  def ingresar(mensaje, :texto) do
    mensaje
    |> IO.gets()
    |> String.trim()
  end

  def ingresar(mensaje, :entero) do
    mensaje
    |> Util.ingresar(:texto)
    |> String.to_integer()
  end

  def ingresar(mensaje, :decimal) do
    mensaje
    |> Util.ingresar(:texto)
    |> String.to_float()
  end

  def ingresar(mensaje, :real) do
    ingresar(mensaje, :decimal)
  end

  def ingresar(mensaje, :boolean) do
    valor =
      mensaje
      |> ingresar(:texto)
      |> String.downcase()

    Enum.member?(["si", "sí", "s"], valor)
  end

  def mostrar_mensaje(mensaje) do
     IO.puts(mensaje)
  end

  def mostrar_resultado(etiqueta, valor) do
    IO.puts("#{etiqueta}: #{valor}")
  end

  def entero_positivo?(valor) do
    is_integer(valor) and valor > 0
  end

  def es_vocal?(letra) when is_binary(letra) do
    String.downcase(letra) in @vocales
  end

  def es_vocal?(codigo) when is_integer(codigo) do
    codigo in @vocales_codigo
  end

  def cadena_mas_larga(cadena_1, cadena_2) do
    if String.length(cadena_1) >= String.length(cadena_2) do
      cadena_1
    else
      cadena_2
    end
  end

  def digito_impar?(numero) do
    rem(numero, 2) == 1
  end
end
