require 'rubygems'
require 'bundler/setup'

require 'fox16'

include Fox
include Math

class Polygon < FXMainWindow
  
  def initialize(app)
    super(app, "Polygon", :width => 600, :height => 600)
    self.decorations = DECOR_TITLE|DECOR_MINIMIZE|DECOR_CLOSE
    
    @blue = FXRGB(1, 149, 255)
    @grey = FXRGB(122, 122, 122)
    
    @paris = FXFont.new(app, 'Calibri',  30 )
    @paris.create
    
    @f_title = FXFont.new(app, "VCROSDMono", 12, FXFont::Italic)
    @f_stitle = FXFont.new(app, "VCROSDMono", 20, FXFont::Bold)
    @f_title.create
    @f_stitle.create
  
    
    @canvas = FXCanvas.new(self, :opts => LAYOUT_FILL_X|LAYOUT_FILL_Y)
    @canvas.connect(SEL_PAINT) { |sender, sel, event|
      FXDCWindow.new(sender, event) { |dc|
        dc.setForeground(FXRGB(255, 255, 255))
        dc.fillRectangle(0, 0, 600, 600)
        dc.fillRule = RULE_EVEN_ODD
        drawPoly(dc)
        dc.font = @paris
        dc.drawText(250, 450, "Tower")
      }
    }
  end
  
  def drawPoly(dc)
    points = [
			   FXPoint.new(250, 250),
			   FXPoint.new(250, 350),
			   FXPoint.new(350, 350),
			   FXPoint.new(350, 250),
			   FXPoint.new(300, 200)
			  
			 ]
    if false
    n = 4
    points = Array.new(n , '1')
    angle = (PI * 2) / points.size
    points.each_with_index { |item, i|
        a = angle * i
        puts a * (180 / PI)
        x = 300 + cos(a) * 300
        y = 300 + sin(a) * 300
        points[i] = FXPoint.new(x.to_i, y.to_i)
    }
    end
    regio = FXRegion.new(points)
    dc.setForeground(@blue)
    dc.fillPolygon(points)
    dc.setForeground(@grey)
    dc.drawRectangle(regio.bounds.x, regio.bounds.y, regio.bounds.w, regio.bounds.h)
  end
  
  
  def create
    super
    @canvas.create
    show(PLACEMENT_SCREEN)
  end
  
end

if __FILE__ == $0
  
  FXApp.new("Polygon") do |app|
    Polygon.new(app)
    app.create
    app.run
  end
  
end