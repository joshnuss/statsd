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
    [bucket, value] = String.split(key, ":")
    [rate_string] = String.split(rate, "@", trim: true)
    {rate_value, _} = Float.parse(rate_string)

    %StatsD.Stat{
      type: @types[type],
      bucket: bucket,
      value: String.to_integer(value),
      rate: rate_value}
  end
end
