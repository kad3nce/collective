module VersionSpecHelper
  Version.fixture {{
    :content => 17.random.words.join(' '),
    :content_html => RedCloth.new(17.random.words.join(' ')).to_html,
    :created_at => Time::now,
    :signature => 'muchlovefromdefensio'
  }}
  
  Version.fixture(:spam) {{
    :content => 17.random.words.join(' '),
    :content_html => RedCloth.new(17.random.words.join(' ')).to_html,
    :created_at => Time::now,
    :number => 1,
    :spam => true,
    :spamminess => 0.99,
    :signature => 'nolovefromdefensio'
  }}
  
  def valid_version_attributes
    {
      :content => "I have content!"
    }
  end
end
