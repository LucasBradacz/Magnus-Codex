class ModificadorUpgrade < ApplicationRecord
  belongs_to :modificador, class_name: 'Modificador'
  belongs_to :upgrade, class_name: 'Modificador'
end