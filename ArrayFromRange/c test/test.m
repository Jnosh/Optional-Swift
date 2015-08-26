//
//  main.c
//  c test
//
//  Created by Janosch Hildebrand on 12/02/15.
//  Copyright (c) 2015 Janosch Hildebrand. All rights reserved.
//

@import Foundation;

void *testC(NSInteger n) {
    NSInteger *array = malloc(n * sizeof(NSInteger));
    for (NSInteger i = 0; i < n; i++) {
        *(array + i) = i;
    }

    free(array);
    // Trick the compiler into not optimizing this away
    return array;
}


