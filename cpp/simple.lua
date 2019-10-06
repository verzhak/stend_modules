
function main(src)

--	ch = { split(src) }

--	thr_1 = { threshold(ch[1], 150, 0), threshold(ch[2], 170, 0), threshold(ch[3], 145, 0) }
--	thr_2 = { threshold(thr_1[1], 110, 1), threshold(thr_1[2], 130, 1), threshold(thr_1[3], 115, 1) }

--	b1 = bitwise_and(thr_2[1], thr_2[2])
--	b2 = bitwise_and(b1, thr_2[3])

--	res = algo("simple", src, b2, 220)
	res = algo("simple", src, src, 220)
--	dst = combine(res, 0.5, src, 0.5)

	return res

end

