defmodule Helm.Pkg.Cmd do
  require Logger
  @command "helm"
  def build_command(commands, options, flags) do
    {_, acc} = build_options(options |> Map.from_struct() |> remove_nil_options, flags)

    Logger.debug(([@command] ++ [commands] ++ acc) |> Enum.join(" "))
    System.cmd(@command, Enum.concat(commands, acc))
  end

  def get_flag(option) when is_atom(option) do
    "--" <> Atom.to_string(option)
  end

  defp build_options(options, flags) do
    Enum.map_reduce(flags, [], &build_option(options, {&1, &2}))
  end

  defp remove_nil_options(options) do
    Enum.filter(options, fn {_, v} -> v != nil end)
    |> Enum.into(%{})
  end

  defp build_option(option, {{k, :string}, acc}) do
    {k, Enum.concat(acc, [get_flag(k), "#{option[k]}"])}
  end

  defp build_option(option, {{k, :required}, acc}) do
    {k, Enum.concat(acc, ["#{option[k]}"])}
  end

  defp build_option(opts, {k, acc}) when is_atom(k) do
    if Map.has_key?(opts, k) do
      {k, Enum.concat(acc, [get_flag(k)])}
    end
      {k, acc}
  end

  defp build_option(option, {{k, :no_escape}, acc}) do
    {k, Enum.concat(acc, [get_flag(k), "#{option[k]}"])}
  end
end
