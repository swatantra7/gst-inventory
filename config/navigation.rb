SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.item :Items, 'Items', '#' do |secondary|
      secondary.item :book, :BOOK, '#', highlights_on: %r(/profiles)
      secondary.item :pencil, :PENCIL, '#', highlights_on: %r(/profiles)
      secondary.item :eraser, :ERASIER, '#', highlights_on: %r(/profiles)
      secondary.item :Cutter, :CUTTER, '#', highlights_on: %r(/profiles)
    end
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false
  end
end