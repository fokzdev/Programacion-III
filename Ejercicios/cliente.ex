Code.require_file("util.ex", __DIR__)

defmodule Cliente do
  defstruct nombre: "", edad: 0, altura: 0.0

  def crear(nombre, edad, altura) do
    %Cliente{nombre: nombre, edad: edad, altura: altura}
  end

  def ingresar(mensaje) do
    mensaje
    |> Util.mostrar_mensaje()

    nombre =
      "Ingrese nombre:"
      |> Util.ingresar(:texto)

    edad =
      "Ingrese edad:"
      |> Util.ingresar(:entero)

    altura =
      "Ingrese altura:"
      |> Util.ingresar(:real)

    crear(nombre, edad, altura)
  end

  def ingresar(mensaje, :clientes) do
    mensaje
    |> ingresar_clientes([])
  end

  def generar_mensaje_clientes(clientes, generador_mensaje) do
    clientes
    |> Enum.map(generador_mensaje)
    |> Enum.join("")
  end

  defp ingresar_clientes(mensaje, lista) do
    cliente =
      mensaje
      |> ingresar()

    nueva_lista = lista ++ [cliente]

    mas_clientes =
      "\nIngresar más clientes (s/n): "
      |> Util.ingresar(:boolean)

    case mas_clientes do
      true ->
        mensaje
        |> ingresar_clientes(nueva_lista)

      false ->
        nueva_lista
    end
  end
end
