  def helper_function(params)
  
  end
  
  def with_prefix(name)
    "#{ENV['KAFKA_PREFIX']}#{name}"
  end
  
  def gen_account()
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
    new_acct.assign_uuuid
    new_acct.save
    return new_acct
  end
    
  def push_kafka(message)
     msg = message.to_json
      if $producer.produce(msg, topic: with_prefix(ENV.fetch('KAFKA_TOPIC')))
    	  $producer.deliver_messages
      	sleep(1.second)
    	  push_kafka(acct)
        puts "Flushed Queue"
        puts "Pushed message " + message.external_id__c + " to " + with_prefix(ENV.fetch('KAFKA_TOPIC'))
      end
    end

  
  def just_deliver(message)
    producer_kafka.deliver_message(message, topic: with_prefix(ENV.fetch('KAFKA_TOPIC')))
  end
  
  def read_from_kafka
    
  end