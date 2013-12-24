class ActsAsTraceableMigration < ActiveRecord::Migration
  def change
    create_table :traces, :force => true do |t|
      t.belongs_to :tracer, polymorphic: true, :null => false, index: true
      t.belongs_to :traceable, polymorphic: true, :null => false, index: true
      t.string  :action, :null => false

      t.timestamps
    end
  end
end
