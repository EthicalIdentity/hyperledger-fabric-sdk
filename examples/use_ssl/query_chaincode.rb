#!/Users/djlazz3/.rbenv/shims/ruby
require_relative './initialize.rb'

## Enroll admin
fabric_ca_client = FabricCA.new(username: 'admin',  password: 'adminpw')
user_identity = Fabric::Identity.new(
  Fabric.crypto_suite,
  {
    username: "admin",
    affiliation: "org1.department1",
    mspid: 'Org1MSP'
  }
)
enrollment_response = fabric_ca_client.enroll(user_identity.generate_csr([%w(CN admin)]))
user_identity.certificate = enrollment_response[:result][:Cert]

## Query
fabric_client = Fabric.client(identity: user_identity)

puts fabric_client.query(chaincode_id: "mycc",  channel_id: 'mychannel',  args: %w(query a))
