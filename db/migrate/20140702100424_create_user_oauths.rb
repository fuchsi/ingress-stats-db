class CreateUserOauths < ActiveRecord::Migration
  def change
    create_table :user_oauths do |t|
      t.references :user, index: true
      t.string :uid
      t.string :refresh_token
      t.string :access_token
      t.string :expires

      t.timestamps
    end
    add_index :user_oauths, :uid, unique: true
  end
end
