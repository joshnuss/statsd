defmodule StatsD.Parser do
  defmodule Error do
    defexception [:message]
  end

  @types %{
    "c" => :counter,
    "g" => :guage,
    "s" => :set,
    "ms" => :timing
  }

  def parse(text) do
    try do
      [bucket, rest] = String.split(text, ":")
      parts = String.split(rest, "|")
      type_code = List.last(parts)
      type = @types[type_code]
      value = parts |> hd |> String.to_integer

      {type, bucket, value}
    rescue
      _ -> raise Error, "Failed to parse `#{text}`"
    end
  end
end
