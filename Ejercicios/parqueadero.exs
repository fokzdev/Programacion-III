Code.require_file("util.ex", __DIR__)

defmodule Parqueadero do
  @moduledoc """
  Sistema básico de parqueadero para un centro comercial.

  Este módulo:
  1. Solicita datos de entrada al usuario.
  2. Calcula la tarifa base según horas.
  3. Aplica descuentos por tipo de cliente, tipo de vehículo y día.
  4. Muestra un desglose final del cálculo.

  Conceptos usados:
  - Guardas (`when`) para rangos de horas.
  - `case` para elegir descuentos por tipo.
  - `cond` para descuento por día.
  - `if` para asegurar que el valor final no sea negativo.
  """

  @doc """
  Punto de entrada del programa.

  Flujo:
  - Lee horas, tipo de cliente, tipo de vehículo y tipo de día.
  - Calcula tarifa base.
  - Aplica descuentos y recibe una tupla: `{sin_descuento, con_descuento}`.
  - Calcula cuánto dinero se descontó.
  - Imprime el desglose completo en consola.
  """
  def main do
    # Entradas solicitadas al usuario. Se leen como enteros usando Util.ingresar/2.
    horas = Util.ingresar("Ingrese horas de permanencia: ", :entero)
    tipo_cliente = Util.ingresar("Tipo de cliente (1=frecuente, 2=regular): ", :entero)
    tipo_vehiculo = Util.ingresar("Tipo de vehiculo (1=electrico, 2=convencional): ", :entero)
    tipo_dia = Util.ingresar("Dia (1=fin de semana, 2=entre semana): ", :entero)

    # Cálculo del valor sin descuentos.
    tarifa_sin_descuento = calcular_tarifa_base(horas)

    # Cálculo del valor final aplicando descuentos.
    {sin_descuento, con_descuento} =
      aplicar_descuentos(tarifa_sin_descuento, tipo_cliente, tipo_vehiculo, tipo_dia)

    # Diferencia entre base y valor final.
    descuento_total = sin_descuento - con_descuento

    # Salida final del sistema.
    IO.puts("Horas: #{horas}")
    IO.puts("Tarifa base (sin descuento): $#{sin_descuento}")
    IO.puts("Descuento aplicado: $#{descuento_total}")
    IO.puts("Total a pagar: $#{con_descuento}")
    IO.puts("Tupla retornada: {#{sin_descuento}, #{con_descuento}}")
    IO.puts("====================================")
  end

  # Calcula la tarifa base según horas de permanencia.
  # Cada cláusula usa guardas para definir un rango.
  # Si las horas son 0 o negativas, la tarifa es 0.
  defp calcular_tarifa_base(horas) when horas <= 0, do: 0
  # Hasta 2 horas.
  defp calcular_tarifa_base(horas) when horas <= 2, do: 3000
  # Rango 3 a 5 horas.
  defp calcular_tarifa_base(horas) when horas <= 5, do: 2500
  # Rango 6 a 8 horas.
  defp calcular_tarifa_base(horas) when horas <= 8, do: 2000
  # Más de 8 horas: tarifa fija.
  defp calcular_tarifa_base(_horas), do: 18000

  # Aplica los descuentos y retorna:
  # {valor_sin_descuento, valor_con_descuento}
  defp aplicar_descuentos(tarifa_base, tipo_cliente, tipo_vehiculo, tipo_dia) do
    # Descuento por tipo de cliente usando case.
    # 1 = frecuente, 2 = regular.
    descuento_cliente =
      case tipo_cliente do
        1 -> 0.15
        2 -> 0.0
        _ -> 0.0
      end

    # Descuento por tipo de vehículo usando case.
    # 1 = eléctrico, 2 = convencional.
    descuento_vehiculo =
      case tipo_vehiculo do
        1 -> 0.20
        2 -> 0.0
        _ -> 0.0
      end

    # Descuento por día usando cond.
    # 1 = fin de semana, 2 = entre semana.
    descuento_dia =
      cond do
        tipo_dia == 1 -> 0.10
        tipo_dia == 2 -> 0.0
        true -> 0.0
      end

    # Suma de todos los descuentos.
    descuento_total = descuento_cliente + descuento_vehiculo + descuento_dia

    # Aplica el porcentaje total de descuento.
    # Luego redondea y convierte a entero.
    valor_con_descuento =
      tarifa_base
      |> Kernel.*(1 - descuento_total)
      |> Float.round(0)
      |> trunc()

    # if para evitar un valor final negativo por seguridad.
    valor_final =
      if valor_con_descuento < 0 do
        0
      else
        valor_con_descuento
      end

    {tarifa_base, valor_final}
  end

end

Parqueadero.main()
