class CreateTethysSnapshots < ActiveRecord::Migration
  def change
    create_table :tethys_snapshots do |t|
      t.references :aggregate, index: true
      t.text :data
      t.integer :version

      t.timestamps
    end
  end
end
