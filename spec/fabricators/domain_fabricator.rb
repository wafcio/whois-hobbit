Fabricator(:domain) do
  user { Fabricate(:user) }
  name 'test.com'
  status 'available'
end