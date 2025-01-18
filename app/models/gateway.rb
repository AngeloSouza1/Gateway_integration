class Gateway < ApplicationRecord
  validates :name, :production_url, :public_key, :secret_key, presence: true

  def active_status
    active ? "Ativo" : "Inativo"
  end
end
