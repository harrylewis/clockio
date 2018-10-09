class CreateClockEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_events do |t|
      t.string :name, limit: 92
      t.boolean :clocking_in
      t.datetime :time_logged

      t.timestamps
    end
  end
end
