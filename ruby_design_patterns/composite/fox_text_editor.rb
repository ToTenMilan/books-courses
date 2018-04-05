require 'rubygems'
require 'fox'


include Fox

app = FXApp.new("CompositeGUI", "CompositeGUI") # composite
main_window = FXMainWindow.new(app, "Composite", nil, nil, DECOR_ALL) # composite
main_window.width = 400
main_window.height = 200

super_frame = FXVerticalFrame.new(main_window, LAYOUT_FILL_X|LAYOUT_FILL_Y) # composite
FXLabel.new(super_frame, "Text Editor App") # leaf

text_editor = FXHorizontalFrame.new(super_frame, LAYOUT_FILL_X, LAYOUT_FILL_Y) # composite
text = FXText.new(text_editor, nil, 0, TEXT_READONLY|TEXT_WORDWRAP|LAYOUT_FILL_X|LAYOUT_FILL_Y) # leaf
text.text = "some text" # leaf

button_frame = FXVerticalFrame.new(text_editor, LAYOUT_SIDE_RIGHT|LAYOUT_FILL_Y) # composite
FXButton.new(button_frame, "Cut") # leaf
FXButton.new(button_frame, "Copy") # leaf
FXButton.new(button_frame, "Paste") # leaf


app.create
main_window.show(PLACEMENT_SCREEN)
app.run