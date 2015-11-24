class ChangeYearInQuarters < ActiveRecord::Migration
  def change
  	change_column :quarters, :year, 'integer USING CAST(year AS integer)'
  end
end

