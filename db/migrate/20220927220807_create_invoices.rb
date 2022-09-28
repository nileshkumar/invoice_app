class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.float :amount
      t.date :due_date
      t.float :selling_price

      t.timestamps
    end
  end
end
