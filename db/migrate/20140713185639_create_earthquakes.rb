class CreateEarthquakes < ActiveRecord::Migration
  def change
    create_table :earthquakes do |t|
      t.float :time

      t.timestamps
    end
  end
end
