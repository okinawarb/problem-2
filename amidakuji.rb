# encoding: utf-8
require 'pp'

class Amidakuji
  def initialize(number)
    @id = "A"
    @number = number.to_i
     @height = 20          # あみだくじの高さ
     @line_flag = true
    @line_pos = Array.new(@number-1,0)
    @result = ""
  end

  @id = @id.next
  # 一番上のIDを描画
  def render_name
    @number.times do
      @result += "#{@id}  "
      next_id
    end
    @result += "\n"
  end

  # 縦線を描画
  def render_lines(y)
    @number.times do |x|
      @result += "|"
      if rand < 0.5 && @line_flag && x+1 != @number
        @result += "--"
        @line_pos[x] += 1
        @line_flag = false
      else
        @result += "  "
        @line_flag = true
      end
    end
    @result += "\n"
  end

  def render_atari
    atari = rand(@number)
    @number.times do |n|
      if n == atari
        @result += "*  "
      else
        @result += "   "
      end
    end
    @result += "\n"
  end

  # あみだくじを描画
  def render_amida
    render_name
    @height.times do |y|
      render_lines(y)
    end
    render_atari
    p @line_pos
    # もし横線が無いラインがある場合は再描画
    if @line_pos.include?(0)
      puts "だめパターン(横線が無い場所があります。)"
      puts @result
      initialize(@number)
      render_amida
    else
      puts @result
    end
  end
end

a = Amidakuji.new(ARGV[0])
a.render_amida
