require 'active_record'

module ValidatesUniquenessOfInMemory

  def validate_uniqueness_of_in_memory(collection_name, attrs, message)
    collection = self.send(collection_name)
    hashes = collection.inject({}) do |hash, record|
      key = attrs.map {|a| record.send(a).to_s }.join
      if key.blank? || record.marked_for_destruction?
        key = record.object_id
      end
      hash[key] = record unless hash[key]
      hash
    end
    if collection.length > hashes.length
      self.errors.add(:base, message)
    end
  end
    
end

ActiveRecord::Base.send :include, ValidatesUniquenessOfInMemory
