module ApplicationHelper
  def display_person(p)
    return p.name if(p)
  end

  def highlight(str, query)
    return str if(query.nil?)
    str.gsub(/(#{query})/i, '<span class="highlight">\1</span>').html_safe
  end
end
