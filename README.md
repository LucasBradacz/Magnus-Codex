# Magnus Codex — Gerenciador de Fichas e Cartas

Sistema web para gerenciamento de fichas de personagem e cartas mágicas do RPG **Magnus Codex**, desenvolvido em Ruby on Rails.

---

## Sobre o Jogo

Magnus Codex é um RPG focado na criação de encantamentos e magias modulares baseado em cartas. Os personagens são magos que combinam cartas para criar infinitas possibilidades de magia.

Todo encantamento é composto por três tipos de cartas:

- **Forma** — define o formato da magia (esfera, disco, cone, etc.)
- **Transmutação** — define o elemento (fogo, gelo, eletricidade, etc.)
- **Modificador** — altera o encantamento (amplificar, bifurcar, teleguiar, etc.)

As cartas são divididas em **básicas** (disponíveis para qualquer personagem) e cartas de **disciplina**, organizadas nas 5 pontas do pentagrama:

| Ponta | Foco |
|---|---|
| Superior | Vida, cura, criação |
| Esquerda Superior | Mente, enganação, armadilhas |
| Direita Superior | Melhoria, buffs, aprimoramento |
| Esquerda Inferior | Contenção, debuffs, controle |
| Direita Inferior | Destruição, dano, poder explosivo |

---

## Sobre o Projeto

Este projeto é um sistema web local para:

- Cadastrar e visualizar as cartas mágicas com suas imagens
- Montar fichas de personagem com atributos e status calculados automaticamente
- Montar e salvar encantamentos combinando cartas

Desenvolvido como projeto de aprendizado em Ruby on Rails.

---

## Stack

- **Ruby** 3.4
- **Ruby on Rails** 8.1.3
- **PostgreSQL** 17
- **Propshaft** (asset pipeline)

---

## Instalação

### Pré-requisitos

- Ruby 3.4+ ([RubyInstaller](https://rubyinstaller.org/downloads/) no Windows)
- PostgreSQL 17+
- Git

### Passos

**1. Clone o repositório**
```bash
git clone https://github.com/LucasBradacz/Magnus-Codex.git
cd Magnus-Codex
```

**2. Instale as dependências**
```bash
bundle install
```

**3. Configure o banco de dados**

Edite o arquivo `config/database.yml` com suas credenciais do PostgreSQL:
```yaml
default: &default
  adapter: postgresql
  encoding: unicode
  host: 127.0.0.1
  port: 5432
  username: postgres
  password: SUA_SENHA
```

**4. Crie e popule o banco**
```bash
rails db:create
rails db:migrate
rails db:seed
```

O seed importa automaticamente as 92 cartas do arquivo `db/magnus_codex_cartas.csv`.

**5. Suba o servidor**
```bash
rails server
```

Acesse **http://localhost:3000**

---

## Estrutura das Cartas

O banco é populado via seed com **92 cartas**:

| Tipo | Quantidade |
|---|---|
| Formas | 27 |
| Transmutações | 20 |
| Modificadores | 45 |

---

## Funcionalidades

- [x] Cadastro e listagem de Formas, Transmutações e Modificadores
- [x] Visualização das cartas com imagens
- [x] Ficha de personagem com status calculados automaticamente
- [ ] Montagem de encantamentos
- [ ] Grimório do personagem
- [ ] Filtro por disciplina arcana

---

## Licença

Projeto pessoal — todos os direitos reservados.