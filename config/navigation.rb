SimpleNavigation::Configuration.run do |navigation|  
  navigation.items do |primary|
    primary.item :dashboard, :Dashboard, activities_path
    primary.item :Manage, 'Manage', '#' do |secondary|
      secondary.item :items, :Item, items_path
    end
    primary.item :orders, 'Order', '#' do |secondary|
      secondary.item :orders, :OrderList, orders_path
      secondary.item :orders, :OrderBulkItem, new_order_path
    end
    primary.dom_class = 'nav navbar-nav'
    primary.dropdown = true
    primary.split = false
  end
end