public void CGLine(float x1, float y1, float x2, float y2) {
    // TODO HW1
    // Please paste your code from HW1 CGLine.
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
}

public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height)
        return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int) y * width + (int) x;
    if (outOfBoundary(x, y))
        return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
    // TODO HW2 
    // You need to check the coordinate p(x,v) if inside the vertices. 
    // If yes return true, vice versa.
    //float i = 1;
    //for(Vector3 p: vertexes){
    //    println(i, p.x, p.y, p.z);
    //    i = i + 1;
    //} 
    boolean inside = false;
    int vertexnum = vertexes.length;
    int j = vertexnum - 1;
    for(int i = 0 ; i < vertexnum ; i++){
        float xi = vertexes[i].x;
        float yi = vertexes[i].y;
        float xj = vertexes[j].x;
        float yj = vertexes[j].y;
        
        if(((yi > y) != (yj > y)) && (x < (xj - xi) * (y - yi) / (yj - yi) + xi)) {
            inside = !inside;
        }
        j = i;
    }
    return inside;
}

public Vector3[] findBoundBox(Vector3[] v) {
    
    
    // TODO HW2 
    // You need to find the bounding box of the vertices v.
    // r1 -------
    //   |   /\  |
    //   |  /  \ |
    //   | /____\|
    //    ------- r2

    Vector3 recordminV = new Vector3(0);
    Vector3 recordmaxV = new Vector3(999);
    Vector3[] result = { recordminV, recordmaxV };
    for(Vector3 p: v){
        if(p.x < result[1].x) result[1].x = p.x;
        if(p.y < result[1].y) result[1].y = p.y;
        if(p.z < result[1].z) result[1].z = p.z;
        
        if(p.x > result[0].x) result[0].x = p.x;
        if(p.y > result[0].y) result[0].y = p.y;
        if(p.z > result[0].z) result[0].z = p.z;
    }
    Vector3 temp = result[0];
    result[0] = result[1];
    result[1] = temp;
    //println(result[0].x, result[0].y, result[0].z);
    //println(result[1].x, result[1].y, result[1].z);
    
    return result;

}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input = new ArrayList<Vector3>();
    ArrayList<Vector3> output = new ArrayList<Vector3>();
    for (int i = 0; i < points.length; i += 1) {
        input.add(points[i]);
    }

    // TODO HW2
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertices of the "boundary".
    // The output is the vertices of the polygon.
    //int ii = 1;
    //for(Vector3 p: input){
    //    println(ii, p.x, p.y, p.z);
    //    ii += 1;
    //}

    for(int i = 0; i < boundary.length ; i++){
        output = new ArrayList<>(input);  
        int pre = output.size() - 1;
        input.clear();
        for(int j = 0; j < output.size() ; j++){
            boolean p1_inside = false;
            boolean p2_inside = false;
            
 
            if( i == 0 ){
                if(output.get(pre).x >= boundary[i].x) p1_inside = true;
                if(output.get(j).x >= boundary[i].x) p2_inside = true;
            }
            else if (i == 1){
                if(output.get(pre).y <= boundary[i].y) p1_inside = true;
                if(output.get(j).y <= boundary[i].y) p2_inside = true;   
            }
            else if (i == 2){
                if(output.get(pre).x <= boundary[i].x) p1_inside = true;
                if(output.get(j).x <= boundary[i].x) p2_inside = true;   
            }
            else if (i == 3){
                if(output.get(pre).y >= boundary[i].y) p1_inside = true;
                if(output.get(j).y >= boundary[i].y) p2_inside = true;   
            }
            
            if(p1_inside == true && p2_inside == true){
                input.add(output.get(j));
            }
            else if(p1_inside == true && p2_inside == false){
                input.add(intersection(output.get(pre), output.get(j), boundary[i], boundary[(i+1)%4]));
            }
            else if(p1_inside == false && p2_inside == true){
                input.add(intersection(output.get(pre), output.get(j), boundary[i], boundary[(i+1)%4]));

                input.add(output.get(j));  
          }
          
          pre = j;
        }
    }
    output = input;

    Vector3[] result = new Vector3[output.size()];
    for (int i = 0; i < result.length; i += 1) {
        result[i] = output.get(i);
    }
    return result;
}

public Vector3 intersection(Vector3 S, Vector3 E, Vector3 A, Vector3 B){
    float dx1 = E.x - S.x;
    float dy1 = E.y - S.y;
    float dx2 = B.x - A.x;
    float dy2 = B.y - A.y;

    float t = ((A.x - S.x) * dy2 - (A.y - S.y) * dx2) / (dx1 * dy2 - dy1 * dx2);
    return new Vector3(S.x + t * dx1, S.y + t * dy1, 0);
}
