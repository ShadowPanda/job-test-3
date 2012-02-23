# encoding: utf-8

class CreateUsers < ActiveRecord::Migration
	def up
		create_table :users do |t|
			t.string :name
			t.string :nick
			t.string :persistence_token

			t.timestamps
		end

		change_table :messages do |t|
			t.remove :user
			t.integer :user_id
		end
	end

	def down
		drop_table :users

		change_table :messages do |t|
			t.string :user
			t.remove :user_id
		end
	end
end
