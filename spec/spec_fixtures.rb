# =========
# = Pages =
# =========
# Page.fixture(:page) {{
#   :name => 'good page',
#   :id => 1,
# }}
# 
Page.fixture(:page_with_several_versions) {{
  :name => 'good page',
  :versions => 7.of {Version.make}
}}

# ============
# = Versions =
# ============
Version.fixture {{
  :content => @sentence = /[:sentence]/.gen,
  :content_html => RedCloth.new(@sentence).to_html,
  :created_at => Time::now,
  :signature => 'muchlovefromdefensio'
}}

Version.fixture(:spam) {{
  :content => @sentence = /[:sentence]/.gen,
  :content_html => RedCloth.new(@sentence).to_html,
  :created_at => Time::now,
  :spam => true,
  :spaminess => 0.99,
  :signature => 'nolovefromdefensio'
}}