class CreateConstructions < ActiveRecord::Migration
  def self.up
    create_table :constructions, :force=>true do |t|
      t.string :receive_num
      t.date :received_on
      t.string :receiver
      t.string :written_at
      t.date :issued_on
      t.integer :applicant_type
      t.integer :applicant_id
      t.integer :company_id
      t.integer :address_id
      t.integer :license_type
      t.integer :purpose
      t.string :purpose_other
      t.integer :construction_type
      t.integer :site_id
      t.integer :building_owner_id
      t.integer :land_owner_id
      t.integer :land_doc_type
      t.string :land_doc_num
      t.integer :engineer_id
      t.integer :architect_id
      t.integer :duration
      t.string :design
      t.string :ownership
      t.string :company_name
      t.string :design_certificate
      t.string :control_license
      t.string :land_doc
      t.string :land_permit
      t.string :control_permit
      t.string :license_num
      t.string :plan_num
      t.float :fee
      t.date :issued_on
      t.date :expired_on
      t.string :pw_report
      t.string :city_plot_num
      t.integer :zone
      t.integer :area
      t.integer :gma_user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :constructions
  end
end
