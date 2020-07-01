class QueryLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :query_logs do |t|
      t.integer :year
      t.string :population
      t.string :query_type
      t.timestamps
    end
  end
end
