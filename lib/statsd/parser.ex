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
    {operation, value} = format_value(value_string)

    %StatsD.Stat{
      type: @types[type],
      bucket: bucket,
      operation: operation,
      value: String.to_integer(value),
      rate: format_rate(rate)}
  end

  defp format_value("+" <> value),
    do: {:increment, value}

  defp format_value("-" <> value),
    do: {:decrement, value}

  defp format_value(value),
    do: {:replace, value}

  defp format_rate(text) do
    [rate_string] = String.split(text, "@", trim: true)
    {rate, _} = Float.parse(rate_string)
    rate
  end
end
