class Modificador < ApplicationRecord
  has_many :modificador_upgrades, foreign_key: :modificador_id
  has_many :upgrades, through: :modificador_upgrades, source: :upgrade

  has_many :modificador_upgrades_as_upgrade, class_name: 'ModificadorUpgrade', foreign_key: :upgrade_id
  has_many :modificadors_origem, through: :modificador_upgrades_as_upgrade, source: :modificador
end