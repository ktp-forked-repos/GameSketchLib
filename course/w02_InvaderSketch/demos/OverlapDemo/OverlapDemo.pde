 /*
  * OverlapDemo for InvaderSketch Tutorial
  *
  * video: http://www.youtube.com/playlist?list=PL9164D8831A48D0DE&feature=viewall
  *
  */
  
 class Bounds
 {
     public float x = 0;
     public float y = 0;
     public float w = 0;
     public float h = 0;

     Bounds(float x, float y, float w, float h)
     {
         this.x = x;
         this.y = y;
         this.w = w;
         this.h = h;
     }

     public float x2()
     {
         return this.x + this.w;
     }

     public float y2()
     {
         return this.y + this.h;
     }

     public boolean containsPoint(float x, float y)
     {
         return this.x <= x && x <= this.x2()
             && this.y <= y && y <= this.y2();
     }

     // http://stackoverflow.com/questions/306316/determine-if-two-Squares-overlap-each-other
     public boolean overlaps(Bounds that)
     {
         return (this.x < that.x2() && this.x2() > that.x &&
                 this.y < that.y2() && this.y2() > that.y);
     }

     /* exercise:
     public boolean contains(Bounds that)
     {
         return this.x <= that.x
             && this.y <= that.y
             && this.x2() >= that.x2()
             && this.y2() >= that.y2();
     }
     */
 }


 class Square extends Bounds
 {
     color fillColor = #FFFFFF;
     
     Square (float x, float y, float side)
     {
         super(x, y, side, side);
     }

     public void render()
     {
         fill(this.fillColor);
         rect(this.x, this.y, this.w, this.h);
     }
 }


 //========================================================

 final int kSquareCount = 9;
 Square[] mSquares = new Square[kSquareCount];

 final int kPerRow = 3;
 final int kNumRows = 3;
 // final int kSquareCount = kPerRow * kNumRows;

 void setup()
 {
     size(300, 300);
    
     /*
 
      // manual labor
      rect( 50, 50, 25, 25);
      
      rect(125, 50, 25, 25);
      rect(200, 50, 25, 25);
     
     
     // computer can do the work
     for (int i = 0; i < 3; ++i)
     {
         rect(75 * i + 50, 50, 25, 25);
     }
     
     // nested loop
     for (int i = 0; i < 3; ++i)
     {
         for (int j = 0; j < 3; ++j)
         {
             rect(75 * i + 50, 75 * j + 50, 25, 25);
         }
     }
     
     for (int i = 0; i < kSquareCount; ++i)
     {
         mSquares[i] = new Bounds(75 * i + 50, 50, 25, 25);
     }
     */

     // final version
     for (int i = 0; i < kNumRows; ++i)
     {
         for (int j = 0; j < kPerRow; ++j)
         {
             mSquares[i * kPerRow + j] = new Square(75 * i + 50, 75 * j + 50, 25);
         }
     }
 }

 void draw()
 {
     background(#3366FF);
     for (int i = 0; i < mSquares.length; ++i)
     {
         mSquares[i].fillColor = #FFFFFF;
     }
     
     for (int i = 0; i < mSquares.length; ++i)
     {
         for (int j = 0; j < mSquares.length; ++j)
         {
             if (j != i && mSquares[i].overlaps(mSquares[j]))
             {
                 mSquares[i].fillColor = #999999;
                 mSquares[j].fillColor = #999999;
             }
         }
         mSquares[i].render();
     }
 }

 Square mInHand = null;
 float mXOff;
 float mYOff;
 void mousePressed()
 {
     for (int i = 0; i < kSquareCount; ++i)
     {
         if (mSquares[i].containsPoint(mouseX, mouseY))
         {
             mXOff = mSquares[i].x - mouseX;
             mYOff = mSquares[i].y - mouseY;
             mInHand = mSquares[i];
             break;
         }
     }
 }

 void mouseReleased()
 {
     mInHand = null;
 }

 void mouseDragged()
 {
     /*
     if (mInHand != null)
     {
         mInHand.x = mouseX;
         mInHand.y = mouseY;
     }
     */
     if (mInHand != null)
     {
         mInHand.x = mouseX + mXOff;
         mInHand.y = mouseY + mYOff;
     }
 }
