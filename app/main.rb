# effect using blendmodes
# restricts the appearnce of a sprite
# to the non-transparent areas of another sprite

def tick args
  if args.tick_count.zero?

    # make a render target to contain the effect
    # add the background image (leaf)
    # this sprite must have transparent and non-transparent areas
    args.outputs[:effect].sprites << {
      x: 0,
      y: 0,
      w: 1280,
      h: 720,
      path: 'sprites/leaf-no-shadow.png',
    }
  end

  args.outputs.background_color = [0, 0, 0]

  # draw something behind the leaf so we can see where the splatter ends
  args.outputs.sprites << [args.inputs.mouse.x - 100, args.inputs.mouse.y - 100, 200, 200, :pixel ]

  # draw the foreground sprite if the mouse is down
  if args.inputs.mouse.button_left

    # draw at the mouse location
    x = args.inputs.mouse.x
    y = args.inputs.mouse.y

    # add to the render target, don't let it clear
    args.outputs[:effect].clear_before_render = false

    # draw the foreground sprite into the effect
    # IMPORTANT: BLENDMODE = 2 (additive blending)

    args.outputs[:effect].sprites << {
      x: x - 50,
      y: y - 50,
      w: 100,
      h: 100,
      path: :pixel,
      blendmode_enum: 2,
      r: 255,
      g: 0,
      b: 0,
    }

    # draw it again
    # IMPORTANT: BLENDMODE = 3 (color modulation)
  
    args.outputs[:effect].sprites << {
      x: x - 50,
      y: y - 50,
      w: 100,
      h: 100,
      path: :pixel,
      blendmode_enum: 3,
      r: 255,
      g: 0,
      b: 0,
    }
  end

  # output the leaf and the splatter
  args.outputs.sprites << [args.grid.rect, :effect]
end
