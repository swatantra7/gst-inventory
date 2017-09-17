SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.item :dashboard, :Dashboard, '#'
    primary.item :Manage, 'Manage', '#' do |secondary|
      secondary.item :items, :Item, items_path
    end
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false
  end
end