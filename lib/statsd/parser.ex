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
    [rate_string] = String.split(rate, "@", trim: true)
    {rate_value, _} = Float.parse(rate_string)

    {op, value} = format_value(value_string)

    %StatsD.Stat{
      type: @types[type],
      bucket: bucket,
      value: value,
      op: op,
      rate: rate_value}
  end

  defp format_value("+" <> value),
    do: {:increment, String.to_integer(value)}

  defp format_value("-" <> value),
    do: {:decrement, String.to_integer(value)}

  defp format_value(value),
    do: {:replace, String.to_integer(value)}
end
