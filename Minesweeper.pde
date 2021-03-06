
import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    //your code to declare and initialize buttons goes here
    bombs = new ArrayList <MSButton> ();
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < 20;row++)
    {
        for(int col = 0; col < 20;col++)
        {
            buttons[row][col] = new MSButton(row,col);
        }
    }

    while(bombs.size() < 30)
    {
        setBombs();
    }
    
    //setBombs();
}
public void setBombs()
{
    //your code
   int boxR = (int)(Math.random()*NUM_ROWS);
   int boxC = (int)(Math.random()*NUM_COLS);
   if(!bombs.contains(buttons[boxR][boxC]))
   {
        bombs.add(buttons[boxR][boxC]);
        //System.out.println(boxR + ", " + boxC);
   }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int row = 0; row < NUM_ROWS; row++)
        for(int col = 0; col < NUM_COLS;col++)
            if(buttons[row][col].isClicked() == false)
            {
                return false;
            }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int row = 0; row < NUM_ROWS; row++)
        for(int col = 0; col < NUM_COLS;col++)
            if(!buttons[row][col].isClicked() == true && bombs.contains(buttons[row][col]))
                buttons[row][col].clicked = true;
    String lose = new String("You Lose!!!!");
    for(int i = 0; i < lose.length();i++)
        buttons[6][i+6].setLabel(lose.substring(i,i+1));


}
public void displayWinningMessage()
{
    //your code here
    String win = new String("You Win!!!");
    for(int i = 0; i < win.length();i++)
    {
        buttons[9][i+9].setLabel(win.substring(i,i+1));
    }
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
       clicked = true;
        //your code here
       if(keyPressed == true || mousePressed && (mouseButton == RIGHT))
       {
            
            if(marked == false)
            {
                marked = true;
                clicked = true;

            }
            else if(marked == true)
            {
                clicked = false;
                marked = false;
            }
       }
       else if(bombs.contains(this))
       {
            displayLosingMessage();
       }
        else if(countBombs(r,c) > 0)
        {
            setLabel("" + countBombs(r,c));
        }  
        else
        {
            if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
                buttons[r][c-1].mousePressed();
            if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
                buttons[r][c+1].mousePressed();
            if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
                buttons[r-1][c].mousePressed();
            if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
                buttons[r+1][c].mousePressed();
            if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
                buttons[r+1][c+1].mousePressed();
            if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
                buttons[r-1][c-1].mousePressed();
            if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
                buttons[r+1][c-1].mousePressed();
            if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
                buttons[r-1][c+1].mousePressed();
        }
           

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if((r >= 0 && r < NUM_ROWS) && (c >= 0 && c < NUM_COLS))
        {
            return true;
        }
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(r,c+1) == true && bombs.contains(buttons[r][c+1]))
            numBombs++;
        if(isValid(r+1,c+1) == true && bombs.contains(buttons[r+1][c+1]))
            numBombs++;
        if(isValid(r-1,c+1) == true && bombs.contains(buttons[r-1][c+1]))
            numBombs++;
        if(isValid(r+1,c) == true && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if(isValid(r-1,c) == true && bombs.contains(buttons[r-1][c]))
            numBombs++;
        if(isValid(r+1,c-1) == true && bombs.contains(buttons[r+1][c-1]))
            numBombs++;
        if(isValid(r,c-1) == true && bombs.contains(buttons[r][c-1]))
            numBombs++;
        if(isValid(r-1,c-1) == true && bombs.contains(buttons[r-1][c-1]))
            numBombs++;
        
        return numBombs;
    }
}