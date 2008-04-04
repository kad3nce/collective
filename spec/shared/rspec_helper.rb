# Allows for easy mocking of models.
# 
# ==== Arguments
# +model_class+<Class>:: the name of the class you wish to mock
# +options_and_stubs+<Hash>:: 
#   any additional methods you wish to stub out on the model
# 
# ==== Returns
# An RSpec mock.
# 
# ==== Examples
# A mock with no extra options:
# 
#   > mock = mock_model(Post)
#   > mock.is_a?(Post)
#   => true
# 
# A mock with extra options:
# 
#   > mock = mock_model(Post, :permalink => "From mocking!")
#   > puts mock.permalink
#   => "From mocking!"
#--
# Based on code from RSpec for Rails.
def mock_model(model_class, options_and_stubs={})
  
  options_and_stubs = {
    :id          => rand(1000), 
    :new_record? => false, 
    :errors      => stub("errors", :count => 0)
  }.update(options_and_stubs)
  
  m = mock([model_class.name, options_and_stubs[:id]].join("_"), options_and_stubs)
  
  m.send(:__mock_proxy).instance_eval <<-CODE
    def @target.is_a?(other)
      #{model_class}.ancestors.include?(other)
    end
    def @target.kind_of?(other)
      #{model_class}.ancestors.include?(other)
    end
    def @target.instance_of?(other)
      other == #{model_class}
    end
    def @target.class
      #{model_class}
    end
  CODE
  
  yield(m) if block_given?
  
  return m
  
end