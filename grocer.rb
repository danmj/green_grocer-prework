def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |food_hash|
    food_hash.each do |food_item, info_hash|
      if new_cart.include?(food_item)
        new_cart[food_item][:count] += 1
      else
        new_cart[food_item] = {
            :price => info_hash[:price],
            :clearance => info_hash[:clearance],
            :count => 1
        }
      end
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  new_cart = {}
  cart.each do |food_item, info_hash|
    new_cart[food_item] = info_hash
    coupons.each do |coupon_hash|
      if food_item == coupon_hash[:item]
        if info_hash[:count] >= coupon_hash[:num]
          info_hash[:count] -= coupon_hash[:num]
          if new_cart.include?(food_item+" W/COUPON")
            new_cart[food_item+" W/COUPON"][:count] += 1
          else
            new_cart[food_item+" W/COUPON"] = {
                :price => coupon_hash[:cost],
                :clearance => info_hash[:clearance],
                :count => 1
            }
          end
        end
      end
    end
  end
   new_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |food_item, info_hash|
    if info_hash[:clearance] == true
      info_hash[:price] = (info_hash[:price]*0.8).round(2)
    end
  end
   cart
end

def checkout(cart, coupons)
  # code here
  total = 0.00
  cart = consolidate_cart(cart: cart)
  cart = apply_coupons(cart: cart, coupons: coupons)
  cart = apply_clearance(cart: cart)
   cart.each do |food_item, info_hash|
    unless info_hash[:count] == 0
      total += (info_hash[:price] * info_hash[:count])
    end
  end
   total > 100 ? total * 0.90 : total
end