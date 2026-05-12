defmodule SeaOfBot.Command.Livro do
  def handle_livro(msg) do
    if String.starts_with?(msg.content, "!livro") do
      case String.split(msg.content, " ", parts: 3) do
        ["!livro", titulo, autor] ->
          query_params = URI.encode_query(%{
            "title" => titulo,
            "author" => autor
          })

          url = "https://openlibrary.org/search.json?#{query_params}"

          {:ok, response} = HTTPoison.get(url)
          {:ok, json} = Jason.decode(response.body)

          case json["docs"] do
            [primeiro | _] ->
              "Encontrei: #{primeiro["title"]} (Lançado em: #{primeiro["first_publish_year"]})"

            [] ->
              "Nenhum livro encontrado com esse título e autor."
          end

        _ ->
          "Use: !livro <Titulo> <Autor>"
      end
    end
  end
end
