defmodule Util do

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

  def mostrar_mensaje(mensaje) do
     IO.puts(mensaje)
  end
end
