class CreateQuarters < ActiveRecord::Migration
  def change
    create_table :quarters do |t|
      t.integer :hours
      t.integer :quart
      t.date :year
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
