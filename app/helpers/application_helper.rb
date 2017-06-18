module ApplicationHelper
  def display_person(p, query = nil)
    return link_to(p){highlight p.name, query}.html_safe if(p)
  end

  def highlight(str, query)
    return str if(query.nil?)
    str.gsub(/(#{query})/i, '<span class="highlight">\1</span>').html_safe
  end
end
