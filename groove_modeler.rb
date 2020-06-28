# Groove Modeler for Sonic Pi

tempo = 40
repeat = 4  # slow tempo = few repeats, fast tempo = many repeats
swing_8th_percent = 50

live_loop :swing do
  
  first_8th = swing_8th_percent * 0.01  # from percent to factor
  second_8th = 1 - first_8th  # long and short eigth always sum up to one quarter note
  
  print 'tempo = ' + tempo.to_s
  print 'swing % = ' + swing_8th_percent.to_s
  
  repeat.times do  # this block is one beat -> 4.times is one 4/4 bar
    use_bpm tempo  # will be changed on every loop
    sample :drum_cymbal_closed, amp: 1.0
    sleep first_8th
    sample :drum_cymbal_closed, amp: 0.6
    sleep second_8th
  end
  
  use_bpm 60  # fixed tempo to make the break between loops equally long
  sleep 4  # two seconds before it continues with a new tempo
  
  # speeding up
  if tempo <= 320
    tempo = tempo + 20
  else
    tempo = 40
  end
  
  # more repetitions with more speed
  repeat = tempo / 10
  
  # swing percentage rises after one complete speeding up run
  if tempo == 340
    swing_8th_percent = swing_8th_percent + 10
  else
    if swing_8th_percent == 90
      swing_8th_percent = 50
    end
  end
  
end
