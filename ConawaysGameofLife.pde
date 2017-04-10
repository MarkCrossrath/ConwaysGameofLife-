/*
 if the cell is alive
   if < 2 neighbours, the cell dies
   if 2 or 3 neighbours it survives
   if > 3 neighbours, it dies due to overcrowding
 if the cell is dead
   if it has exactly 3 neighbours it comes back to life
*/

boolean paused = false;

int countNeighbours(int row, int col)
{
  int count = 0;
  
  // Put your code in here...
  // Top left
  if ((row > 0) && (col > 0) && (board[row - 1][col -1]))
  {
    count ++;
  }
  // Top
  if ((row > 0) && board[row -1][col])
  {
    count ++;
  }
  // Top right
  if ((row > 0) && (col < (boardWidth - 1)) && (board[row -1][col + 1]))
  {
    count ++;
  }
  // Left
  if ((col > 0) && (board[row][col -1]))
  {
    count ++;
  }
  // Right
  if ((col < (boardWidth -1)) && board[row][col + 1])
  {
    count ++;
  }
  // Bottom left
  if ((col > 0) && (row < (boardHeight - 1)) 
    && board[row + 1][col - 1])
  {
    count ++;
  }
  // Bottom
  if ((row < (boardHeight -1)) && (board[row + 1][col]))
  {
    count ++;
  }
  // Bottom right
  if ((col < (boardWidth - 1)) && (row < (boardHeight - 1)) 
    && board[row + 1][col + 1])
  {
    count ++;
  }
  return count;
}

void setup()
{
  size(500, 500);
  boardWidth = width / cellWidth;
  boardHeight = height / cellHeight;
  board = new boolean[boardHeight][boardWidth];
  next = new boolean[boardHeight][boardWidth];
  randomise(); 
}

boolean[][] board;
boolean[][] next;
int cellWidth = 5;
int cellHeight = 5;
int boardWidth;
int boardHeight;
color c = color(0, 0, 0);

void randomise()
{
  for (int row = 0 ; row < boardHeight ; row ++)
  {
    for (int col = 0 ; col < boardWidth ; col ++)
    {
      float f = random(0, 1);
      if (f > 0.5f)
      {
        board[row][col] = true;
      }
    }
  }
}

void keyPressed()
{
  paused = ! paused;
}

void update()
{
  
  if (! paused)
  {
    for (int row = 0 ; row < boardHeight ; row ++)
    {
      for (int col = 0 ; col < boardWidth ; col ++)
      {
        int count = countNeighbours(row, col);
        next[row][col] = false;
        if (board[row][col])
        {
          if (count<2)
          {
            next[row][col] = false;
          } 
          else if ((count == 2) || (count == 3))
          {
            next[row][col] = true;
          }
          else if (count > 3)
          {
            next[row][col] = false;
          }
        }
        else
        {
          if (count == 3)
          {
            next[row][col] = true;
          }
        }
      }
    }
    boolean[][] temp = board;
  board = next;
  next = temp;
  }  
}

void draw()
{
  background(c);
  
  update();
  for (int row = 0 ; row < boardHeight ; row ++)
  {
    for (int col = 0 ; col < boardWidth ; col ++)
    {
      int x = cellWidth * col;
      int y = cellHeight * row;
      if (board[row][col])
       {
         color blue= color(0,255,0);
         color red = color(0,0,0);
         color c = lerpColor(blue,red,0.5);
         fill(c);         
       } 
       else
       {
         fill(0);         
       }
       rect(x, y, cellWidth, cellHeight);
    }
  }
}