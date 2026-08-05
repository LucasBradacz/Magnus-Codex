class Item < ApplicationRecord
  belongs_to :personagem

  validates :nome, presence: true

  def arma?
    dano.present?
  end
end