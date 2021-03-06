require 'bundler'
require 'action_view'
require "sinatra/activerecord"
require 'uri'
require 'kafka'
require "json"
require 'faker'
Bundler.require


set :database, ENV['DATABASE_URL'] || 'postgres://localhost/quoter'
   
class App < Sinatra::Base
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::DateHelper
  include Sinatra::ActiveRecordExtension

  #set up Models
  Dir["./models/*.rb"].each {|file| require file }
  

  helpers do
    #pull in the helpers stuff 
    require_relative 'helpers'
  end
  
  #Setup Kafka
  KAFKA_TOPIC = with_prefix(ENV.fetch('KAFKA_TOPIC'))
#  GROUP_ID = ENV.fetch('KAFKA_CONSUMER_GROUP')
  
  #Setup Kafka
  tmp_ca_file = Tempfile.new('ca_certs')
  tmp_ca_file.write(ENV.fetch('KAFKA_TRUSTED_CERT'))
  tmp_ca_file.close
  # This demo app connects to kafka on multiple threads.
  # Right now ruby-kafka isn't thread safe, so we establish a new client
  # for the consumer and a different one for the consumer.
  $producer_kafka = Kafka.new(
    seed_brokers: ENV.fetch('KAFKA_URL'),
    ssl_ca_cert_file_path: tmp_ca_file.path,
    ssl_client_cert: ENV.fetch('KAFKA_CLIENT_CERT'),
    ssl_client_cert_key: ENV.fetch('KAFKA_CLIENT_CERT_KEY'),
    ssl_verify_hostname: false
  )

  $producer = $producer_kafka.async_producer(
  # Trigger a delivery once 100 messages have been buffered.
  #delivery_threshold: 100
  # Trigger a delivery every 10 seconds.
  delivery_interval: 0
  )
  
  consumer_kafka = Kafka.new(
    seed_brokers: ENV.fetch('KAFKA_URL'),
    ssl_ca_cert_file_path: tmp_ca_file.path,
    ssl_client_cert: ENV.fetch('KAFKA_CLIENT_CERT'),
    ssl_client_cert_key: ENV.fetch('KAFKA_CLIENT_CERT_KEY')
  )

  # Connect a consumer. Consumers in Kafka have a "group" id, which
  # denotes how consumers balance work. Each group coordinates
  # which partitions to process between its nodes.
  # For the demo app, there's only one group, but a production app
  # could use separate groups for e.g. processing events and archiving
  # raw events to S3 for longer term storage
 # $consumer = consumer_kafka.consumer #(group_id: with_prefix(GROUP_ID))
#  $recent_messages = []
#  start_consumer
#  start_metrics

  at_exit do
    $producer.shutdown
    tmp_ca_file.unlink
  end
  
  before do
     
  end
    
  configure do
      set :force_ssl, true
  end


  get "/" do
  
  end
  
  
end