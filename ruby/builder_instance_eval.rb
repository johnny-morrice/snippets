# I can't remember where I saw this trick, but it's neat
# It looks more like markup than merely using a closure

# Here's a builder for heirarchical data
class HrBuilder

    def initialize()
        @school = School.new
        @contact = ContactDetails.new
    end

    def contact_details(&blk)
        @contact.instance_eval(&blk)
    end

    def education(&blk)
        @school.instance_eval(&blk)
    end

    # Serialize to lamest markup language ever
    def to_sarcasm_ml()
        <<TEMPLATE
APPLICANT_NAME: #{@contact.person}
PHONE_NUMBER: #{@contact.telephone}
SCHOOL_NAME: #{@school.institution}
GRAD_YEAR: #{@school.date}
TEMPLATE
    end

end

class School
    attr_accessor :institution, :date

    def school_name(alamater)
        @institution = alamater 
    end

    def graduated(year)
        @date = year
    end

end

class ContactDetails
    attr_accessor :person, :telephone

    def whole_name(name)
        @person = name
    end

    def phone(phone_number)
        @telephone = phone_number
    end
end

builder = HrBuilder.new

builder.contact_details do 
    whole_name "Johnny Morrice"
    phone "+44 1234 567890"
end

builder.education do
    school_name "Edinburgh"
    graduated "...."
end

# Serialize to a modern, friendly format
puts builder.to_sarcasm_ml