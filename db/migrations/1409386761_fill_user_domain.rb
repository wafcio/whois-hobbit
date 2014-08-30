Sequel.migration do
  up do
    Domain.all.each do |domain|
      UserDomain.create(user_id: domain.user_id, domain_id: domain.id)
    end
  end

  down do
    UserDomain.all.each do |user_domain|
      domain = Domain.where(id: domain_id).first
      domain.set(user_id: user_domain.user_id)
      domain.save
    end
  end
end