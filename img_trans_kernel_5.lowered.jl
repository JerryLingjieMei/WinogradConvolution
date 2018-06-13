CodeInfo(:(begin
      nothing
      Core.NewvarNode(:(#temp#@_21))
      Core.SSAValue(0) = (Main.blockIdx)()
      Core.SSAValue(1) = (Base.getproperty)(Core.SSAValue(0), :y)
      Core.SSAValue(2) = Core.SSAValue(1) - 1
      Core.SSAValue(3) = (Main.blockDim)()
      Core.SSAValue(4) = (Base.getproperty)(Core.SSAValue(3), :x)
      Core.SSAValue(5) = Core.SSAValue(2) * Core.SSAValue(4)
      Core.SSAValue(6) = (Main.threadIdx)()
      Core.SSAValue(7) = (Base.getproperty)(Core.SSAValue(6), :x)
      Core.SSAValue(8) = Core.SSAValue(5) + Core.SSAValue(7)
      n = Core.SSAValue(8) - 1
      #= line 204 =#
      Core.SSAValue(9) = (Main.blockIdx)()
      Core.SSAValue(10) = (Base.getproperty)(Core.SSAValue(9), :z)
      k = Core.SSAValue(10) - 1
      #= line 205 =#
      Core.SSAValue(11) = (Main.threadIdx)()
      Core.SSAValue(12) = (Base.getproperty)(Core.SSAValue(11), :z)
      z = Core.SSAValue(12) - 1
      #= line 206 =#
      Core.SSAValue(13) = (Main.threadIdx)()
      Core.SSAValue(14) = (Base.getproperty)(Core.SSAValue(13), :y)
      y = Core.SSAValue(14) - 1
      #= line 207 =#
      Core.SSAValue(15) = (Main.blockIdx)()
      Core.SSAValue(16) = (Base.getproperty)(Core.SSAValue(15), :x)
      Core.SSAValue(17) = Core.SSAValue(16) - 1
      Core.SSAValue(18) = (Main.cld)(img_w, 8)
      Core.SSAValue(19) = (Main.divrem)(Core.SSAValue(17), Core.SSAValue(18))
      Core.SSAValue(20) = (Base.indexed_iterate)(Core.SSAValue(19), 1)
      t_h = (Core.getfield)(Core.SSAValue(20), 1)
      #temp#@_14 = (Core.getfield)(Core.SSAValue(20), 2)
      Core.SSAValue(21) = (Base.indexed_iterate)(Core.SSAValue(19), 2, #temp#@_14)
      t_w = (Core.getfield)(Core.SSAValue(21), 1)
      #temp#@_14 = (Core.getfield)(Core.SSAValue(21), 2)
      #= line 208 =#
      Core.SSAValue(22) = (CUDAnative.Val)(3)
      Core.SSAValue(23) = (Core.tuple)(32, 10, 10)
      Core.SSAValue(24) = (CUDAnative.Val)(Core.SSAValue(23))
      img_n = (CUDAnative.generate_static_shmem)(Core.SSAValue(22), $(Expr(:static_parameter, 1)), Core.SSAValue(24))
      #= line 209 =#
      Core.SSAValue(25) = (CUDAnative.Val)(4)
      Core.SSAValue(26) = (Core.tuple)(4, 4)
      Core.SSAValue(27) = (CUDAnative.Val)(Core.SSAValue(26))
      fil_k = (CUDAnative.generate_static_shmem)(Core.SSAValue(25), $(Expr(:static_parameter, 1)), Core.SSAValue(27))
      #= line 210 =#
      Core.SSAValue(28) = (Core.apply_type)(Main.MMatrix, 2, 2, $(Expr(:static_parameter, 1)))
      csum = (Main.zeros)(Core.SSAValue(28))
      #= line 211 =#
      Core.SSAValue(29) = (Core.apply_type)(Main.MMatrix, 4, 4, $(Expr(:static_parameter, 1)))
      temp = (Main.zeros)(Core.SSAValue(29))
      #= line 212 =#
      Core.SSAValue(30) = (Core.apply_type)(Main.MMatrix, 4, 4, $(Expr(:static_parameter, 1)))
      mid = (Main.zeros)(Core.SSAValue(30))
      #= line 213 =#
      Core.SSAValue(31) = 1:channels
      #temp#@_20 = (Base.iterate)(Core.SSAValue(31))
      Core.SSAValue(32) = #temp#@_20 === nothing
      Core.SSAValue(33) = (Base.not_int)(Core.SSAValue(32))
      unless Core.SSAValue(33) goto 401
      62: 
      Core.NewvarNode(:(#temp#@_30))
      Core.NewvarNode(:(#temp#@_31))
      Core.NewvarNode(:(#temp#@_32))
      Core.NewvarNode(:(#temp#@_33))
      Core.NewvarNode(:(#temp#@_34))
      Core.SSAValue(34) = #temp#@_20
      c = (Core.getfield)(Core.SSAValue(34), 1)
      Core.SSAValue(35) = (Core.getfield)(Core.SSAValue(34), 2)
      #= line 214 =#
      Core.SSAValue(36) = 0:4:8
      #temp#@_29 = (Base.iterate)(Core.SSAValue(36))
      Core.SSAValue(37) = #temp#@_29 === nothing
      Core.SSAValue(38) = (Base.not_int)(Core.SSAValue(37))
      unless Core.SSAValue(38) goto 174
      77: 
      Core.SSAValue(39) = #temp#@_29
      i@_43 = (Core.getfield)(Core.SSAValue(39), 1)
      Core.SSAValue(40) = (Core.getfield)(Core.SSAValue(39), 2)
      Core.SSAValue(41) = 0:4:8
      #temp#@_44 = (Base.iterate)(Core.SSAValue(41))
      Core.SSAValue(42) = #temp#@_44 === nothing
      Core.SSAValue(43) = (Base.not_int)(Core.SSAValue(42))
      unless Core.SSAValue(43) goto 167
      86: 
      Core.SSAValue(44) = i@_43
      Core.NewvarNode(:(x_h@_46))
      Core.NewvarNode(:(x_w@_47))
      i@_48 = Core.SSAValue(44)
      Core.SSAValue(45) = #temp#@_44
      j@_45 = (Core.getfield)(Core.SSAValue(45), 1)
      Core.SSAValue(46) = (Core.getfield)(Core.SSAValue(45), 2)
      #= line 215 =#
      Core.SSAValue(47) = z + j@_45
      Core.SSAValue(48) = Core.SSAValue(47) < 10
      unless Core.SSAValue(48) goto 101
      Core.SSAValue(49) = y + i@_48
      #temp#@_49 = Core.SSAValue(49) < 10
      goto 103
      101: 
      #temp#@_49 = false
      103: 
      unless #temp#@_49 goto 160
      #= line 216 =#
      Core.SSAValue(50) = 8 * t_h
      Core.SSAValue(51) = Core.SSAValue(50) + y
      Core.SSAValue(52) = Core.SSAValue(51) - 1
      x_h@_46 = Core.SSAValue(52) + i@_48
      #= line 217 =#
      Core.SSAValue(53) = 8 * t_w
      Core.SSAValue(54) = Core.SSAValue(53) + z
      Core.SSAValue(55) = Core.SSAValue(54) - 1
      x_w@_47 = Core.SSAValue(55) + j@_45
      #= line 218 =#
      Core.SSAValue(56) = 0 < x_w@_47
      unless Core.SSAValue(56) goto 120
      #temp#@_50 = x_w@_47 <= img_w
      goto 122
      120: 
      #temp#@_50 = false
      122: 
      unless #temp#@_50 goto 133
      Core.SSAValue(57) = 0 < x_h@_46
      unless Core.SSAValue(57) goto 128
      #temp#@_52 = x_h@_46 <= img_h
      goto 130
      128: 
      #temp#@_52 = false
      130: 
      #temp#@_51 = #temp#@_52
      goto 135
      133: 
      #temp#@_51 = false
      135: 
      unless #temp#@_51 goto 150
      #= line 219 =#
      Core.SSAValue(58) = n + 1
      Core.SSAValue(59) = x_w@_47
      Core.SSAValue(60) = x_h@_46
      Core.SSAValue(61) = (Base.getindex)(img, Core.SSAValue(58), Core.SSAValue(59), Core.SSAValue(60), c)
      Core.SSAValue(62) = img_n
      Core.SSAValue(63) = (Main.threadIdx)()
      Core.SSAValue(64) = (Base.getproperty)(Core.SSAValue(63), :x)
      Core.SSAValue(65) = Core.SSAValue(64) + 1
      Core.SSAValue(66) = z + j@_45 + 1
      Core.SSAValue(67) = y + i@_48 + 1
      (Base.setindex!)(Core.SSAValue(62), Core.SSAValue(61), Core.SSAValue(65), Core.SSAValue(66), Core.SSAValue(67))
      goto 160
      150: 
      #= line 221 =#
      Core.SSAValue(68) = (Main.zero)($(Expr(:static_parameter, 1)))
      Core.SSAValue(69) = img_n
      Core.SSAValue(70) = (Main.threadIdx)()
      Core.SSAValue(71) = (Base.getproperty)(Core.SSAValue(70), :x)
      Core.SSAValue(72) = Core.SSAValue(71) + 1
      Core.SSAValue(73) = z + j@_45 + 1
      Core.SSAValue(74) = y + i@_48 + 1
      (Base.setindex!)(Core.SSAValue(69), Core.SSAValue(68), Core.SSAValue(72), Core.SSAValue(73), Core.SSAValue(74))
      160: 
      #temp#@_44 = (Base.iterate)(Core.SSAValue(41), Core.SSAValue(46))
      Core.SSAValue(75) = Core.Intrinsics.not_int
      Core.SSAValue(76) = #temp#@_44 === nothing
      Core.SSAValue(77) = (Core.SSAValue(75))(Core.SSAValue(76))
      unless Core.SSAValue(77) goto 167
      goto 86
      167: 
      #temp#@_29 = (Base.iterate)(Core.SSAValue(36), Core.SSAValue(40))
      Core.SSAValue(78) = Core.Intrinsics.not_int
      Core.SSAValue(79) = #temp#@_29 === nothing
      Core.SSAValue(80) = (Core.SSAValue(78))(Core.SSAValue(79))
      unless Core.SSAValue(80) goto 174
      goto 77
      174: 
      #= line 225 =#
      Core.SSAValue(81) = (Main.threadIdx)()
      Core.SSAValue(82) = (Base.getproperty)(Core.SSAValue(81), :x)
      Core.SSAValue(83) = Core.SSAValue(82) == 1
      unless Core.SSAValue(83) goto 189
      #= line 226 =#
      Core.SSAValue(84) = k + 1
      Core.SSAValue(85) = z + 1
      Core.SSAValue(86) = y + 1
      Core.SSAValue(87) = (Base.getindex)(fil_trans, Core.SSAValue(84), Core.SSAValue(85), Core.SSAValue(86), c)
      Core.SSAValue(88) = fil_k
      Core.SSAValue(89) = z + 1
      Core.SSAValue(90) = y + 1
      (Base.setindex!)(Core.SSAValue(88), Core.SSAValue(87), Core.SSAValue(89), Core.SSAValue(90))
      189: 
      #= line 228 =#
      (Main.sync_threads)()
      #= line 229 =#
      Core.SSAValue(91) = 1:4
      #temp#@_30 = (Base.iterate)(Core.SSAValue(91))
      Core.SSAValue(92) = #temp#@_30 === nothing
      Core.SSAValue(93) = (Base.not_int)(Core.SSAValue(92))
      unless Core.SSAValue(93) goto 244
      198: 
      Core.SSAValue(94) = #temp#@_30
      i@_40 = (Core.getfield)(Core.SSAValue(94), 1)
      Core.SSAValue(95) = (Core.getfield)(Core.SSAValue(94), 2)
      Core.SSAValue(96) = 1:4
      #temp#@_39 = (Base.iterate)(Core.SSAValue(96))
      Core.SSAValue(97) = #temp#@_39 === nothing
      Core.SSAValue(98) = (Base.not_int)(Core.SSAValue(97))
      unless Core.SSAValue(98) goto 237
      207: 
      Core.SSAValue(99) = i@_40
      i@_42 = Core.SSAValue(99)
      Core.SSAValue(100) = #temp#@_39
      j@_41 = (Core.getfield)(Core.SSAValue(100), 1)
      Core.SSAValue(101) = (Core.getfield)(Core.SSAValue(100), 2)
      #= line 230 =#
      Core.SSAValue(102) = img_n
      Core.SSAValue(103) = (Main.threadIdx)()
      Core.SSAValue(104) = (Base.getproperty)(Core.SSAValue(103), :x)
      Core.SSAValue(105) = Core.SSAValue(104) + 1
      Core.SSAValue(106) = (Main.threadIdx)()
      Core.SSAValue(107) = (Base.getproperty)(Core.SSAValue(106), :z)
      Core.SSAValue(108) = Core.SSAValue(107) - 1
      Core.SSAValue(109) = 2 * Core.SSAValue(108)
      Core.SSAValue(110) = Core.SSAValue(109) + j@_41
      Core.SSAValue(111) = (Main.threadIdx)()
      Core.SSAValue(112) = (Base.getproperty)(Core.SSAValue(111), :y)
      Core.SSAValue(113) = Core.SSAValue(112) - 1
      Core.SSAValue(114) = 2 * Core.SSAValue(113)
      Core.SSAValue(115) = Core.SSAValue(114) + i@_42
      Core.SSAValue(116) = (Base.getindex)(Core.SSAValue(102), Core.SSAValue(105), Core.SSAValue(110), Core.SSAValue(115))
      (Base.setindex!)(temp, Core.SSAValue(116), j@_41, i@_42)
      230: 
      #temp#@_39 = (Base.iterate)(Core.SSAValue(96), Core.SSAValue(101))
      Core.SSAValue(117) = Core.Intrinsics.not_int
      Core.SSAValue(118) = #temp#@_39 === nothing
      Core.SSAValue(119) = (Core.SSAValue(117))(Core.SSAValue(118))
      unless Core.SSAValue(119) goto 237
      goto 207
      237: 
      #temp#@_30 = (Base.iterate)(Core.SSAValue(91), Core.SSAValue(95))
      Core.SSAValue(120) = Core.Intrinsics.not_int
      Core.SSAValue(121) = #temp#@_30 === nothing
      Core.SSAValue(122) = (Core.SSAValue(120))(Core.SSAValue(121))
      unless Core.SSAValue(122) goto 244
      goto 198
      244: 
      #= line 232 =#
      Core.SSAValue(123) = 1:4
      #temp#@_31 = (Base.iterate)(Core.SSAValue(123))
      Core.SSAValue(124) = #temp#@_31 === nothing
      Core.SSAValue(125) = (Base.not_int)(Core.SSAValue(124))
      unless Core.SSAValue(125) goto 282
      251: 
      Core.SSAValue(126) = #temp#@_31
      i@_38 = (Core.getfield)(Core.SSAValue(126), 1)
      Core.SSAValue(127) = (Core.getfield)(Core.SSAValue(126), 2)
      #= line 233 =#
      Core.SSAValue(128) = (Base.getindex)(temp, 1, i@_38)
      Core.SSAValue(129) = (Base.getindex)(temp, 3, i@_38)
      Core.SSAValue(130) = Core.SSAValue(128) - Core.SSAValue(129)
      (Base.setindex!)(mid, Core.SSAValue(130), 1, i@_38)
      #= line 234 =#
      Core.SSAValue(131) = (Base.getindex)(temp, 2, i@_38)
      Core.SSAValue(132) = (Base.getindex)(temp, 3, i@_38)
      Core.SSAValue(133) = Core.SSAValue(131) + Core.SSAValue(132)
      (Base.setindex!)(mid, Core.SSAValue(133), 2, i@_38)
      #= line 235 =#
      Core.SSAValue(134) = (Base.getindex)(temp, 3, i@_38)
      Core.SSAValue(135) = (Base.getindex)(temp, 2, i@_38)
      Core.SSAValue(136) = Core.SSAValue(134) - Core.SSAValue(135)
      (Base.setindex!)(mid, Core.SSAValue(136), 3, i@_38)
      #= line 236 =#
      Core.SSAValue(137) = (Base.getindex)(temp, 2, i@_38)
      Core.SSAValue(138) = (Base.getindex)(temp, 4, i@_38)
      Core.SSAValue(139) = Core.SSAValue(137) - Core.SSAValue(138)
      (Base.setindex!)(mid, Core.SSAValue(139), 4, i@_38)
      275: 
      #temp#@_31 = (Base.iterate)(Core.SSAValue(123), Core.SSAValue(127))
      Core.SSAValue(140) = Core.Intrinsics.not_int
      Core.SSAValue(141) = #temp#@_31 === nothing
      Core.SSAValue(142) = (Core.SSAValue(140))(Core.SSAValue(141))
      unless Core.SSAValue(142) goto 282
      goto 251
      282: 
      #= line 238 =#
      Core.SSAValue(143) = 1:4
      #temp#@_32 = (Base.iterate)(Core.SSAValue(143))
      Core.SSAValue(144) = #temp#@_32 === nothing
      Core.SSAValue(145) = (Base.not_int)(Core.SSAValue(144))
      unless Core.SSAValue(145) goto 328
      289: 
      Core.SSAValue(146) = #temp#@_32
      i@_37 = (Core.getfield)(Core.SSAValue(146), 1)
      Core.SSAValue(147) = (Core.getfield)(Core.SSAValue(146), 2)
      #= line 239 =#
      Core.SSAValue(148) = (Base.getindex)(mid, i@_37, 1)
      Core.SSAValue(149) = (Base.getindex)(mid, i@_37, 3)
      Core.SSAValue(150) = Core.SSAValue(148) - Core.SSAValue(149)
      Core.SSAValue(151) = (Base.getindex)(fil_k, i@_37, 1)
      Core.SSAValue(152) = Core.SSAValue(150) * Core.SSAValue(151)
      (Base.setindex!)(temp, Core.SSAValue(152), i@_37, 1)
      #= line 240 =#
      Core.SSAValue(153) = (Base.getindex)(mid, i@_37, 2)
      Core.SSAValue(154) = (Base.getindex)(mid, i@_37, 3)
      Core.SSAValue(155) = Core.SSAValue(153) + Core.SSAValue(154)
      Core.SSAValue(156) = (Base.getindex)(fil_k, i@_37, 2)
      Core.SSAValue(157) = Core.SSAValue(155) * Core.SSAValue(156)
      (Base.setindex!)(temp, Core.SSAValue(157), i@_37, 2)
      #= line 241 =#
      Core.SSAValue(158) = (Base.getindex)(mid, i@_37, 3)
      Core.SSAValue(159) = (Base.getindex)(mid, i@_37, 2)
      Core.SSAValue(160) = Core.SSAValue(158) - Core.SSAValue(159)
      Core.SSAValue(161) = (Base.getindex)(fil_k, i@_37, 3)
      Core.SSAValue(162) = Core.SSAValue(160) * Core.SSAValue(161)
      (Base.setindex!)(temp, Core.SSAValue(162), i@_37, 3)
      #= line 242 =#
      Core.SSAValue(163) = (Base.getindex)(mid, i@_37, 2)
      Core.SSAValue(164) = (Base.getindex)(mid, i@_37, 4)
      Core.SSAValue(165) = Core.SSAValue(163) - Core.SSAValue(164)
      Core.SSAValue(166) = (Base.getindex)(fil_k, i@_37, 4)
      Core.SSAValue(167) = Core.SSAValue(165) * Core.SSAValue(166)
      (Base.setindex!)(temp, Core.SSAValue(167), i@_37, 4)
      321: 
      #temp#@_32 = (Base.iterate)(Core.SSAValue(143), Core.SSAValue(147))
      Core.SSAValue(168) = Core.Intrinsics.not_int
      Core.SSAValue(169) = #temp#@_32 === nothing
      Core.SSAValue(170) = (Core.SSAValue(168))(Core.SSAValue(169))
      unless Core.SSAValue(170) goto 328
      goto 289
      328: 
      #= line 244 =#
      Core.SSAValue(171) = 1:4
      #temp#@_33 = (Base.iterate)(Core.SSAValue(171))
      Core.SSAValue(172) = #temp#@_33 === nothing
      Core.SSAValue(173) = (Base.not_int)(Core.SSAValue(172))
      unless Core.SSAValue(173) goto 359
      335: 
      Core.SSAValue(174) = #temp#@_33
      i@_36 = (Core.getfield)(Core.SSAValue(174), 1)
      Core.SSAValue(175) = (Core.getfield)(Core.SSAValue(174), 2)
      #= line 245 =#
      Core.SSAValue(176) = (Base.getindex)(temp, 1, i@_36)
      Core.SSAValue(177) = (Base.getindex)(temp, 2, i@_36)
      Core.SSAValue(178) = (Base.getindex)(temp, 3, i@_36)
      Core.SSAValue(179) = Core.SSAValue(176) + Core.SSAValue(177) + Core.SSAValue(178)
      (Base.setindex!)(mid, Core.SSAValue(179), 1, i@_36)
      #= line 246 =#
      Core.SSAValue(180) = (Base.getindex)(temp, 2, i@_36)
      Core.SSAValue(181) = (Base.getindex)(temp, 3, i@_36)
      Core.SSAValue(182) = Core.SSAValue(180) - Core.SSAValue(181)
      Core.SSAValue(183) = (Base.getindex)(temp, 4, i@_36)
      Core.SSAValue(184) = Core.SSAValue(182) - Core.SSAValue(183)
      (Base.setindex!)(mid, Core.SSAValue(184), 2, i@_36)
      352: 
      #temp#@_33 = (Base.iterate)(Core.SSAValue(171), Core.SSAValue(175))
      Core.SSAValue(185) = Core.Intrinsics.not_int
      Core.SSAValue(186) = #temp#@_33 === nothing
      Core.SSAValue(187) = (Core.SSAValue(185))(Core.SSAValue(186))
      unless Core.SSAValue(187) goto 359
      goto 335
      359: 
      #= line 248 =#
      Core.SSAValue(188) = 1:2
      #temp#@_34 = (Base.iterate)(Core.SSAValue(188))
      Core.SSAValue(189) = #temp#@_34 === nothing
      Core.SSAValue(190) = (Base.not_int)(Core.SSAValue(189))
      unless Core.SSAValue(190) goto 394
      366: 
      Core.SSAValue(191) = #temp#@_34
      i@_35 = (Core.getfield)(Core.SSAValue(191), 1)
      Core.SSAValue(192) = (Core.getfield)(Core.SSAValue(191), 2)
      #= line 249 =#
      Core.SSAValue(193) = (Base.getindex)(csum, i@_35, 1)
      Core.SSAValue(194) = (Base.getindex)(mid, i@_35, 1)
      Core.SSAValue(195) = (Base.getindex)(mid, i@_35, 2)
      Core.SSAValue(196) = (Base.getindex)(mid, i@_35, 3)
      Core.SSAValue(197) = Core.SSAValue(194) + Core.SSAValue(195) + Core.SSAValue(196)
      Core.SSAValue(198) = Core.SSAValue(193) + Core.SSAValue(197)
      (Base.setindex!)(csum, Core.SSAValue(198), i@_35, 1)
      #= line 250 =#
      Core.SSAValue(199) = (Base.getindex)(csum, i@_35, 2)
      Core.SSAValue(200) = (Base.getindex)(mid, i@_35, 2)
      Core.SSAValue(201) = (Base.getindex)(mid, i@_35, 3)
      Core.SSAValue(202) = Core.SSAValue(200) - Core.SSAValue(201)
      Core.SSAValue(203) = (Base.getindex)(mid, i@_35, 4)
      Core.SSAValue(204) = Core.SSAValue(202) - Core.SSAValue(203)
      Core.SSAValue(205) = Core.SSAValue(199) + Core.SSAValue(204)
      (Base.setindex!)(csum, Core.SSAValue(205), i@_35, 2)
      387: 
      #temp#@_34 = (Base.iterate)(Core.SSAValue(188), Core.SSAValue(192))
      Core.SSAValue(206) = Core.Intrinsics.not_int
      Core.SSAValue(207) = #temp#@_34 === nothing
      Core.SSAValue(208) = (Core.SSAValue(206))(Core.SSAValue(207))
      unless Core.SSAValue(208) goto 394
      goto 366
      394: 
      #temp#@_20 = (Base.iterate)(Core.SSAValue(31), Core.SSAValue(35))
      Core.SSAValue(209) = Core.Intrinsics.not_int
      Core.SSAValue(210) = #temp#@_20 === nothing
      Core.SSAValue(211) = (Core.SSAValue(209))(Core.SSAValue(210))
      unless Core.SSAValue(211) goto 401
      goto 62
      401: 
      #= line 253 =#
      Core.SSAValue(212) = 1:2
      #temp#@_21 = (Base.iterate)(Core.SSAValue(212))
      Core.SSAValue(213) = #temp#@_21 === nothing
      Core.SSAValue(214) = (Base.not_int)(Core.SSAValue(213))
      unless Core.SSAValue(214) goto 467
      408: 
      Core.SSAValue(215) = #temp#@_21
      i@_23 = (Core.getfield)(Core.SSAValue(215), 1)
      Core.SSAValue(216) = (Core.getfield)(Core.SSAValue(215), 2)
      Core.SSAValue(217) = 1:2
      #temp#@_22 = (Base.iterate)(Core.SSAValue(217))
      Core.SSAValue(218) = #temp#@_22 === nothing
      Core.SSAValue(219) = (Base.not_int)(Core.SSAValue(218))
      unless Core.SSAValue(219) goto 460
      417: 
      Core.SSAValue(220) = i@_23
      i@_27 = Core.SSAValue(220)
      Core.SSAValue(221) = #temp#@_22
      j@_24 = (Core.getfield)(Core.SSAValue(221), 1)
      Core.SSAValue(222) = (Core.getfield)(Core.SSAValue(221), 2)
      #= line 254 =#
      Core.SSAValue(223) = 8 * t_w
      Core.SSAValue(224) = (Main.threadIdx)()
      Core.SSAValue(225) = (Base.getproperty)(Core.SSAValue(224), :z)
      Core.SSAValue(226) = Core.SSAValue(225) - 1
      Core.SSAValue(227) = 2 * Core.SSAValue(226)
      x_w@_25 = Core.SSAValue(223) + Core.SSAValue(227) + j@_24
      #= line 255 =#
      Core.SSAValue(228) = 8 * t_h
      Core.SSAValue(229) = (Main.threadIdx)()
      Core.SSAValue(230) = (Base.getproperty)(Core.SSAValue(229), :y)
      Core.SSAValue(231) = Core.SSAValue(230) - 1
      Core.SSAValue(232) = 2 * Core.SSAValue(231)
      x_h@_26 = Core.SSAValue(228) + Core.SSAValue(232) + i@_27
      #= line 256 =#
      Core.SSAValue(233) = x_w@_25 <= img_w
      unless Core.SSAValue(233) goto 442
      #temp#@_53 = x_h@_26 <= img_h
      goto 444
      442: 
      #temp#@_53 = false
      444: 
      unless #temp#@_53 goto 453
      #= line 257 =#
      Core.SSAValue(234) = (Base.getindex)(csum, j@_24, i@_27)
      Core.SSAValue(235) = n + 1
      Core.SSAValue(236) = x_w@_25
      Core.SSAValue(237) = x_h@_26
      Core.SSAValue(238) = k + 1
      (Base.setindex!)(dest, Core.SSAValue(234), Core.SSAValue(235), Core.SSAValue(236), Core.SSAValue(237), Core.SSAValue(238))
      453: 
      #temp#@_22 = (Base.iterate)(Core.SSAValue(217), Core.SSAValue(222))
      Core.SSAValue(239) = Core.Intrinsics.not_int
      Core.SSAValue(240) = #temp#@_22 === nothing
      Core.SSAValue(241) = (Core.SSAValue(239))(Core.SSAValue(240))
      unless Core.SSAValue(241) goto 460
      goto 417
      460: 
      #temp#@_21 = (Base.iterate)(Core.SSAValue(212), Core.SSAValue(216))
      Core.SSAValue(242) = Core.Intrinsics.not_int
      Core.SSAValue(243) = #temp#@_21 === nothing
      Core.SSAValue(244) = (Core.SSAValue(242))(Core.SSAValue(243))
      unless Core.SSAValue(244) goto 467
      goto 408
      467: 
      #= line 260 =#
      return
  end))
