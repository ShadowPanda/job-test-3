class CreateMessages < ActiveRecord::Migration
	def up
		create_table :messages do |t|
			t.string :user
			t.string :title
			t.string :content
			t.timestamps
		end
	end

	def down
		drop_table :messages
	end
end
