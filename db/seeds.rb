require 'csv'

puts "Limpando cartas existentes..."
Modificador.destroy_all
Transmutacao.destroy_all
Forma.destroy_all

puts "Importando cartas do CSV..."

csv_path = Rails.root.join('db', 'magnus_codex_cartas.csv')

erros = []
total = 0

CSV.foreach(csv_path, headers: true, encoding: 'UTF-8') do |row|
  tipo        = row['tipo']&.strip
  nome        = row['nome']&.strip
  descricao   = row['descricao']&.strip
  alcance     = row['alcance']&.strip
  tamanho     = row['tamanho']&.strip
  duracao     = row['duracao']&.strip
  custo_base  = row['custo_base'].present? ? row['custo_base'].strip : nil
  poder_base  = row['poder_base'].present? ? row['poder_base'].to_i : nil
  dado_poder  = row['dado_poder']&.strip
  custo_multi = row['custo_multiplicador'].present? ? row['custo_multiplicador'].to_f : nil
  op_custo    = row['operacao_custo']&.strip
  val_custo   = row['valor_custo'].present? ? row['valor_custo'].strip : nil
  op_poder    = row['operacao_poder']&.strip
  val_poder   = row['valor_poder'].present? ? row['valor_poder'].strip : nil
  efeito      = row['efeito']&.strip
  basica      = row['basica']&.strip == 'true'
  disciplina  = row['disciplina']&.strip
  nivel_min   = row['nivel_minimo'].present? ? row['nivel_minimo'].to_i : nil
  imagem      = row['imagem']&.strip

  disciplina  = nil if disciplina.blank? || disciplina == 'UNKNOWN'
  nivel_min   = nil if row['nivel_minimo'].blank? || row['nivel_minimo'].strip == 'UNKNOWN'

  begin
    case tipo
    when 'forma'
      Forma.create!(
        nome:        nome,
        descricao:   descricao,
        alcance:     alcance,
        tamanho:     tamanho,
        duracao:     duracao,
        custo_base:  custo_base,
        poder_base:  poder_base,
        basica:      basica,
        disciplina:  disciplina,
        nivel_minimo: nivel_min,
        imagem:      imagem
      )
    when 'transmutacao'
      Transmutacao.create!(
        nome:               nome,
        descricao:          descricao,
        dado_poder:         dado_poder,
        custo_multiplicador: custo_multi,
        basica:             basica,
        disciplina:         disciplina,
        nivel_minimo:       nivel_min,
        imagem:             imagem
      )
    when 'modificador'
      Modificador.create!(
        nome:          nome,
        descricao:     descricao,
        operacao_custo: op_custo,
        valor_custo:   val_custo,
        operacao_poder: op_poder,
        valor_poder:   val_poder,
        efeito:        efeito,
        basica:        basica,
        disciplina:    disciplina,
        nivel_minimo:  nivel_min,
        imagem:        imagem
      )
    else
      erros << "Linha desconhecida: tipo='#{tipo}' nome='#{nome}'"
      next
    end
    total += 1
    print "."
  rescue => e
    erros << "Erro em '#{nome}': #{e.message}"
  end
end

puts "\n\nImportacao concluida!"
puts "Total importado: #{total} cartas"
puts "Formas:      #{Forma.count}"
puts "Transmutacoes: #{Transmutacao.count}"
puts "Modificadores: #{Modificador.count}"

if erros.any?
  puts "\nErros encontrados:"
  erros.each { |e| puts "  - #{e}" }
else
  puts "\nNenhum erro encontrado!"
end