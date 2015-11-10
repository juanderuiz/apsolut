class ChangeYearInQuarters < ActiveRecord::Migration
  def change
  	change_column :quarters, :year, :integer
  end
end
