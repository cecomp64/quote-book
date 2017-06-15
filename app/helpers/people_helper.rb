module PeopleHelper

    def anonymous
      Person.find_or_create_by(name: 'Anonymous')
    end

    # Convert a text person to a Person object
    def personify_params(p)
      return p if(!p.is_a?(Hash))
      dup = p.dup

      [:attribution, :author, :person].each do |attribute|
        next if !dup.key?(attribute)

        if(dup[attribute])
          dup[attribute] = dup[attribute].strip.empty? ? anonymous : Person.find_or_create_by(name: dup[attribute].strip)
        else
          dup[attribute] = anonymous
        end
      end

      return dup
    end
end
