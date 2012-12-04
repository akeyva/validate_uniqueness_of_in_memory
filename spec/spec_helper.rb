require 'rubygems'

require 'sqlite3'
require 'active_record'
require 'active_model'

require 'rspec'
require 'validate_uniqueness_of_in_memory'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:'
)

class CreateAssociatedModelsForTesting < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.string  :name
    end
    create_table :choices do |t|
      t.string  :choice_name
      t.integer :question_id
    end
  end

  def self.down
    drop_table :questions
    drop_table :choices
  end
end

CreateAssociatedModelsForTesting.migrate(:up)
