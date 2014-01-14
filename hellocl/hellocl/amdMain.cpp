# include <iostream>
#include <string>

#if defined(__APPLE__) || defined(__MACOSX)
#include <OpenCL/cl.h>
#else
# include <CL/cl.h>
# endif

using namespace std;

#define KERNEL(...)# __VA_ARGS__

const char *kernelSourceCode = KERNEL(
__kernel void hellocl(__global uint *buffer) {
    size_t gidx = get_global_id(0); //列
    size_t gidy = get_global_id(1); //行
    size_t lidx = get_local_id(0);
    buffer[gidx + 4 * gidy] = (1 << gidx) | (0x10 << gidy);
});

int main() {
    cout<<"hello OpenCL"<<endl;
    cl_int status = 0;
    size_t deviceListSize = 0;

    cl_uint numPlatform;
    cl_platform_id platform = NULL;
    status = clGetPlatformIDs(0, NULL, &numPlatform);
    if (status != CL_SUCCESS) {
        cout<<"Error: Get Platforms"<<endl;
        return EXIT_FAILURE;
    }

    cout<<"numPlatform="<<numPlatform<<endl;

    if (numPlatform > 0) {
        cl_platform_id *platforms = new cl_platform_id[numPlatform];
        status = clGetPlatformIDs(numPlatform, platforms, NULL);
        if (status != CL_SUCCESS) {
            cout<<"Error: getting Platform Ids"<<endl;
            return EXIT_FAILURE;
        }
        for (int i = 0; i < numPlatform; ++i) {
            char pbuff[128];
            status = clGetPlatformInfo(platforms[i], CL_PLATFORM_VENDOR, sizeof(pbuff), pbuff, NULL);
            platform = platforms[i];
            cout<<"pbuff"<<i<<"="<<pbuff<<endl;
            if (!strcmp(pbuff, "Advanced Micro Devices, Inc.")) {
                break;
            }
        }
        delete[] platforms;
    }

    cl_context_properties cps[3] = {CL_CONTEXT_PLATFORM, (cl_context_properties)platform, 0};
    cl_context_properties *cprops = (platform == NULL) ? NULL : cps;

    cl_context context = clCreateContextFromType(cprops, CL_DEVICE_TYPE_GPU, NULL, NULL, &status);
    if (status != CL_SUCCESS) {
        cout<<"Error: Create Context"<<endl;
        return EXIT_FAILURE;
    }

    status = clGetContextInfo(context, CL_CONTEXT_DEVICES, 0, NULL, &deviceListSize);
    if (status != CL_SUCCESS) {
        cout<<"Error: Get Context Info"<<endl;
        return EXIT_FAILURE;
    }

    cout<<"DevicesListSize="<<deviceListSize<<endl;
    if (deviceListSize <= 0) {
        cout<<"Error: No devices found."<<endl;
        return EXIT_FAILURE;
    }

    cl_device_id *devices = new cl_device_id[deviceListSize];
    status = clGetContextInfo(context, CL_CONTEXT_DEVICES, deviceListSize, devices, NULL);
    if (status != CL_SUCCESS) {
        cout<<"Error: get context info devices error"<<endl;
        return EXIT_FAILURE;
    }

    char deviceName[1024];
    for (int idx = 0; idx < deviceListSize; ++idx) {
        clGetDeviceInfo(devices[idx], CL_DEVICE_NAME, 1024, deviceName, 0);
        cout<<"DeviceName"<<idx<<"="<<deviceName<<endl;
    }

//    clGetDeviceInfo(devices[0], CL_DEVICE_MAX_MEM_ALLOC_SIZE, 1024, deviceName, NULL);
//    cout<<"DeviceName idx=="<<deviceName<<endl;

    size_t sourceSize[] = {strlen(kernelSourceCode)};

    cl_program program = clCreateProgramWithSource(context, 1, &kernelSourceCode, sourceSize, &status);
    if (status != CL_SUCCESS) {
        cout<<"Error: loading Binary into cl_program"<<endl;
        return EXIT_FAILURE;
    }
    
    status = clBuildProgram(program, 1, devices, NULL, NULL, NULL);
    if (status != CL_SUCCESS) {
        cout<<"Error: Building Program"<<endl;
        return EXIT_FAILURE;
    }
    
    cl_kernel kernel = clCreateKernel(program, "hellocl", &status);
    if (status != CL_SUCCESS) {
        cout<<"Error: Createing Kernel from program: "<<status<<" "<< __FILE__<<" "<< __LINE__<<endl;
        return EXIT_FAILURE;
    }

    cl_command_queue commandQueue = clCreateCommandQueue(context, devices[0], 0, &status);
    if (status != CL_SUCCESS) {
        cout<<"Error: CreateCommandQueue"<<endl;
        return EXIT_FAILURE;
    }

    unsigned int *outBuffer = new unsigned int [4 * 4];
    memset(outBuffer, 0, 4 * 4 * 4);
    cl_mem outputBuffer = clCreateBuffer(context, CL_MEM_ALLOC_HOST_PTR, 4 * 4 * 4, NULL, &status);
    if (status != CL_SUCCESS) {
        cout<<"Error: clCreateBuffer"<<endl;
        return EXIT_FAILURE;
    }

    status = clSetKernelArg(kernel, 0, sizeof(cl_mem), (void *)&outputBuffer);
    if (status != CL_SUCCESS) {
        cout<<"Error: Setting kernel argument"<<endl;
        return EXIT_FAILURE;
    }

    size_t globalThreads[] = {4, 4};
    size_t localThreads[] = {2, 2};
    status = clEnqueueNDRangeKernel(commandQueue, kernel, 2, NULL, globalThreads, localThreads, 0, NULL, NULL);
    if (status != CL_SUCCESS) {
        cout<<"Error: Enqueueing kernel "<<status<<endl;
        return EXIT_FAILURE;
    }

    status = clFinish(commandQueue);
    if (status != CL_SUCCESS) {
        cout<<"Error: Finish Command Queue"<<endl;
        return EXIT_FAILURE;
    }

    status = clEnqueueReadBuffer(commandQueue, outputBuffer, CL_TRUE, 0, 4 * 4 * 4, outBuffer, 0, NULL, NULL);
    if (status != CL_SUCCESS) {
        cout<<"Error: Read buffer queue"<<endl;
        return EXIT_FAILURE;
    }

    cout<<"out:"<<endl;
    for (int idx = 0; idx < 16; ++idx) {
        printf("%x ", outBuffer[idx]);
        if ((idx + 1) % 4 == 0) {
            cout<<endl;
        }
    }

    status = clReleaseKernel(kernel);
    status = clReleaseProgram(program);
    status = clReleaseMemObject(outputBuffer);
    status = clReleaseCommandQueue(commandQueue);
    status = clReleaseContext(context);
    delete[] devices;
    delete outBuffer;

    return EXIT_SUCCESS;
}