

def find_item_by_name_in_collection(name, collection)
 collection.each do |hash_item| 
  if name == hash_item[:item] 
    return hash_item     
  end
 end
 nil
# i = 0 
# while i < collection.size
#   if  name == collection[i][:item] 
#     return collection[i]
#   else
#     nil
#   end
#   i+=1
# end
end


def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  newcart = []
  cart.map do |hash_item|
    if !find_item_by_name_in_collection(hash_item[:item],newcart)
       hash_item [:count]=1
       newcart << hash_item
    else
      hash_item [:count]+=1
      newcart<< hash_item
    end
  end
  newcart
end

#   newcart = []
#   i=0
#   while i<cart.size 
#   if ! find_item_by_name_in_collection(cart[i][:item],newcart)
#       cart[i][:count]= 1
#       newcart<< cart[i]
#   else
#     cart[i][:count]+=1
#     newcart<< cart[i]
#   end
#   i+=1
# end
#   newcart
# end

# def apply_coupons(cart, coupons)
#   # Consult README for inputs and outputs
#   # REMEMBER: This method **should** update cart
#  i=0 
#  while i<coupons.size
#   itemincart =  find_item_by_name_in_collection(coupons[i][:item], cart)
#   itemincart[:item] = "#{:item}W/COUPON"
#   itemincart[:price] = coupons[i][:price]
#   itemincart[:count] = 
#   i+=1
#  end
# end
def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length do 
   
    #look for item in the coupon in the cart, else will be nil 
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
   
    #lookup the couponed item in the cart to see if it exists already, else it will be nil
    cart_item_with_coupon = find_item_by_name_in_collection("#{coupons[i][:item]} W/COUPON", cart)
   
    #if the coupon item exists in the cart and they have enough to use the coupon
    if cart_item && cart_item[:count] >= coupons[i][:num]
      
      #if the couponed item already exists (numerous coupons) then + to the couponed amount, and - from retail amount
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      #else if the couponed item doesnt exist yet, create it, and - the couponed amount from the retail amount
      else
        cart_item_with_coupon = {
          :item => "#{coupons[i][:item]} W/COUPON",
          :price => coupons[i][:cost] / coupons[i][:num],
          :clearance => cart_item[:clearance],
          :count => coupons[i][:num]}
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end
      
    end
    i += 1  
  end
  cart
end

def apply_clearance(cart)
  index=0
  while index<cart.size 
    if cart[index][:clearance]
      cart[index][:price]= (cart[index][:price] - (cart[index][:price]* 0.20)).round(2)
    
    end
    index+=1
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

  consi_cart = consolidate_cart(cart)
  copo_cart = apply_coupons(consi_cart,coupons)
  final_cart = apply_clearance(copo_cart)
 
  index=0
  total=0
  while index < final_cart.size
     total += final_cart[index][:price] * final_cart[index][:num]
    index+=1
  end
  if total > 100
     total -= (total * 0.10)
  end
  total
end


