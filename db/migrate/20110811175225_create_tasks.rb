class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :due_date
      t.references :project

      t.timestamps
    end
    add_index :tasks, :project_id
  end
end
