class CreateTethysEventSets < ActiveRecord::Migration
  def change
    create_table :tethys_event_sets do |t|
      t.uuid :aggregate_id
      t.integer :version
      t.text :data

      t.timestamps
    end
  end
end
