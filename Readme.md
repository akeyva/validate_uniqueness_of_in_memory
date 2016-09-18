# validate_uniqueness_of_in_memory gem for Rails 

by Akiva Leeder & Rex Feng @ Flatiron School 2012

## Purpose

Extend ActiveRecord validations by checking if entries in a form are identical. Normal rails uniqueness validations work by checking for duplicate entries in the database, but that does not work when checking for unique form values before they are submitted to the database. 

For example, in a Question model that has_many Choices, this gem will throw an error that prohibits the data from saving if the choices that pertain to that question instance are identical. If the Question "What color is the sky?" has Choices "Blue", "Blue", and "Green", this gem provides validation that the question cannot be saved due to the duplication of the "Blue" choice.

# Installation

Include gem in your ```Gemfile```

    gem "validate_uniqueness_of_in_memory"

In the command line, run ```bundle```. You should see "Installing validate_uniqueness_of_in_memory (0.0.X)", where X is the current gem version.

    $ bundle

In the parent model (the model that ```has_many``` relationship), add the following code:

      validate :validate_unique_CHILD-MODEL-NAME

      def validate_unique_CHILD-MODEL-NAME
        validate_uniqueness_of_in_memory(:CHILD-MODEL-NAME, [CHILD-ATTRIBUTE-TO-VALIDATE-UNIQUENESS, PARENT-ID], 'ERROR MESSAGE GOES HERE.')
      end

An example of parent model code:

    class Question < ActiveRecord::Base
      attr_accessible :name, :choices, :choices_attributes

      has_many :choices
      accepts_nested_attributes_for :choices

      validate :validate_unique_choices

      def validate_unique_choices
        validate_uniqueness_of_in_memory(:choices, [:name, :question_id], 'Choices must be unique.')
      end

    end

An example of child model code:

    class Choice < ActiveRecord::Base
      belongs_to :question
    end

# Special Thanks To
* [Andrew France](https://github.com/Odaeus)
* [Avi Flombaum](https://github.com/aviflombaum/)
