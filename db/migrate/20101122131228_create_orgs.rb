class CreateOrgs < ActiveRecord::Migration
  def self.up
    create_table :orgs, :force=>true do |t|
      t.string :otype
      t.string :otype_abbrev
      t.string :name
      t.string :address
      t.string :district
      t.string :province
      t.string :phone
      t.integer :villages
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orgs
  end
end
