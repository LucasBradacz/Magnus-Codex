# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_07_07_205417) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "formas", force: :cascade do |t|
    t.string "alcance"
    t.boolean "basica", default: false, null: false
    t.datetime "created_at", null: false
    t.integer "custo_base"
    t.text "descricao"
    t.string "disciplina"
    t.string "duracao"
    t.string "imagem"
    t.integer "nivel_minimo"
    t.string "nome"
    t.integer "poder_base"
    t.string "tamanho"
    t.datetime "updated_at", null: false
  end

  create_table "modificadors", force: :cascade do |t|
    t.boolean "basica", default: false, null: false
    t.datetime "created_at", null: false
    t.text "descricao"
    t.string "disciplina"
    t.text "efeito"
    t.string "imagem"
    t.integer "nivel_minimo"
    t.string "nome"
    t.string "operacao_custo"
    t.string "operacao_poder"
    t.datetime "updated_at", null: false
    t.decimal "valor_custo"
    t.decimal "valor_poder"
  end

  create_table "personagens", force: :cascade do |t|
    t.integer "agilidade"
    t.datetime "created_at", null: false
    t.decimal "dinheiro"
    t.integer "dominio"
    t.integer "estabilidade_atual"
    t.integer "mana_atual"
    t.integer "nivel"
    t.integer "nivel_direita_inferior", default: 0
    t.integer "nivel_direita_superior", default: 0
    t.integer "nivel_esquerda_inferior", default: 0
    t.integer "nivel_esquerda_superior", default: 0
    t.integer "nivel_superior", default: 0
    t.string "nome"
    t.integer "percepcao"
    t.string "player"
    t.integer "potencia"
    t.integer "resistencia"
    t.datetime "updated_at", null: false
    t.integer "vida_atual"
  end

  create_table "transmutacaos", force: :cascade do |t|
    t.boolean "basica", default: false, null: false
    t.datetime "created_at", null: false
    t.decimal "custo_multiplicador"
    t.string "dado_poder"
    t.text "descricao"
    t.string "disciplina"
    t.string "imagem"
    t.integer "nivel_minimo"
    t.string "nome"
    t.datetime "updated_at", null: false
  end
end
