defmodule StatsD.Parser do
  defmodule Error do
    defexception [:message]
  end

  @types %{
    "c" => :counter,
    "g" => :guage,
    "s" => :set,
    "ms" => :timer
  }

  def parse(text) do
    try do
      text
      |> String.split("|")
      |> parse_parts
    rescue
      _ -> raise Error, "Failed to parse `#{text}`"
    end
  end

  defp parse_parts([key, type]),
    do: parse_parts([key, type, "@1"])

  defp parse_parts([key, type, rate]) do
    [bucket, value_string] = String.split(key, ":")
    [rate] = String.split(rate, "@", trim: true)

    {operation, value} = format_value(value_string)

    %StatsD.Stat{
      type: @types[type],
      bucket: bucket,
      operation: operation,
      value: value,
      rate: format_rate(rate)}
  end

  defp format_value("+" <> value),
    do: {:increment, String.to_integer(value)}

  defp format_value("-" <> value),
    do: {:decrement, String.to_integer(value)}

  defp format_value(value),
    do: {:replace, String.to_integer(value)}

  defp format_rate(text) do
    {rate, _} = Float.parse(text)
    rate
  end
end
