//
//  bezier.h
//  splines
//
//  Created by Oluwapelumi on 5/15/17.
//  Copyright © 2017 Oluwapelumi. All rights reserved.
//

#ifndef bezier_h
#define bezier_h

//////////////////////////////////////////////////////////
CGPoint midPoint(CGPoint p1, CGPoint p2){
    return CGPointMake(0.5*(p1.x+p2.x), 0.5*(p1.y+p2.y));
}

/*depending on the level of subdivision as given by the expression 4+3*(2^l - 1), where l is the number of iteration level*/


/*@brief    This function does a bezier subdivision
 *@detail   This function will do a bezeir subdivision on the supplied input array, it assumes there are four   \
 control point structs in the array as required for a bezeir subdivision. The output array must also \
 make provision for the new output points
 *@param    input[]         Array of input points
 *@param    output[]        Output array where subdivision points will be placed
 *@param    i_start_index   Where zero index should be assumed by the subdivide function in accessing the input array
 *@param    o_start_index   Where zero index should be assumed by the subdivide function in accessing the output array
 */
void subdivide (CGPoint input[], CGPoint output[], const int i_start_index, const int iter_level){
    const int half_index = i_start_index+3*pow(2, iter_level-1);
    
    const int o_start_index = i_start_index;    //Consequence of inplace algorithm, they always coincide
    int i_end_index = i_start_index+3;
    int o_end_index = half_index+3;
    
    CGPoint tempPoint = midPoint(input[i_start_index+1], input[i_start_index+2]);
    
    output[o_start_index] = input[i_start_index];
    output[o_end_index] = input[i_end_index];
    
    output[o_start_index+1] = midPoint(input[i_start_index], input[i_start_index+1]);
    output[o_end_index-1] = midPoint(input[i_end_index-1], input[i_end_index]);
    
    output[o_start_index+2] = midPoint(output[o_start_index+1], tempPoint);
    output[o_end_index-2] = midPoint(tempPoint, output[o_end_index-1]);
    
    output[o_start_index+3] = midPoint(output[o_start_index+2], output[o_end_index-2]);
    output[o_end_index-3] = output[o_start_index+3];    //Consequence of inplace algorithm, the two indexes don't necesarily coincide
    
}

void r_sub(CGPoint output[], int iter_no, const int start){
    if (iter_no == 0) return;
    subdivide(output, output, start, iter_no--);
    r_sub(output, iter_no, start);
    r_sub(output, iter_no, start+(3*(int)pow(2, iter_no)));
}


void subdivide_n (CGPoint input[], CGPoint output[], int iter_no, const int start, const int end){
    assert(end-start == 3);
    for (int i = 0; i < 4; i++)
        output[i] = input[i];
    r_sub(output, iter_no, start);
}

int output_size_for_4_points(int iteration){
    return 4+3*((int)pow(2, iteration)-1);
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#endif /* bezier_h */
