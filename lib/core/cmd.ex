defmodule Helm.Core.Cmd do
  require Logger
  @command "helm"
  def build_command(commands, options, flags) when is_struct(options) do
    {_, acc} = build_options(options |> Map.from_struct() |> remove_nil_options, flags)

    Logger.debug([@command] ++ [commands] ++ acc |> Enum.join(" "))
    with {resp, 0} <-System.cmd(@command, Enum.concat(commands, acc ++ ["--output", "json"])) do
      {:ok, Jason.encode!(resp)}
    else
      {resp, exit_code} ->
        Logger.info("#{resp}: exited with code: #{inspect(exit_code)}")
        {:error, resp}
    end
  end




  def get_flag(option) when is_atom(option) do
    "--" <> Atom.to_string(option) |> String.replace("_", "-")
  end

  defp build_options(options, flags) do
    Enum.map_reduce(flags, [], &build_option(options, {&1, &2}))
  end




  defp remove_nil_options(options) do
    Enum.filter(options, fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  defp build_option(opts, {{k, :string}, acc}) do
    if Map.has_key?(opts, k) do
      {k, Enum.concat(acc, [get_flag(k), "#{opts[k]}"])}
    else
      {k, acc}
    end

  end

  defp build_option(opts, {{k, :required}, acc}) do
    if Map.has_key?(opts, k) do
      {k, Enum.concat(acc, ["#{opts[k]}"])}
    else

      {k, acc}
    end
  end

  defp build_option(opts, {{k, :number}, acc}) do
    if Map.has_key?(opts, k) and is_integer(Map.get(opts, k))do
      {k, Enum.concat(acc, [get_flag(k), "#{opts[k]}"])}
    else

      {k, acc}
    end
  end


  defp build_option(opts, {k, acc}) when is_atom(k) do
    if Map.has_key?(opts, k) do
      {k, Enum.concat(acc, [get_flag(k)])}
    else
      {k, acc}
    end
  end





end
