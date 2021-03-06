class CreateLikeRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :like_relationships do |t|
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true

      t.timestamps
      t.index [:user_id, :id], unique: true
    end
  end
end
