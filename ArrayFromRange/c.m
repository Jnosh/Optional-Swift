//
//  main.c
//  c test
//
//  Created by Janosch Hildebrand on 12/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

@import Foundation;

void testC(NSInteger n) {
    NSInteger *array = malloc(n * sizeof(NSInteger));
    memset_s(array, n * sizeof(NSInteger), 0, n * sizeof(NSInteger));
    free(array);
}


