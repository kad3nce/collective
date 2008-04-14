# See http://blog.jayfields.com/2007/11/ruby-testing-private-methods.html
class Class
  def publicize_methods(instance=nil)
    saved_private_instance_methods = self.private_instance_methods
    self.class_eval { public *saved_private_instance_methods }
    yield(instance)
  ensure
    self.class_eval { private *saved_private_instance_methods }
  end
end