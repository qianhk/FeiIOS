
#include <string>
#include <iostream>

#if defined(__APPLE__) || defined(__MACOSX)
#include <OpenCL/cl.h>
#else
#include <CL/cl.h>
#endif

using namespace std;

int mainCpu() {

    const int size = 1234567;
    float* src_a_h = new float[size];
    float* src_b_h = new float[size];
    float* res_h = new float[size];
// Initialize both vectors
    for (int i = 0; i < size; ++i) {
        src_a_h[i] = src_b_h[i] = (float) i;
    }

    for (int i=0; i < size; ++i) {
        res_h[i] = src_a_h[i] + src_b_h[i];
    }

    float total = 0;
    for (int i=0; i < size; ++i) {
        total += res_h[i];
    }

    cout<<"total="<<total<<endl;

    return 0;
}
