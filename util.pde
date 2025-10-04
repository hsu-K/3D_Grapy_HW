public void CGLine(float x1, float y1, float x2, float y2) {
    drawPoint(x1, y1, color(0, 0, 0));
   
    
     //stroke(0);
     //noFill();
     //line(x1-10,y1,x2-10,y2);
    float flag = 0;
    if(x1 <= x2 && y1 > y2){
        flag = 1;
        y2 = y1 + y1 - y2;
    }
    else if(x1 > x2 && y1 >= y2){
        flag = 2;
        x2 = x1 + (x1 - x2);
        y2 = y1 + (y1 - y2);
    }
    else if(x1 > x2 && y1 < y2){
        flag = 3;
        x2 = x1 + (x1 - x2);
    }
    
    float dx, dy, d, x, y, draw_x, draw_y;
    dy = y2 - y1;
    dx = x2 - x1;
    
    if(dy <= dx){
        d = dy - (dx / 2);
        x = x1;
        y = y1;
        for (; x < x2;){
            x += 1;
            
            // E is chosen
            if(d < 0){
                d = d + dy;
            }
            else{
                d = d + dy - dx;
                y += 1;
            }
            draw_x = x; draw_y = y;
            if(flag == 1){
                draw_y = y1 - (y - y1);
            }
            else if(flag == 2){
                draw_x = x1 - (x - x1);
                draw_y = y1 - (y - y1);
            }
            else if(flag == 3){
                draw_x = x1 - (x - x1);
            }
            drawPoint(draw_x, draw_y, color(0, 0, 0));
        }
    }
    else if( dx <= dy ){
        d = dx - (dy / 2);
        x = x1;
        y = y1;
        
        for(; y < y2;){
            y += 1;
            if(d < 0){
                d = d + dx;  
            }
            else{
              d = d + dx - dy;
              x += 1;
            }
            draw_x = x; draw_y = y;
            if(flag == 1){
                draw_y = y1 - (y - y1);
            }
            else if(flag == 2){
                draw_x = x1 - (x - x1);
                draw_y = y1 - (y - y1);
            }
            else if(flag == 3){
                draw_x = x1 - (x - x1);
            }
            drawPoint(draw_x, draw_y, color(0, 0, 0));
        }
    }
    
    
    // TODO HW1
    // You need to implement the "line algorithm" in this section.
    // You can use the function line(x1, y1, x2, y2); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    // For instance: drawPoint(114, 514, color(255, 0, 0)); signifies drawing a red
    // point at (114, 514).
     //stroke(0);
     //noFill();
     //line(x1,y1,x2,y2);

    /*
     stroke(0);
     noFill();
     line(x1,y1,x2,y2);
    */
}

public void CGCircle(float x, float y, float r) {
    // TODO HW1
    // You need to implement the "circle algorithm" in this section.
    // You can use the function circle(x, y, r); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).
    //println("x =", x, " y =", y, "r =", r);
    float P, xk, yk;
    P = 1 - r;
    xk = r; yk = 0;
    drawPoint(x + r, y, color(0, 0, 0));
    drawPoint(x, y + r, color(0, 0, 0));
    drawPoint(x - r, y, color(0, 0, 0));
    drawPoint(x, y - r, color(0, 0, 0));
    while(xk > yk){
        yk += 1;
        if(P <= 0){
            P = P + 2 * yk + 1;
        }
        else{
            xk -= 1;
            P = P + 2 * yk - 2 * xk + 1;
        }
        
        if (xk < yk){
            break;
        }
        drawPoint(x + xk, y - yk, color(0, 0, 0));
        drawPoint(x + yk, y - xk, color(0, 0, 0));
        
        drawPoint(x - xk, y - yk, color(0, 0, 0));
        drawPoint(x - yk, y - xk, color(0, 0, 0));
 
        drawPoint(x - xk, y + yk, color(0, 0, 0));
        drawPoint(x - yk, y + xk, color(0, 0, 0));
        
        drawPoint(x + xk, y + yk, color(0, 0, 0));
        drawPoint(x + yk, y + xk, color(0, 0, 0));
        
    }
    
    /*
    stroke(0);
    noFill();
    circle(x,y,r*2);
    */
}

public void CGEllipse(float x, float y, float r1, float r2) {
    // TODO HW1
    // You need to implement the "ellipse algorithm" in this section.
    // You can use the function ellipse(x, y, r1,r2); to verify the correct answer.
    // However, remember to comment out the function before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    ellipse(x,y,r1*2,r2*2);
    */

}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    // TODO HW1
    // You need to implement the "bezier curve algorithm" in this section.
    // You can use the function bezier(p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, p4.x,
    // p4.y); to verify the correct answer.
    // However, remember to comment out before you submit your homework.
    // Otherwise, you will receive a score of 0 for this part.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

    /*
    stroke(0);
    noFill();
    bezier(p1.x,p1.y,p2.x,p2.y,p3.x,p3.y,p4.x,p4.y);
    */
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    // TODO HW1
    // You need to erase the scene in the area defined by points p1 and p2 in this
    // section.
    // p1 ------
    // |       |
    // |       |
    // ------ p2
    // The background color is color(250);
    // You can use the mouse wheel to change the eraser range.
    // Utilize the function drawPoint(x, y, color) to apply color to the pixel at
    // coordinates (x, y).

}

public void drawPoint(float x, float y, color c) {
    stroke(c);
    point(x, y);
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}
