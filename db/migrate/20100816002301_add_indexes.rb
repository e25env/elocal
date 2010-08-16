class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :comments, :gma_xmain_id
    add_index :docs, :section_id
    add_index :docs, :confidential_id
    add_index :docs, :urgent_id
    add_index :gma_docs, :gma_xmain_id
    add_index :gma_docs, :gma_runseq_id
    add_index :gma_docs, :gma_service_id
    add_index :gma_services, :gma_module_id
    add_index :gma_songrits, :code
    add_index :gma_users, :section_id
    add_index :payment_details, :payment_id
    add_index :ptypes, :cat_id
    add_index :subsections, :section_id
    add_index :tasks, :plan_id
  end

  def self.down
    remove_index :comments, :gma_xmain_id
    remove_index :docs, :section_id
    remove_index :docs, :confidential_id
    remove_index :docs, :urgent_id
    remove_index :gma_docs, :gma_xmain_id
    remove_index :gma_docs, :gma_runseq_id
    remove_index :gma_docs, :gma_service_id
    remove_index :gma_services, :gma_module_id
    remove_index :gma_songrits, :code
    remove_index :gma_users, :section_id
    remove_index :payment_details, :payment_id
    remove_index :ptypes, :cat_id
    remove_index :subsections, :section_id
    remove_index :tasks, :plan_id
  end
end
