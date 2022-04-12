class CreateInvoiceProcessors < ActiveRecord::Migration[6.1]
  def change
    create_table :invoice_processors do |t|
      t.references :user, null: false, foreign_key: true
      t.references :invoice, null: true, foreign_key: true
      t.string :status, null: false, index: true
      t.string :file_type, null: false
      t.jsonb :data
      t.string :error_message

      t.timestamps
    end
  end
end
