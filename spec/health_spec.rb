require 'json'
require 'rspec/core'
policy_file = File.expand_path('../data/contributor_policy.json', __dir__)
input = JSON.parse(File.read(policy_file))
raise 'unexpected keys' unless input.keys.sort == ['allow_production_deploy','benign_tests']
labels=input.fetch('benign_tests')
raise 'invalid benign tests' unless labels.is_a?(Array) && labels.length <= 10 && labels.all? { |v| v.is_a?(String) && v.length.between?(1,64) && /\A[a-zA-Z0-9_ -]+\z/.match?(v) }
flag=input.fetch('allow_production_deploy')
raise 'invalid production flag' unless flag == true || flag == false
RSpec.describe 'OwnerProtected' do
  labels.each { |label| it(label) { expect(true).to eq(true) } }
  it('owner production deployment policy must remain disabled') { expect(flag).to eq(false) }
end
