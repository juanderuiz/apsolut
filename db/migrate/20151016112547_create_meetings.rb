class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :subject
      t.belongs_to :user, index: true
      t.date :day
      t.time :start
      t.time :finish
      t.string :room

      t.timestamps
    end
  end
end
