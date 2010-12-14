class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies, :force=>true do |t|
      t.string :name
      t.integer :address_id
      t.string :business_type
      t.date :registered_on
      t.string :registration_num
      t.integer :authorized_person_id
      t.integer :authorized_person_address_id
      t.string :doc
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
