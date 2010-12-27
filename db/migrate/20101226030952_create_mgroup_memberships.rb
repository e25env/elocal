class CreateMgroupMemberships < ActiveRecord::Migration
  def self.up
    create_table :mgroup_memberships, :force=>true do |t|
      t.integer :user_id
      t.integer :mgroup_id
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :mgroup_memberships
  end
end
