class CreateAccountbooks < ActiveRecord::Migration
  def change
    create_table :accountbooks do |t|
      t.date :date
      t.integer :amount
      t.string :person
      t.string :content

      t.timestamps
    end
  end
end
