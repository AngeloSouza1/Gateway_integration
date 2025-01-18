class MegaPayConfig < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :store

  validates :store, uniqueness: true
  validates :public_key, presence: true
  validates :secret_key, presence: true
end
