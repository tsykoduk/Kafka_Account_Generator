  def helper_function(params)
  
  end
  
  
  def generate_account()
    new_acct = Account.new
    new_acct.name = Faker::Company.name
    new_acct.billingcountry = Faker::Address.country
    #new_acct.billinglatitude = Faker::Address.latitude
    new_acct.description = Faker::Company.catch_phrase
    new_acct.website = "http://example.com"
    #new_acct.billinglongitude = Faker::Address.longitude
    new_acct.billingstate = Faker::Address.state
    new_acct.billingstreet = Faker::Address.street_address
    new_acct.billingcity = Faker::Address.city
    new_acct.billingpostalcode = Faker::Address.postcode
    new_acct.phone = Faker::PhoneNumber.phone_number
    new_acct.fax = Faker::PhoneNumber.phone_number
    new_acct.external_id__c = SecureRandom.uuid + Time.now().to_i.to_s
    return new_acct
  end
    
  def write_account_to_kafka(account)
    
    #We need to seralize the account into JSON
    message = account.to_json
    
    #Send the message off to Kafka
    $producer.produce(message, topic: with_prefix(KAFKA_TOPIC))
    
  end
  
  def read_from_kafka
    
  end