# require 'spec_helper'

# # test Without Gem

# describe 'Question has Choices relationship WITHOUT validate_uniqueness_of_in_memory' do

#   class Question < ActiveRecord::Base
#     has_many :choices
#   end

#   class Choice < ActiveRecord::Base
#     belongs_to :question
#   end

#   let(:question) { Question.new(:name => "What song is this?") }
#   let(:choice_a) { question.choices.build(:choice_name => "Thriller") }
#   let(:choice_b) { question.choices.build(:choice_name => "Eye of the Tiger") }
#   let(:choice_c) { question.choices.build(:choice_name => "Thriller") }

#   it "should save a question" do
#     question.save.should be_true
#     question.name.should eq("What song is this?")
#   end

#   it "should save duplicate choices for the same question" do
#     # choice_a.save.should be_true
#     question.should be_valid
#     question.errors[:base].should_not include 'Choices must be unique.'
#   end

# end



###


require 'spec_helper'

### Test Gem

describe 'Question has Choices relationship WITH validate_uniqueness_of_in_memory' do

  class Question < ActiveRecord::Base
    include ValidatesUniquenessOfInMemory
    attr_accessible :name, :choices, :choices_attributes
    has_many :choices
    accepts_nested_attributes_for :choices

    
    validate :validate_unique_choices

    def validate_unique_choices
      validate_uniqueness_of_in_memory(:choices, [:choice_name, :question_id], 'Choices must be unique.')
    end    
  end

  class Choice < ActiveRecord::Base
    attr_accessible :choice_name, :question_id
    belongs_to :question
  end

  let(:question) { Question.new(:name => "What song is this?") }
  let(:choice_a) { question.choices.build(:choice_name => "Thriller") }
  let(:choice_b) { question.choices.build(:choice_name => "Eye of the Tiger") }
  let(:choice_c) { question.choices.build(:choice_name => "Thriller") }

  it "should create new a question with a name" do
    question.save.should_not be_true
    question.name.should eq("What song is this?")
  end

  it "should not save duplicate choices for the same question" do
    # choice_a.save.should be_true
    question.should_not be_valid
    question.errors[:base].should include 'Choices must be unique.'
  end

end