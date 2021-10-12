#include <stdio.h>
#include <unistd.h>
#include <math.h>

#define SIZE  8192
#define KSIZE 8191 // Should be odd.

#define F_OVER_FS (0.0002)  // Cutoff frequency

static double kernel[KSIZE];

static double blackman(int i, int n) {
  double a0 = 0.42659;
  double a1 = 0.49656;
  double a2 = 0.076849;
  return  a0 - a1*cos(2*M_PI*i/n) + a2 * cos(4*M_PI*i/n);
}

static double sinc(int i, int n, double cutoff) {
   i -= KSIZE/2;
   if(i != 0) {
      double phase = 2*M_PI*i*F_OVER_FS;
      return sin(phase)/phase;
   }
   return 1.0;
}

static void buildKernel(void) {
   for(int i = 0; i < KSIZE; i++) {
      kernel[i] = sinc(i, KSIZE, F_OVER_FS);
      kernel[i] *= blackman(i, KSIZE);
   }

   // Set to gain of 1.0
   double total = 0.0;
   for(int i = 0; i < KSIZE; i++) {
      total += kernel[i];
   }
   for(int i = 0; i < KSIZE; i++) {
      kernel[i]/=total;
   }
}


static double filter(int center) {
   double total = 0.0;
   // Convert from center pos to kenel start
   for(int i = 0; i < KSIZE; i++) {
      int pos = center-KSIZE/2+i;
      if(pos < 0)
         total += -1.0*kernel[i];
      else if(pos == 0)
         total += 0.0;
      else
         total +=  1.0*kernel[i];
   }
   return total;
}

int main(int argc, char *argv[]) {
   buildKernel();
   for(int i = 0; i < SIZE; i++) {
      if((i&0xF) == 0)
         printf("        ");
      printf("x\"%04x\"", (int)(filter(i-SIZE/2)*28000)&0xFFFF);
      if(i != SIZE-1) putchar(',');
      putchar(((i&0xF)==0xF) ? '\n' : ' ');
   }
}
