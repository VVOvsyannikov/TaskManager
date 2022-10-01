FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :name, :description, :state, :avatar, :expired_at] do |n|
    "string#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  sequence :type, [:Developer, :Manager, :Admin].sample
end
