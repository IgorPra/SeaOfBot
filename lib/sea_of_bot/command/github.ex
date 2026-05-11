defmodule SeaOfBot.Command.Github do
  def handle_github(msg) do
    case String.split(msg.content) do
      ["!github"] -> "Use: !github <usuario>"
      ["!github", user] -> fetch(user)
      _ -> "Comando inválido"
    end
  end

  defp fetch(user) do
    {:ok, res} = HTTPoison.get("https://api.github.com/users/#{user}")

    cond do
      res.status_code != 200 ->
        "Usuário não encontrado"

      true ->
        {:ok, json} = Jason.decode(res.body)

        """
        Usuario: #{json["login"]}
        Repositórios: #{json["public_repos"]}
        Seguidores: #{json["followers"]}
        Link: #{json["html_url"]}
        """
    end
  end
end
