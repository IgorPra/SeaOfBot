defmodule SeaOfBot.Command.Github do
  def handle_github(msg) do
    if String.starts_with?(msg.content, "!github") do
      case String.split(msg.content) do
        ["!github", user] ->
          {:ok, response} = HTTPoison.get("https://api.github.com/users/#{user}")
          
          if response.status_code != 200 do
            "Usuário não encontrado"
          else
            {:ok, json} = Jason.decode(response.body)
            """
            Usuario: #{json["login"]}
            Repositórios: #{json["public_repos"]}
            Seguidores: #{json["followers"]}
            Link: #{json["html_url"]}
            """
          end

        _ -> "Use: !github <usuario>"
      end
    end
  end
end
