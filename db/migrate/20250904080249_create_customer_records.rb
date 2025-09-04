class CreateCustomerRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :customer_records do |t|
      t.timestamps
    end
  end
end
