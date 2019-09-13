require 'markaby'

html = Markaby::Builder.new do
  head { title "My wonderful home page" }
  body do
    h1 'welcome to my homepage'
    b 'my hobbies'
    ul do
      li 'yolooing'
      li 'banging'
      li 'damning'
    end
  end
end

p html