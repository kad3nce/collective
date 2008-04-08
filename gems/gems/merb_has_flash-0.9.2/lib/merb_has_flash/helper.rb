module MerbHasFlash
  module FlashHelperMixin
    def flash
      @web_controller.flash
    end
  end
end