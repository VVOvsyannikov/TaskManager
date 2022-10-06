FactoryBot.define do
  sequence :string, aliases: [:first_name, :last_name, :password, :name, :description, :avatar] do |n|
    "string#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  # sequence :state, [:new_task, :archived, :in_development, :in_qa, :in_code_review, :ready_for_release, :released].sample
end
