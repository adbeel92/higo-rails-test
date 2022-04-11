class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.uuid :uuid, null: false, index: true, unique: true
      t.references :emitter, index: true, null: false, foreign_key: { to_table: :persons }
      t.references :receiver, index: true, null: false, foreign_key: { to_table: :persons }
      t.decimal :amount, precision: 8, scale: 2, null: false
      t.string :currency
      t.datetime :emitted_at
      t.datetime :expires_at

      t.timestamps
    end
  end
end
