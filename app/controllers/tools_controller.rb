class ToolsController < ApplicationController
  def mobile_quotation
    quotations = Quotation.all(:conditions => "status=2", :order => "mobile_id,quotation_date desc")
    m = 0
    @oo = ""
    quotations.each do |quotation|
      if (m!=quotation.mobile_id)
        m = quotation.mobile_id
        mq = Mquotation.find_by_mobile_id(m)
        if !mq || mq.price != quotation.quotation_price
          if mq
            mq.price = quotation.quotation_price
            mq.date = quotation.quotation_date
          else
            mq = Mquotation.new
            mq.mobile_id = m
            mq.price = quotation.quotation_price
            mq.date = quotation.quotation_date
          end
          mq.save!

          mobile = Mobile.find(m)
          if mobile && mobile.price <= mq.price
            @oo << "<br /><b> #{mobile.model} Mobile</b> price #{mobile.price} update to #{mq.price}"
            mobile.price = mq.price + 100
            mobile.save
          end
          @oo << "<br /> ID:#{m}, Price:#{quotation.quotation_price}"
        end
      end
    end
  end

end
