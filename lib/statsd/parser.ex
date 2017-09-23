defmodule StatsD.Parser do
  defmodule Error do
    defexception [:message]
  end

  def parse(text) do
    try do
      [bucket, rest] = String.split(text, ":")
      parts = String.split(rest, "|")
      type = List.last(parts)

      do_parse(type, bucket, Enum.drop(parts, -1))
    rescue
      _ -> raise Error, "Failed to parse `#{text}`"
    end
  end

  defp do_parse("c", bucket, [value]),
    do: {:counter, bucket, String.to_integer(value)}

  defp do_parse("g", bucket, [value]),
    do: {:guage, bucket, String.to_integer(value)}

  defp do_parse("s", bucket, [value]),
    do: {:set, bucket, String.to_integer(value)}

  defp do_parse("ms", bucket, [value]),
    do: {:timing, bucket, String.to_integer(value)}
end
