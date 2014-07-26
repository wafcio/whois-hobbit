require 'ostruct'
require_relative '../../spec_helper'

describe 'Domain' do
  it 'empty object should be invalid' do
    domain = Domain.new
    assert_equal domain.valid?, false
  end

  it 'object should be valid' do
    domain = Domain.new(name: 'test', status: 'test', user: Fabricate(:user))
    assert_equal domain.valid?, true
  end

  it 'should allow add contacts' do
    domain = Fabricate(:domain)
    domain.add_contact(Fabricate(:domain_contact))
    assert_equal domain.contacts.size, 1
  end

  it 'should allow add nameservers' do
    domain = Fabricate(:domain)
    domain.add_nameserver(Fabricate(:domain_nameserver))
    assert_equal domain.nameservers.size, 1
  end

  it 'should allow add registrar' do
    domain = Fabricate(:domain)
    registrar = Fabricate(:domain_registrar)
    domain.registrar = registrar
    assert_equal domain.registrar, registrar
  end
end