# SeaOfBot

SeaOfBot e um bot para Discord feito em Elixir usando a biblioteca
[Nostrum](https://github.com/Kraigie/nostrum). Ele responde a comandos de texto,
consulta APIs externas e salva lembrancas dos usuarios em um arquivo local
`store.json`.

## Requisitos

- Elixir 1.14 ou superior
- Erlang/OTP compativel com a versao do Elixir
- Uma aplicacao de bot criada no Discord Developer Portal
- Token do bot configurado em `config/config.exs`

## Instalacao

Instale as dependencias do projeto:

```bash
mix deps.get
```

Compile o projeto:

```bash
mix compile
```

## Como executar

Antes de iniciar, confira se o token do Discord esta configurado em
`config/config.exs`:

```elixir
config :nostrum,
  token: "SEU_TOKEN_DO_DISCORD",
  gateway_intents: :all,
  ffmpeg: false
```

Depois execute o bot com:

```bash
mix run --no-halt
```

Quando o bot estiver online no servidor do Discord, envie um dos comandos em um
canal onde ele tenha permissao para ler e responder mensagens.

## Comandos

| Comando | O que faz |
| --- | --- |
| `!tech` | Busca uma noticia de tecnologia no Hacker News. |
| `!status` | Consulta se um site e considerado ecologico. |
| `!github` | Executa o comando relacionado ao GitHub definido no projeto. |
| `!age` | Executa o comando de idade definido no projeto. |
| `!conv` | Executa o comando de conversao definido no projeto. |
| `!emoji` | Executa o comando de emoji definido no projeto. |
| `!country` | Executa o comando de pais definido no projeto. |
| `!lembrar <texto>` | Salva uma lembranca do usuario no arquivo `store.json`. |
| `!memorias` | Le o `store.json` e lista as lembrancas salvas pelo usuario. |

## Arquivo de memorias

As lembrancas ficam salvas no arquivo `store.json`. O formato usado pelo bot e:

```json
{
  "users": {
    "id_do_usuario": [
      {
        "text": "texto salvo pelo usuario",
        "extra": "sugestao retornada pela API externa"
      }
    ]
  }
}
```

Se o arquivo nao existir ou estiver vazio/fora do formato esperado, o bot cria a
estrutura padrao automaticamente ao salvar uma nova lembranca.

## Testes

Para rodar os testes:

```bash
mix test
```
