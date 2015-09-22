
# It looks more like markup than merely using a closure

# Usage begins on line 59

# A builder for heirarchical data 
class HrBuilder

  # The School this person attended
  attr_reader :school

  # The ContactDetails for this person
  attr_reader :contact

  # Initializes a new person with School and ContactDetails data. Provides a DSL for 
  # easy input.
  #
  # Example:
  #   builder = HrBuilder.new do
  #     name "Gavin Morrice"
  #     phone "+44 1234 567890"
  #     school_name "Hard Knox"
  #     graduated "2007"
  #   end
  #
  def initialize(&builder)
    @school  = School.new
    @contact = ContactDetails.new
    instance_eval(&builder)
  end

  # Serialize to lamest markup language ever
  def to_sarcasm_ml
    <<-TEMPLATE
      APPLICANT_NAME! #{contact.name}
      PHONE_NUMBER!   #{contact.phone}
      SCHOOL_NAME!    #{school.school_name}
      GRAD_YEAR!      #{school.graduated}
    TEMPLATE
  end

  # Forwards messages to child attributes if they are not recognised by self
  def method_missing(method_name, *args, &block)
    [school, contact].each do |child|
      if child.respond_to?(method_name)
        child.send(method_name, *args, &block) and return
      end      
    end
    super
  end
  
end


# The College/University a Person attended
class School

  # A getter/setter method for this school's name. Sets the attribute if the param is
  #   present, otherwise will return the stored value.
  #
  # Returns @school name as a String if set
  def school_name(string = nil)
    if string
      @school_name = string
    else
      @school_name
    end
  end

  def graduated(string = nil)
    if string
      @graduated = string
    else
      @graduated 
    end
  end

end

class ContactDetails

  def name(string = nil)
    if string
      @name = string
    else
      @name
    end
  end

  def phone(number = nil)
    if number
      @phone = number
    else
      @phone
    end
  end
  
end

# Usage

builder = HrBuilder.new do
  name "Gavin Morrice"
  phone "+44 1234 567890"
  school_name "Hard Knox"
  graduated "2007"
end

# Serialize to a modern, friendly format
puts builder.to_sarcasm_ml
