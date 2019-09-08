
class Yolo
  p self
  p self.class
  def yolo
    p self
    p self.class
    def bang
      p self
      p self.class
    end

    bang
  end
end

Yolo.new.yolo