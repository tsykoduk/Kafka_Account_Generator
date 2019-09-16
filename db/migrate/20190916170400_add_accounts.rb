class AddAccount < ActiveRecord::Migration[6.0]
  def up
    
    create_table :account do |t|
      t.string   :billingpostalcode, limit: 20
      t.string   :sfid,              limit: 18
      t.string   :_c5_source,        limit: 18
      t.datetime :lastmodifieddate
      t.string   :website
      t.string   :billingstreet
      t.string   :name
      t.string   :tickersymbol,      limit: 20
      t.string   :billingcity,       limit: 40
      t.boolean  :isdeleted
      t.string   :phone,             limit: 40
      t.string   :billingstate,      limit: 80
      t.string   :billingcountry,    limit: 80
      t.string   :external_id__c,    limit: 80
      t.datetime :created_at
      t.datetime :updated_at
    end
      add_index :account, :sfid
      add_index :account, :eternal_id__c
  end
  
  def down
    drop_table :account
  end
end
