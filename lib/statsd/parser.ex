defmodule StatsD.Parser do
  defmodule Error do
    defexception [:message]
  end

  def parse(text) do
    parts = String.split(text, "|")
    type = List.last(parts)

    do_parse(type, Enum.drop(parts, -1))
  end

  defp do_parse("c", [count]),
    do: {:counter, String.to_integer(count)}

  defp do_parse(type, parts) do
    input = Enum.join(parts ++ [type], "|")
    raise Error, "Failed to parse `#{input}`"
  end
end
