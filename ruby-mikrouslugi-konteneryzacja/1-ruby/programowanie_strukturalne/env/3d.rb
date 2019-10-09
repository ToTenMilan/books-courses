#
# Nazwa
#   matM
# Parametry
#   a
#   b
# Wynik
#   3x3 matrix*
#
def matM(a,b)
  p1,p2,p3,p4,p5,p6,p7,p8,p9 = 0.0
  p1 = a[0]*b[0] + a[1]*b[3] + a[2]*b[6]
  p2 = a[0]*b[1] + a[1]*b[4] + a[2]*b[7]
  p3 = a[0]*b[2] + a[1]*b[5] + a[2]*b[8]
  #
  p4 = a[3]*b[0] + a[4]*b[3] + a[5]*b[6]
  p5 = a[3]*b[1] + a[4]*b[4] + a[5]*b[7]
  p6 = a[3]*b[2] + a[4]*b[5] + a[5]*b[8]
  #
  p7 = a[6]*b[0] + a[7]*b[3] + a[8]*b[6]
  p8 = a[6]*b[1] + a[7]*b[4] + a[8]*b[7]
  p9 = a[6]*b[2] + a[7]*b[5] + a[8]*b[8]
  #
  return [
    p1,p2,p3,
    p4,p5,p6,
    p7,p8,p9
  ]
end # matM

#
# Nazwa
#   matMV
# Parametry
#   a
#   b
# Wynik
#   3e vector
#
def matMV(a,b)
  p1,p2,p3 = 0.0;
  #
  p1 = a[0]*b[0] + a[1]*b[1] + a[2]*b[2]
  p2 = a[3]*b[0] + a[4]*b[1] + a[5]*b[2]
  p3 = a[6]*b[0] + a[7]*b[1] + a[8]*b[2]
  #
  return [p1,p2,p3]
end # matMV

#
# Nazwa
#   matS
# Parametry
#   a
#   b
# Wynik
#   3e vector
#
def matS(a,b)
  return [
    a[0]-b[0], a[1]-b[1], a[2]-b[2]
  ]
end # matS

#
# Nazwa
#   getB
# Parametry
#   dx
#   dy
#   dz
# Wynik
#   2e vector
#
def getB(dx,dy,dz)
  newEntry = {x:0, y:0}
  ezDivDz = -700 / dz
  newEntry[:x] = -1*(dx*ezDivDz) + $canvasWidthHalf
  newEntry[:y] = dy*ezDivDz
  return newEntry
end # getB

#
# Nazwa
#   getM
# Parametry
#   th
# Wynik
#   3x3 matrix
#
def getM(th) 
  d1 = [
    1, 0,                  0                  ,
    0, Math.cos(th[:x]),   -1*Math.sin(th[:x]),
    0, Math.sin(th[:x]),   Math.cos(th[:x]) ]
  d2 = [
    Math.cos(th[:y]),      0, Math.sin(th[:y]),
    0,                     1, 0               ,
    -1*Math.sin(th[:y]),   0, Math.cos(th[:y])]
  d3 = [
    Math.cos(th[:z]),   -1*Math.sin(th[:z]),  0,
    Math.sin(th[:z]),   Math.cos(th[:z]),     0,
    0,                  0,                    1]
  #
  d1d2 = matM(d1,d2)
  newEntry = matM(d1d2,d3)
  #
  return newEntry
end # getM

#
# Nazwa
#   transform_3_into_2
# Parametry
#   x
#   y
#   z
#   cx
#   cy
#   cz
#   th
# Wynik
#   2e vector
#
def transform_3_into_2(x,y,z, cx,cy,cz, th)
  d_1x2x3 = getM(th)
  #
  d4 = [
    x,
    y,
    z
  ]
  d5 = [
    cx,
    cy,
    cz
  ]
  #
  d4subd5 = matS(d4,d5)
  d = matMV(d_1x2x3, d4subd5)
  b = getB(d[0],d[1],d[2])
  #
  $vertices_counter=$vertices_counter+1
  return b
end # transform_3_into_2
