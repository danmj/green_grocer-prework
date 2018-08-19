def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each { |grocery| grocery.each { |product,values| consolidated_cart[product] = {price: values[:price], clearance: values[:clearance], count: cart.count(grocery)} } }
  consolidated_cart
end

def apply_coupons(cart:[], coupons:[])
  # code here	  coupons_applied = {}
  coupons.each do |coupon|
    if cart.key?(coupon[:item])
      coupon_count = 0
      until coupon[:num] > cart[coupon[:item]][:count]
        cart[coupon[:item]][:count] -= coupon[:num]
        cart["#{coupon[:item]} W/COUPON"] = {price: coupon[:cost], clearance: cart[coupon[:item]][:clearance], count: coupon_count += 1}
      end
    end
  end
  cart.merge(coupons_applied)
end	end