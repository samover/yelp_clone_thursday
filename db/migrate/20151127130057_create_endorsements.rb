class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.belongs_to :review, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
