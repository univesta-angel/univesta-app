class OrderController < ApplicationController
  def index
    shop_url = "https://2d69dfd97a185d97d49cb4b85de5e76f:1cd78cc392fe8861b891a3f881b3c5d8@gels-store.myshopify.com/admin"
    ShopifyAPI::Base.site = shop_url
    shop = ShopifyAPI::Shop.current
    
    @orders = ShopifyAPI::Order.find(:all, params: { financial_status: 'paid' })
    
  end
  
  def aliexp
    browser = Watir::Browser.new :chrome
  	browser.goto "https://www.aliexpress.com/item/2015-Winter-Womens-Parka-Casual-Outwear-Military-Hooded-Coat-Winter-Jacket-Women-Fur-Coats-Women-Overcoat/32396095026.html?spm=2114.01010108.3.1.AcvjFJ&ws_ab_test=searchweb0_0,searchweb201602_4_10065_10068_10502_10504_433_10136_10137_10060_20502_10062_20504_10056_10055_10054_302_10059_10099_10103_10102_10096_10052_10053_10050_10107_10051_10106_10084_10083_10119_10080_10082_10081_10110_10111_10112_10113_10114_10078_10079_10073_10070_10122_10123_10120_10126_10124-20504_20502_10502_10504_10119_10110,searchweb201603_3,afswitch_1_afChannel,ppcSwitch_4,single_sort_0_default&btsid=0235f896-5224-43a6-ad0c-bba31155089d&algo_expid=7506f105-cbb6-42f5-baab-99e0ffbc435e-0&algo_pvid=7506f105-cbb6-42f5-baab-99e0ffbc435e"
  	browser.img(title: "Black").click
    browser.link(text: "S").click
    browser.link(id: "j-add-cart-btn").click

    sleep 1

    browser.link(class: "ui-button").click

    sleep 1

    browser.link(class: "product-buy-only").click

    sleep 1

    browser.text_field(name: "email").set "email@example.com"
    browser.text_field(name: "contactPerson").set "Angel Santiago"
    browser.select_list(name: "country").select("United States")
    browser.text_field(name: "address").set "273 West 16th St."
    browser.select_list(class: "ui-textfield ui-textfield-system sa-error-field").select("Illinois")
    browser.text_field(name: "city").set "Chicago Heights"
    browser.text_field(name: "zip").set "60411"
    browser.text_field(name: "mobileNo").set "1000000000"
  end
end
