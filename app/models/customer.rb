class Customer < ApplicationRecord
  validates_presnce_of :first_name, :last_name
end
