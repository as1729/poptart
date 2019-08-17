class CreatePrinters < ActiveRecord::Migration[6.0]
  def change
    create_table :printers do |t|
      t.string :friendly_name
      t.references :user, foreign_key: true
      t.string :password_digest

      t.timestamps
    end
  end
end
