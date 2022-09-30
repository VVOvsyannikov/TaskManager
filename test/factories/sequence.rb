FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :name, :description, :state, :avatar, :type, :expired_at] do |n|
    "string#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end
end
