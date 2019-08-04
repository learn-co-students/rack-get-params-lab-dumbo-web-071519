class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    else
      resp.write "Path Not Found"
    end

    if req.path.match(/cart/)
      if @@cart.count != 0
        @@cart.each {|item| resp.write "#{item}\n"}
      else
        resp.write "Your cart is empty"
      end
    end

    if req.path.match(/add/)
      item_add = req.params["item"]
      resp.write handle_cart(item_add)
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def handle_cart(item)
    if @@items.include? item
        @@cart << item
        "added #{item}"
      else
        "We don't have that item"
      end
  end
end
