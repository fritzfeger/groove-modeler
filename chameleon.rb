# Chameleon Theme (Herbie Hancock)
# Coded by Fritz Feger w/ Sonic Pi

# To play: download Sonic Pi from the link below, paste the code in and hit Run
# http://sonic-pi.net

# =================================================================================
# Variables and functions for general use
# =================================================================================

use_bpm 96


# Mix -----------------------------------------------------------------------------

amp_bass = 0.6
pan_bass = 0.1

amp_drums = 1
pan_hihat = -0.2
pan_snare = 0.2

amp_git = 0.38
pan_git = -0.5

amp_clavi = 0.3
pan_clavi = 0.5

amp_horns = 0.7
pan_horns = 0


# Groove --------------------------------------------------------------------------

# split sleep 1 (one quarter note) into two halves with the first one = x percent
swing_percentage_8th = 51
e1 = swing_percentage_8th * 0.01
e2 = 1 - e1

# split sleep 0.5 (one eigth note) into two halves with the first one = x percent
swing_percentage_16th = 60
s1 = swing_percentage_16th * 0.005
s2 = 0.5 - s1


# =================================================================================
# Functions for the individual instruments
# =================================================================================

define :bass_upbeat do
  
  use_synth :dsaw
  
  release_long = 0.55
  release_short = 0.25
  
  with_fx :pan, pan: pan_bass do
    with_fx :distortion, mix: 0.16, amp: amp_bass do
      with_fx :wobble, mix: 0.5 do        
        play :G1, release: release_long
        sleep 0.5
        play :Ab1, release: release_long
        sleep 0.5
        play :A1, release: release_long
        sleep 0.5
      end
    end
  end
end


define :bass_4_beats_with_upbeat_bars do
  
  use_synth :dsaw
  
  release_long = 0.55
  release_short = 0.25
  
  with_fx :pan, pan: pan_bass do
    with_fx :distortion, mix: 0.16, amp: amp_bass, reps: 2 do
      with_fx :wobble, mix: 0.5 do
        
        play :Bb1, release: release_short
        sleep 0.75
        play :Ab2, release: release_short
        sleep 0.75
        play :Bb2, release: release_short
        sleep 0.5
        sleep 0.5
        play :C2, release: release_long
        sleep 0.5
        play :Db2, release: release_long
        sleep 0.5
        play :D2, release: release_long
        sleep 0.5
        
        play :Eb2, release: release_short
        sleep 0.75
        play :Bb2, release: release_short
        sleep 0.75
        play :Db3, release: release_short
        sleep 0.5
        sleep 0.5
        play :G1, release: release_long
        sleep 0.5
        play :Ab1, release: release_long
        sleep 0.5
        play :A1, release: release_long
        sleep 0.5
      end
    end
  end
end


define :dr_hihat do
  
  with_fx :pan, pan: pan_hihat do
    sample :drum_cymbal_closed, amp: 1.3
    sleep e1
    sample :drum_cymbal_closed, amp: 0.4
    sleep e2
  end
end


define :dr_bassdrum do
  
  drum_swing = 0.33
  
  3.times do
    sample :drum_bass_soft, amp: 1.2
    sleep 2
    sleep drum_swing
    sample :drum_bass_soft, amp: 0.6
    sleep 0.5 - drum_swing
    sample :drum_bass_soft
    sleep 1.50
  end
  1.times do
    sample :drum_bass_soft, amp: 1.2
    sleep 2
    sleep drum_swing
    sample :drum_bass_soft, amp: 0.6
    sleep 0.5 - drum_swing
    sample :drum_bass_soft, amp: 0.9
    sleep 0.5
    sample :drum_bass_soft, amp: 1
    sleep 0.5
    sample :drum_bass_soft, amp: 1.1
    sleep 0.5
  end
end


define :dr_snare do
  with_fx :pan, pan: pan_snare do
    sleep 0.8
    sample :drum_snare_hard, rate: 1.3
    sleep 0.2
    sleep 2
    sample :drum_snare_hard, rate: 1.3
    sleep 1
  end
end


define :drums_4_bars do
  with_fx :lpf, cutoff: 108, amp: amp_drums do
    in_thread do
      in_thread do
        16.times do
          dr_hihat
        end
      end
      1.times do
        dr_bassdrum
      end
    end
    4.times do
      dr_snare
    end
  end
end



define :git_upbeat do
  
  use_synth :fm
  
  with_fx :pan, pan: pan_git do
    with_fx :lpf, cutoff: 110, amp: amp_git do
      play :Eb5, release: 0.5
      sleep 1
    end
  end
end


define :git_4_bars do
  
  use_synth :fm
  
  release_short = 0.16
  
  with_fx :pan, pan: pan_git do
    with_fx :lpf, cutoff: 110, amp: amp_git, reps: 2 do
      
      play :Db5, release: 0.7
      sleep 0.5
      play :Bb4, release: release_short
      sleep 0.5
      
      play :Ab4, release: release_short
      sleep s1
      play :Ab4, release: release_short
      sleep s2
      play :Ab4, release: release_short
      sleep 0.5
      
      play :Ab4, release: release_short
      sleep s1
      play :Ab4, release: release_short
      sleep s2
      play :Ab4, release: release_short
      sleep s1
      play :Bb4, release: release_short
      sleep s2
      
      sleep 1
      
      play :Ab4, release: release_short
      sleep s1
      play :Ab4, release: release_short
      sleep s2
      play :Ab4, release: release_short
      sleep 0.5
      
      play :Ab4, release: release_short
      sleep s1
      play :Ab4, release: release_short
      sleep 0.5
      play :Ab4, release: release_short
      sleep s2
      
      sleep 1
      
      play :Eb5, release: 0.6
      sleep 1
      
    end
  end
end



define :clavi_upbeat do
  
  use_synth :pluck
  
  with_fx :pan, pan: pan_clavi do
    with_fx :nhpf, amp: amp_clavi do
      play chord_invert(chord(:Bb3, :minor), 1)
      sleep s2
    end
  end
end


define :clavi_4_bars do
  
  use_synth :pluck
  
  release_short = 0.2
  
  with_fx :pan, pan: pan_clavi do
    with_fx :nhpf, amp: amp_clavi do
      4.times do        
        sleep 0.5
        play chord_invert(chord(:Bb3, :minor), 1), release: release_short
        sleep 1
        play chord_invert(chord(:Bb3, :minor), 1), release: release_short
        sleep 0.5 + s1
        play [:Eb4, :G4, :C5], release: release_short
        sleep 0.5 + s2
        play chord_invert(chord(:Bb3, :minor), 1), release: release_short
        sleep 0.5 + s1
        play chord_invert(chord(:Bb3, :minor), 1)
        sleep s2
      end
    end
  end
end


define :horns_4_bars do
  
  use_synth :prophet
  
  with_fx :pan, pan: pan_horns do
    with_fx :reverb, amp: amp_horns, mix: 0.6 do
      play :Bb3
      sleep s1
      play :Bb3
      sleep s2
      sleep 0.5
      play :Ab3
      sleep s1
      play :Ab3
      sleep s2
      sleep 0.5
      play :Bb3
      sleep s1
      play :Bb3
      sleep s2
      sleep 0.5
      play :Db4, sustain: 0.8
      sleep 1
      play :Bb3
      sleep 3
      play :Bb3, sustain: 0.3
      sleep s1
      play :Ab3, sustain: 0.3
      sleep s2
      play :F3
      sleep s1
      play :Ab3, sustain: 0.7
      sleep s2
      
      sleep 0.5
      play :Bb3
      sleep 3
      play :Db4, sustain: 0.7
      sleep 1
      play :Eb4
      sleep 3.5
    end
  end
end


# =================================================================================
# Functions for parts
# =================================================================================

define :bass_4_beats_with_upbeat do
  bass_upbeat
  bass_4_beats_with_upbeat_bars
end


# ---------------------------------------------------------------------------------

define :b_dr do
  in_thread do
    in_thread do
      bass_4_beats_with_upbeat_bars
    end
    drums_4_bars
  end
end


define :plus_drums_4_bars_last_bar_upbeat_git do
  
  b_dr
  
  sleep 15  # 4 Takte mal 4 Schläge minus den letzten = Auftakt Gitarre
  git_upbeat
  
end


# ---------------------------------------------------------------------------------

define :dr_b_git do
  
  in_thread do
    in_thread do
      in_thread do
        bass_4_beats_with_upbeat_bars
      end
      in_thread do
        drums_4_bars
      end
    end
    in_thread do
      git_4_bars
    end
  end
end


define :plus_git do
  
  dr_b_git
  
  sleep 15.5 + s1
  clavi_upbeat
  
end


# ---------------------------------------------------------------------------------

define :plus_clavi do
  
  in_thread do
    dr_b_git
  end
  clavi_4_bars
end


# ---------------------------------------------------------------------------------

define :plus_horns do
  
  live_loop :begleitung do
    plus_clavi
  end
  live_loop :melodie do
    horns_4_bars
  end
  
end


# =================================================================================
# Abspielen der Formteile
# =================================================================================

bass_4_beats_with_upbeat
plus_drums_4_bars_last_bar_upbeat_git
plus_git
plus_clavi
plus_horns
