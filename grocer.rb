require 'pry'

def find_item_by_name_in_collection(name, collection)
  row_index = 0 
  while row_index < collection.length
    if collection[row_index][:item]["#{name}"]
      return collection[row_index]
    end
  row_index += 1 
  end
end

def consolidate_cart(cart)

  new_cart = []
  row_index = 0
  
  while row_index < cart.length do
    new_cart_item = find_item_by_name_in_collection(cart[row_index][:item], new_cart)
    if new_cart_item
      new_cart_item[:count] +=1
    else 
      new_cart_item = {
        :item => cart[row_index][:item],
        :price => cart[row_index][:price],
        :clearance => cart[row_index][:clearance],
        :count => 1 
      }
    row_index += 1 
  end
  new_cart
end

def apply_coupons(cart, coupons)
 row_index = 0 
 while row_index < coupons.length
 cart_item = find_item_by_name_in_collection(coupons[row_index][:item], cart)
 couponed_item_name = "#{coupons[row_index][:item]} W/COUPON"
 cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
 if cart_item && cart_item[:count] >= coupons[row_index][:num]
   if cart_item_with_coupon
     cart_item_with_coupon[:count] += coupons[row_index][:num]
     cart_item[:count] -= coupons[row_index][:num]
   else
     cart_item_with_coupon = {
       :item => couponed_item_name,
       :price => coupons[row_index][:cost] / coupons[row_index][:num],
       :count => coupons[row_index][:num],
       :clearance => cart_item[:clearance]
     }
     cart << cart_item_with_coupon
     cart_item[:count] -= coupons[row_index][:num]
      end
    end
  row_index += 1 
  end
  cart
end

def apply_clearance(cart)
  row_index = 0 
  while row_index < cart.length
    if cart[row_index][:clearance]
      cart[row_index][:price] = (cart[row_index][:price] - (cart[row_index][:price] * 0.20)).round(2)
    end
   row_index += 1 
  end
 cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
end
