def getIdx(lst, idx, pos):
  match lst:
    case List/Nil:
      return 0
    case List/Cons:
      if pos == idx:
        return lst.head
      else:
        return getIdx(lst.tail, idx, pos+1)


def rmIdxInner(lst, rmIdx, thisIdx):
  match lst:
    case List/Nil:
      return List/Nil
    case List/Cons:
      if rmIdx == thisIdx:
        return lst.tail
      else:
        newIdx = thisIdx+1
        return List/Cons(lst.head, rmIdxInner(lst.tail, rmIdx, newIdx))


def rmIdxOuter(lst, rmRow, rmCol, thisIdx):
  newIdx = thisIdx+1
  match lst:
    case List/Nil:
      return List/Nil
    case List/Cons:
      if rmRow == thisIdx:
        return rmIdxOuter(lst.tail, rmRow, rmCol, newIdx)
      else:
        newRow = rmIdxInner(lst.head, rmCol, 0) 
        newIdx = thisIdx+1
        return List/Cons(newRow, rmIdxOuter(lst.tail, rmRow, rmCol, newIdx))

def doCofactors(mat, col, sign, size):
  if col == size:
    return +0
  else:
    newSize = size - 1
    nextCol = col + 1
    nextSign = -1 * sign
    newMat = rmIdxOuter(mat, 0, col, 0)
    thisRow = getIdx(mat, 0, 0)
    thisScalar = sign * getIdx(thisRow, col, 0) 
    return  thisScalar * getDet(newMat, newSize) + doCofactors(mat, nextCol, nextSign, size)

def getDet(mat, size):
  match mat:
    case List/Nil:
      return +0
    case List/Cons:
      if size == 1:
        return getIdx(mat.head, 0, 0)
      else:
        return doCofactors(mat, 0, +1, size)

def main():
{{{mat}}}
  return getDet(mat, {{{size}}}) 
