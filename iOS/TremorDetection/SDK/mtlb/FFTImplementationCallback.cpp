//
// File: FFTImplementationCallback.cpp
//
// MATLAB Coder version            : 5.1
// C/C++ source code generated on  : 01-Dec-2021 20:21:40
//

// Include Files
#include "FFTImplementationCallback.h"
#include "rt_nonfinite.h"
#include <cmath>
#include <cstring>

// Function Definitions
//
// Arguments    : const creal_T x_data[]
//                const int x_size[1]
//                int n1_unsigned
//                const double costab_data[]
//                const double sintab_data[]
//                creal_T y_data[]
//                int y_size[1]
// Return Type  : void
//
namespace coder
{
  namespace internal
  {
    namespace fft
    {
      void FFTImplementationCallback::b_r2br_r2dit_trig(const creal_T x_data[],
        const int x_size[1], int n1_unsigned, const double costab_data[], const
        double sintab_data[], creal_T y_data[], int y_size[1])
      {
        double temp_im;
        double temp_re;
        double twid_im;
        double twid_re;
        int i;
        int iDelta2;
        int iheight;
        int istart;
        int ix;
        int iy;
        int ju;
        int k;
        int nRowsD2;
        y_size[0] = n1_unsigned;
        if (n1_unsigned > x_size[0]) {
          y_size[0] = n1_unsigned;
          if (0 <= n1_unsigned - 1) {
            std::memset(&y_data[0], 0, n1_unsigned * sizeof(creal_T));
          }
        }

        iheight = x_size[0];
        if (iheight >= n1_unsigned) {
          iheight = n1_unsigned;
        }

        istart = n1_unsigned - 2;
        nRowsD2 = n1_unsigned / 2;
        k = nRowsD2 / 2;
        ix = 0;
        iy = 0;
        ju = 0;
        for (i = 0; i <= iheight - 2; i++) {
          bool tst;
          y_data[iy] = x_data[ix];
          iDelta2 = n1_unsigned;
          tst = true;
          while (tst) {
            iDelta2 >>= 1;
            ju ^= iDelta2;
            tst = ((ju & iDelta2) == 0);
          }

          iy = ju;
          ix++;
        }

        y_data[iy] = x_data[ix];
        if (n1_unsigned > 1) {
          for (i = 0; i <= istart; i += 2) {
            double im;
            double re;
            twid_re = y_data[i + 1].re;
            temp_re = twid_re;
            twid_im = y_data[i + 1].im;
            temp_im = twid_im;
            re = y_data[i].re;
            im = y_data[i].im;
            twid_re = re - twid_re;
            y_data[i + 1].re = twid_re;
            twid_im = im - twid_im;
            y_data[i + 1].im = twid_im;
            y_data[i].re = re + temp_re;
            y_data[i].im = im + temp_im;
          }
        }

        iy = 2;
        iDelta2 = 4;
        iheight = ((k - 1) << 2) + 1;
        while (k > 0) {
          int temp_re_tmp;
          for (i = 0; i < iheight; i += iDelta2) {
            temp_re_tmp = i + iy;
            temp_re = y_data[temp_re_tmp].re;
            temp_im = y_data[temp_re_tmp].im;
            y_data[temp_re_tmp].re = y_data[i].re - temp_re;
            y_data[temp_re_tmp].im = y_data[i].im - temp_im;
            y_data[i].re += temp_re;
            y_data[i].im += temp_im;
          }

          istart = 1;
          for (ix = k; ix < nRowsD2; ix += k) {
            twid_re = costab_data[ix];
            twid_im = sintab_data[ix];
            i = istart;
            ju = istart + iheight;
            while (i < ju) {
              temp_re_tmp = i + iy;
              temp_re = twid_re * y_data[temp_re_tmp].re - twid_im *
                y_data[temp_re_tmp].im;
              temp_im = twid_re * y_data[temp_re_tmp].im + twid_im *
                y_data[temp_re_tmp].re;
              y_data[temp_re_tmp].re = y_data[i].re - temp_re;
              y_data[temp_re_tmp].im = y_data[i].im - temp_im;
              y_data[i].re += temp_re;
              y_data[i].im += temp_im;
              i += iDelta2;
            }

            istart++;
          }

          k /= 2;
          iy = iDelta2;
          iDelta2 += iDelta2;
          iheight -= iy;
        }

        if (y_size[0] > 1) {
          twid_re = 1.0 / static_cast<double>(y_size[0]);
          iy = y_size[0];
          for (iDelta2 = 0; iDelta2 < iy; iDelta2++) {
            y_data[iDelta2].re *= twid_re;
            y_data[iDelta2].im *= twid_re;
          }
        }
      }

      //
      // Arguments    : const double x_data[]
      //                const int x_size[1]
      //                creal_T y_data[]
      //                int nrowsx
      //                int nRows
      //                int nfft
      //                const creal_T wwc_data[]
      //                const int wwc_size[1]
      //                const double costab_data[]
      //                const int costab_size[2]
      //                const double sintab_data[]
      //                const double costabinv_data[]
      //                const double sintabinv_data[]
      // Return Type  : void
      //
      void FFTImplementationCallback::doHalfLengthBluestein(const double x_data[],
        const int x_size[1], creal_T y_data[], int nrowsx, int nRows, int nfft,
        const creal_T wwc_data[], const int wwc_size[1], const double
        costab_data[], const int costab_size[2], const double sintab_data[],
        const double costabinv_data[], const double sintabinv_data[])
      {
        static creal_T c_y_data[2400];
        static creal_T tmp_data[2400];
        creal_T fy_data[1200];
        creal_T reconVar1_data[300];
        creal_T reconVar2_data[300];
        creal_T ytmp_data[300];
        cuint8_T b_y_data[600];
        double b_costab_data[1201];
        double b_sintab_data[1201];
        double costab1q_data[601];
        double hcostabinv_data[601];
        double hsintab_data[601];
        double hsintabinv_data[601];
        double d;
        double d1;
        double e;
        double temp_im;
        double temp_re;
        double twid_im;
        double twid_re;
        double z;
        int wrapIndex_data[300];
        int fy_size[1];
        int tmp_size[1];
        int hnRows;
        int i;
        int ix;
        int j;
        int ju;
        int k;
        int n;
        int n2;
        int nRowsD2;
        int nd2;
        int temp_re_tmp;
        int y_size_idx_0;
        bool tst;
        hnRows = nRows / 2;
        if ((hnRows > nrowsx) && (0 <= hnRows - 1)) {
          std::memset(&b_y_data[0], 0, hnRows * sizeof(cuint8_T));
        }

        for (j = 0; j < hnRows; j++) {
          ytmp_data[j].re = 0.0;
          ytmp_data[j].im = b_y_data[j].im;
        }

        if ((x_size[0] & 1) == 0) {
          tst = true;
          ju = x_size[0];
        } else if (x_size[0] >= nRows) {
          tst = true;
          ju = nRows;
        } else {
          tst = false;
          ju = x_size[0] - 1;
        }

        if (ju >= nRows) {
          ju = nRows;
        }

        nd2 = nRows << 1;
        e = 6.2831853071795862 / static_cast<double>(nd2);
        n = nd2 / 2 / 2;
        ix = n + 1;
        costab1q_data[0] = 1.0;
        nd2 = n / 2 - 1;
        for (k = 0; k <= nd2; k++) {
          costab1q_data[k + 1] = std::cos(e * (static_cast<double>(k) + 1.0));
        }

        j = nd2 + 2;
        nd2 = n - 1;
        for (k = j; k <= nd2; k++) {
          costab1q_data[k] = std::sin(e * static_cast<double>(n - k));
        }

        costab1q_data[n] = 0.0;
        n2 = n << 1;
        b_costab_data[0] = 1.0;
        b_sintab_data[0] = 0.0;
        for (k = 0; k < n; k++) {
          b_costab_data[k + 1] = costab1q_data[k + 1];
          b_sintab_data[k + 1] = -costab1q_data[(n - k) - 1];
        }

        for (k = ix; k <= n2; k++) {
          b_costab_data[k] = -costab1q_data[n2 - k];
          b_sintab_data[k] = -costab1q_data[k - n];
        }

        nd2 = costab_size[1] / 2;
        for (i = 0; i < nd2; i++) {
          n2 = ((i + 1) << 1) - 2;
          costab1q_data[i] = costab_data[n2];
          hsintab_data[i] = sintab_data[n2];
          hcostabinv_data[i] = costabinv_data[n2];
          hsintabinv_data[i] = sintabinv_data[n2];
        }

        nd2 = 0;
        for (i = 0; i < hnRows; i++) {
          reconVar1_data[i].re = b_sintab_data[nd2] + 1.0;
          reconVar1_data[i].im = -b_costab_data[nd2];
          reconVar2_data[i].re = 1.0 - b_sintab_data[nd2];
          reconVar2_data[i].im = b_costab_data[nd2];
          nd2 += 2;
          if (i + 1 != 1) {
            wrapIndex_data[i] = (hnRows - i) + 1;
          } else {
            wrapIndex_data[0] = 1;
          }
        }

        nd2 = 0;
        e = static_cast<double>(ju) / 2.0;
        j = static_cast<int>(e);
        for (n2 = 0; n2 < j; n2++) {
          temp_re_tmp = (hnRows + n2) - 1;
          temp_re = wwc_data[temp_re_tmp].re;
          temp_im = wwc_data[temp_re_tmp].im;
          twid_re = x_data[nd2];
          twid_im = x_data[nd2 + 1];
          ytmp_data[n2].re = temp_re * twid_re + temp_im * twid_im;
          ytmp_data[n2].im = temp_re * twid_im - temp_im * twid_re;
          nd2 += 2;
        }

        if (!tst) {
          temp_re_tmp = (hnRows + static_cast<int>(e)) - 1;
          temp_re = wwc_data[temp_re_tmp].re;
          temp_im = wwc_data[temp_re_tmp].im;
          twid_re = x_data[nd2];
          j = static_cast<int>(static_cast<double>(ju) / 2.0);
          ytmp_data[j].re = temp_re * twid_re + temp_im * 0.0;
          ytmp_data[j].im = temp_re * 0.0 - temp_im * twid_re;
          if (static_cast<int>(e) + 2 <= hnRows) {
            j = static_cast<int>(static_cast<double>(ju) / 2.0) + 2;
            if (j <= hnRows) {
              std::memset(&ytmp_data[j + -1], 0, ((hnRows - j) + 1) * sizeof
                          (creal_T));
            }
          }
        } else {
          if (static_cast<int>(e) + 1 <= hnRows) {
            j = static_cast<int>(static_cast<double>(ju) / 2.0) + 1;
            if (j <= hnRows) {
              std::memset(&ytmp_data[j + -1], 0, ((hnRows - j) + 1) * sizeof
                          (creal_T));
            }
          }
        }

        z = static_cast<double>(nfft) / 2.0;
        y_size_idx_0 = static_cast<int>(z);
        if (static_cast<int>(z) > hnRows) {
          nd2 = static_cast<int>(z);
          y_size_idx_0 = static_cast<int>(z);
          if (0 <= nd2 - 1) {
            std::memset(&c_y_data[0], 0, nd2 * sizeof(creal_T));
          }
        }

        fy_size[0] = y_size_idx_0;
        if (0 <= y_size_idx_0 - 1) {
          std::memcpy(&fy_data[0], &c_y_data[0], y_size_idx_0 * sizeof(creal_T));
        }

        n2 = static_cast<int>(z);
        if (hnRows < n2) {
          n2 = hnRows;
        }

        j = static_cast<int>(z) - 2;
        nRowsD2 = static_cast<int>(z) / 2;
        k = nRowsD2 / 2;
        ix = 0;
        nd2 = 0;
        ju = 0;
        for (i = 0; i <= n2 - 2; i++) {
          fy_data[nd2] = ytmp_data[ix];
          n = static_cast<int>(z);
          tst = true;
          while (tst) {
            n >>= 1;
            ju ^= n;
            tst = ((ju & n) == 0);
          }

          nd2 = ju;
          ix++;
        }

        fy_data[nd2] = ytmp_data[ix];
        nd2 = fy_size[0];
        if (0 <= nd2 - 1) {
          std::memcpy(&c_y_data[0], &fy_data[0], nd2 * sizeof(creal_T));
        }

        if (static_cast<int>(z) > 1) {
          for (i = 0; i <= j; i += 2) {
            d = c_y_data[i + 1].re;
            temp_re = d;
            d1 = c_y_data[i + 1].im;
            temp_im = d1;
            e = c_y_data[i].re;
            twid_re = c_y_data[i].im;
            d = e - d;
            c_y_data[i + 1].re = d;
            d1 = twid_re - d1;
            c_y_data[i + 1].im = d1;
            c_y_data[i].re = e + temp_re;
            c_y_data[i].im = twid_re + temp_im;
          }
        }

        nd2 = 2;
        n2 = 4;
        ix = ((k - 1) << 2) + 1;
        while (k > 0) {
          for (i = 0; i < ix; i += n2) {
            temp_re_tmp = i + nd2;
            temp_re = c_y_data[temp_re_tmp].re;
            temp_im = c_y_data[temp_re_tmp].im;
            c_y_data[temp_re_tmp].re = c_y_data[i].re - temp_re;
            c_y_data[temp_re_tmp].im = c_y_data[i].im - temp_im;
            c_y_data[i].re += temp_re;
            c_y_data[i].im += temp_im;
          }

          ju = 1;
          for (j = k; j < nRowsD2; j += k) {
            twid_re = costab1q_data[j];
            twid_im = hsintab_data[j];
            i = ju;
            n = ju + ix;
            while (i < n) {
              temp_re_tmp = i + nd2;
              temp_re = twid_re * c_y_data[temp_re_tmp].re - twid_im *
                c_y_data[temp_re_tmp].im;
              temp_im = twid_re * c_y_data[temp_re_tmp].im + twid_im *
                c_y_data[temp_re_tmp].re;
              c_y_data[temp_re_tmp].re = c_y_data[i].re - temp_re;
              c_y_data[temp_re_tmp].im = c_y_data[i].im - temp_im;
              c_y_data[i].re += temp_re;
              c_y_data[i].im += temp_im;
              i += n2;
            }

            ju++;
          }

          k /= 2;
          nd2 = n2;
          n2 += n2;
          ix -= nd2;
        }

        FFTImplementationCallback::r2br_r2dit_trig((wwc_data), (wwc_size), (
          static_cast<int>(static_cast<double>(nfft) / 2.0)), (costab1q_data),
          (hsintab_data), (tmp_data), (tmp_size));
        for (j = 0; j < y_size_idx_0; j++) {
          d = c_y_data[j].re;
          d1 = c_y_data[j].im;
          twid_im = tmp_data[j].re;
          temp_re = tmp_data[j].im;
          fy_data[j].re = d * twid_im - d1 * temp_re;
          fy_data[j].im = d * temp_re + d1 * twid_im;
        }

        FFTImplementationCallback::b_r2br_r2dit_trig((fy_data), (fy_size), (
          static_cast<int>(z)), (hcostabinv_data), (hsintabinv_data), (tmp_data),
          (tmp_size));
        nd2 = tmp_size[0];
        if (0 <= nd2 - 1) {
          std::memcpy(&fy_data[0], &tmp_data[0], nd2 * sizeof(creal_T));
        }

        nd2 = 0;
        j = wwc_size[0];
        for (k = hnRows; k <= j; k++) {
          d = fy_data[k - 1].re;
          d1 = fy_data[k - 1].im;
          ytmp_data[nd2].re = wwc_data[k - 1].re * d + wwc_data[k - 1].im * d1;
          ytmp_data[nd2].im = wwc_data[k - 1].re * d1 - wwc_data[k - 1].im * d;
          nd2++;
        }

        for (i = 0; i < hnRows; i++) {
          j = wrapIndex_data[i];
          e = ytmp_data[j - 1].re;
          twid_re = -ytmp_data[j - 1].im;
          d = reconVar1_data[i].re;
          d1 = reconVar1_data[i].im;
          twid_im = reconVar2_data[i].re;
          temp_re = reconVar2_data[i].im;
          y_data[i].re = 0.5 * ((ytmp_data[i].re * d - ytmp_data[i].im * d1) +
                                (e * twid_im - twid_re * temp_re));
          y_data[i].im = 0.5 * ((ytmp_data[i].re * d1 + ytmp_data[i].im * d) +
                                (e * temp_re + twid_re * twid_im));
          j = hnRows + i;
          y_data[j].re = 0.5 * ((ytmp_data[i].re * twid_im - ytmp_data[i].im *
            temp_re) + (e * d - twid_re * d1));
          y_data[j].im = 0.5 * ((ytmp_data[i].re * temp_re + ytmp_data[i].im *
            twid_im) + (e * d1 + twid_re * d));
        }
      }

      //
      // Arguments    : const creal_T x_data[]
      //                const int x_size[1]
      //                int n1_unsigned
      //                const double costab_data[]
      //                const double sintab_data[]
      //                creal_T y_data[]
      //                int y_size[1]
      // Return Type  : void
      //
      void FFTImplementationCallback::r2br_r2dit_trig(const creal_T x_data[],
        const int x_size[1], int n1_unsigned, const double costab_data[], const
        double sintab_data[], creal_T y_data[], int y_size[1])
      {
        double temp_im;
        double temp_re;
        double twid_im;
        double twid_re;
        int i;
        int iDelta2;
        int iheight;
        int ix;
        int iy;
        int ju;
        int k;
        int nRowsD2;
        y_size[0] = n1_unsigned;
        if (n1_unsigned > x_size[0]) {
          y_size[0] = n1_unsigned;
          if (0 <= n1_unsigned - 1) {
            std::memset(&y_data[0], 0, n1_unsigned * sizeof(creal_T));
          }
        }

        iDelta2 = x_size[0];
        if (iDelta2 >= n1_unsigned) {
          iDelta2 = n1_unsigned;
        }

        iheight = n1_unsigned - 2;
        nRowsD2 = n1_unsigned / 2;
        k = nRowsD2 / 2;
        ix = 0;
        iy = 0;
        ju = 0;
        for (i = 0; i <= iDelta2 - 2; i++) {
          bool tst;
          y_data[iy] = x_data[ix];
          iy = n1_unsigned;
          tst = true;
          while (tst) {
            iy >>= 1;
            ju ^= iy;
            tst = ((ju & iy) == 0);
          }

          iy = ju;
          ix++;
        }

        y_data[iy] = x_data[ix];
        if (n1_unsigned > 1) {
          for (i = 0; i <= iheight; i += 2) {
            double im;
            double re;
            twid_re = y_data[i + 1].re;
            temp_re = twid_re;
            twid_im = y_data[i + 1].im;
            temp_im = twid_im;
            re = y_data[i].re;
            im = y_data[i].im;
            twid_re = re - twid_re;
            y_data[i + 1].re = twid_re;
            twid_im = im - twid_im;
            y_data[i + 1].im = twid_im;
            y_data[i].re = re + temp_re;
            y_data[i].im = im + temp_im;
          }
        }

        iy = 2;
        iDelta2 = 4;
        iheight = ((k - 1) << 2) + 1;
        while (k > 0) {
          int temp_re_tmp;
          for (i = 0; i < iheight; i += iDelta2) {
            temp_re_tmp = i + iy;
            temp_re = y_data[temp_re_tmp].re;
            temp_im = y_data[temp_re_tmp].im;
            y_data[temp_re_tmp].re = y_data[i].re - temp_re;
            y_data[temp_re_tmp].im = y_data[i].im - temp_im;
            y_data[i].re += temp_re;
            y_data[i].im += temp_im;
          }

          ix = 1;
          for (ju = k; ju < nRowsD2; ju += k) {
            int ihi;
            twid_re = costab_data[ju];
            twid_im = sintab_data[ju];
            i = ix;
            ihi = ix + iheight;
            while (i < ihi) {
              temp_re_tmp = i + iy;
              temp_re = twid_re * y_data[temp_re_tmp].re - twid_im *
                y_data[temp_re_tmp].im;
              temp_im = twid_re * y_data[temp_re_tmp].im + twid_im *
                y_data[temp_re_tmp].re;
              y_data[temp_re_tmp].re = y_data[i].re - temp_re;
              y_data[temp_re_tmp].im = y_data[i].im - temp_im;
              y_data[i].re += temp_re;
              y_data[i].im += temp_im;
              i += iDelta2;
            }

            ix++;
          }

          k /= 2;
          iy = iDelta2;
          iDelta2 += iDelta2;
          iheight -= iy;
        }
      }

      //
      // Arguments    : const double x_data[]
      //                const int x_size[1]
      //                creal_T y_data[]
      //                int y_size[1]
      //                int unsigned_nRows
      //                const double costab_data[]
      //                const int costab_size[2]
      //                const double sintab_data[]
      // Return Type  : void
      //
      void FFTImplementationCallback::doHalfLengthRadix2(const double x_data[],
        const int x_size[1], creal_T y_data[], int y_size[1], int unsigned_nRows,
        const double costab_data[], const int costab_size[2], const double
        sintab_data[])
      {
        creal_T b_y_data[2400];
        creal_T reconVar1_data[300];
        creal_T reconVar2_data[300];
        double hcostab_data[601];
        double hsintab_data[601];
        double d;
        double d1;
        double temp2_im;
        double temp2_re;
        double temp_im;
        double temp_re;
        double y_im;
        double y_im_tmp;
        double z;
        int bitrevIndex_data[300];
        int wrapIndex_data[300];
        int hszCostab;
        int i;
        int iDelta2;
        int ihi;
        int istart;
        int ju;
        int k;
        int nRows;
        int nRowsD2;
        int y_size_idx_0;
        bool tst;
        nRows = unsigned_nRows / 2;
        istart = y_size[0];
        if (istart >= nRows) {
          istart = nRows;
        }

        ihi = nRows - 2;
        nRowsD2 = nRows / 2;
        k = nRowsD2 / 2;
        hszCostab = costab_size[1] / 2;
        for (i = 0; i < hszCostab; i++) {
          iDelta2 = ((i + 1) << 1) - 2;
          hcostab_data[i] = costab_data[iDelta2];
          hsintab_data[i] = sintab_data[iDelta2];
        }

        for (i = 0; i < nRows; i++) {
          d = sintab_data[i];
          d1 = costab_data[i];
          reconVar1_data[i].re = d + 1.0;
          reconVar1_data[i].im = -d1;
          reconVar2_data[i].re = 1.0 - d;
          reconVar2_data[i].im = d1;
          if (i + 1 != 1) {
            wrapIndex_data[i] = (nRows - i) + 1;
          } else {
            wrapIndex_data[0] = 1;
          }
        }

        z = static_cast<double>(unsigned_nRows) / 2.0;
        ju = 0;
        hszCostab = 1;
        iDelta2 = static_cast<int>(z);
        if (0 <= iDelta2 - 1) {
          std::memset(&bitrevIndex_data[0], 0, iDelta2 * sizeof(int));
        }

        for (iDelta2 = 0; iDelta2 <= istart - 2; iDelta2++) {
          bitrevIndex_data[iDelta2] = hszCostab;
          hszCostab = static_cast<int>(z);
          tst = true;
          while (tst) {
            hszCostab >>= 1;
            ju ^= hszCostab;
            tst = ((ju & hszCostab) == 0);
          }

          hszCostab = ju + 1;
        }

        bitrevIndex_data[istart - 1] = hszCostab;
        if ((x_size[0] & 1) == 0) {
          tst = true;
          istart = x_size[0];
        } else if (x_size[0] >= unsigned_nRows) {
          tst = true;
          istart = unsigned_nRows;
        } else {
          tst = false;
          istart = x_size[0] - 1;
        }

        hszCostab = 0;
        if (istart >= unsigned_nRows) {
          istart = unsigned_nRows;
        }

        d = static_cast<double>(istart) / 2.0;
        iDelta2 = static_cast<int>(d);
        for (i = 0; i < iDelta2; i++) {
          ju = bitrevIndex_data[i];
          y_data[ju - 1].re = x_data[hszCostab];
          y_data[ju - 1].im = x_data[hszCostab + 1];
          hszCostab += 2;
        }

        if (!tst) {
          iDelta2 = bitrevIndex_data[static_cast<int>(d)] - 1;
          y_data[iDelta2].re = x_data[hszCostab];
          y_data[iDelta2].im = 0.0;
        }

        y_size_idx_0 = y_size[0];
        iDelta2 = y_size[0];
        if (0 <= iDelta2 - 1) {
          std::memcpy(&b_y_data[0], &y_data[0], iDelta2 * sizeof(creal_T));
        }

        if (nRows > 1) {
          for (i = 0; i <= ihi; i += 2) {
            d = b_y_data[i + 1].re;
            temp_re = d;
            d1 = b_y_data[i + 1].im;
            temp_im = d1;
            temp2_im = b_y_data[i].re;
            temp2_re = b_y_data[i].im;
            d = temp2_im - d;
            b_y_data[i + 1].re = d;
            d1 = temp2_re - d1;
            b_y_data[i + 1].im = d1;
            b_y_data[i].re = temp2_im + temp_re;
            b_y_data[i].im = temp2_re + temp_im;
          }
        }

        hszCostab = 2;
        iDelta2 = 4;
        ju = ((k - 1) << 2) + 1;
        while (k > 0) {
          int temp_re_tmp;
          for (i = 0; i < ju; i += iDelta2) {
            temp_re_tmp = i + hszCostab;
            temp_re = b_y_data[temp_re_tmp].re;
            temp_im = b_y_data[temp_re_tmp].im;
            b_y_data[temp_re_tmp].re = b_y_data[i].re - temp_re;
            b_y_data[temp_re_tmp].im = b_y_data[i].im - temp_im;
            b_y_data[i].re += temp_re;
            b_y_data[i].im += temp_im;
          }

          istart = 1;
          for (nRows = k; nRows < nRowsD2; nRows += k) {
            temp2_re = hcostab_data[nRows];
            temp2_im = hsintab_data[nRows];
            i = istart;
            ihi = istart + ju;
            while (i < ihi) {
              temp_re_tmp = i + hszCostab;
              temp_re = temp2_re * b_y_data[temp_re_tmp].re - temp2_im *
                b_y_data[temp_re_tmp].im;
              temp_im = temp2_re * b_y_data[temp_re_tmp].im + temp2_im *
                b_y_data[temp_re_tmp].re;
              b_y_data[temp_re_tmp].re = b_y_data[i].re - temp_re;
              b_y_data[temp_re_tmp].im = b_y_data[i].im - temp_im;
              b_y_data[i].re += temp_re;
              b_y_data[i].im += temp_im;
              i += iDelta2;
            }

            istart++;
          }

          k /= 2;
          hszCostab = iDelta2;
          iDelta2 += iDelta2;
          ju -= hszCostab;
        }

        y_size[0] = y_size_idx_0;
        if (0 <= y_size_idx_0 - 1) {
          std::memcpy(&y_data[0], &b_y_data[0], y_size_idx_0 * sizeof(creal_T));
        }

        hszCostab = static_cast<int>(z) / 2;
        d = b_y_data[0].re * reconVar2_data[0].re;
        d1 = b_y_data[0].re * reconVar1_data[0].re;
        y_data[0].re = 0.5 * ((d1 - b_y_data[0].im * reconVar1_data[0].im) + (d
          - -b_y_data[0].im * reconVar2_data[0].im));
        temp2_re = b_y_data[0].re * reconVar2_data[0].im;
        temp2_im = b_y_data[0].re * reconVar1_data[0].im;
        y_data[0].im = 0.5 * ((temp2_im + b_y_data[0].im * reconVar1_data[0].re)
                              + (temp2_re + -b_y_data[0].im * reconVar2_data[0].
          re));
        y_data[static_cast<int>(z)].re = 0.5 * ((d - b_y_data[0].im *
          reconVar2_data[0].im) + (d1 - -b_y_data[0].im * reconVar1_data[0].im));
        y_data[static_cast<int>(z)].im = 0.5 * ((temp2_re + b_y_data[0].im *
          reconVar2_data[0].re) + (temp2_im + -b_y_data[0].im * reconVar1_data[0]
          .re));
        for (i = 2; i <= hszCostab; i++) {
          temp_re = y_data[i - 1].re;
          temp_im = y_data[i - 1].im;
          iDelta2 = wrapIndex_data[i - 1];
          temp2_re = y_data[iDelta2 - 1].re;
          temp2_im = y_data[iDelta2 - 1].im;
          y_im = y_data[i - 1].re * reconVar1_data[i - 1].im + y_data[i - 1].im *
            reconVar1_data[i - 1].re;
          y_im_tmp = -y_data[iDelta2 - 1].im;
          y_data[i - 1].re = 0.5 * ((y_data[i - 1].re * reconVar1_data[i - 1].re
            - y_data[i - 1].im * reconVar1_data[i - 1].im) + (temp2_re *
            reconVar2_data[i - 1].re - y_im_tmp * reconVar2_data[i - 1].im));
          y_data[i - 1].im = 0.5 * (y_im + (temp2_re * reconVar2_data[i - 1].im
            + y_im_tmp * reconVar2_data[i - 1].re));
          ju = (static_cast<int>(z) + i) - 1;
          y_data[ju].re = 0.5 * ((temp_re * reconVar2_data[i - 1].re - temp_im *
            reconVar2_data[i - 1].im) + (temp2_re * reconVar1_data[i - 1].re -
            -temp2_im * reconVar1_data[i - 1].im));
          y_data[ju].im = 0.5 * ((temp_re * reconVar2_data[i - 1].im + temp_im *
            reconVar2_data[i - 1].re) + (temp2_re * reconVar1_data[i - 1].im +
            -temp2_im * reconVar1_data[i - 1].re));
          y_data[iDelta2 - 1].re = 0.5 * ((temp2_re * reconVar1_data[iDelta2 - 1]
            .re - temp2_im * reconVar1_data[iDelta2 - 1].im) + (temp_re *
            reconVar2_data[iDelta2 - 1].re - -temp_im * reconVar2_data[iDelta2 -
            1].im));
          y_data[iDelta2 - 1].im = 0.5 * ((temp2_re * reconVar1_data[iDelta2 - 1]
            .im + temp2_im * reconVar1_data[iDelta2 - 1].re) + (temp_re *
            reconVar2_data[iDelta2 - 1].im + -temp_im * reconVar2_data[iDelta2 -
            1].re));
          ju = (iDelta2 + static_cast<int>(z)) - 1;
          y_data[ju].re = 0.5 * ((temp2_re * reconVar2_data[iDelta2 - 1].re -
            temp2_im * reconVar2_data[iDelta2 - 1].im) + (temp_re *
            reconVar1_data[iDelta2 - 1].re - -temp_im * reconVar1_data[iDelta2 -
            1].im));
          y_data[ju].im = 0.5 * ((temp2_re * reconVar2_data[iDelta2 - 1].im +
            temp2_im * reconVar2_data[iDelta2 - 1].re) + (temp_re *
            reconVar1_data[iDelta2 - 1].im + -temp_im * reconVar1_data[iDelta2 -
            1].re));
        }

        if (hszCostab != 0) {
          temp2_re = y_data[hszCostab].re;
          temp_im = y_data[hszCostab].im;
          y_im = y_data[hszCostab].re * reconVar1_data[hszCostab].im +
            y_data[hszCostab].im * reconVar1_data[hszCostab].re;
          y_im_tmp = -y_data[hszCostab].im;
          d = temp2_re * reconVar2_data[hszCostab].re;
          y_data[hszCostab].re = 0.5 * ((y_data[hszCostab].re *
            reconVar1_data[hszCostab].re - y_data[hszCostab].im *
            reconVar1_data[hszCostab].im) + (d - y_im_tmp *
            reconVar2_data[hszCostab].im));
          d1 = temp2_re * reconVar2_data[hszCostab].im;
          y_data[hszCostab].im = 0.5 * (y_im + (d1 + y_im_tmp *
            reconVar2_data[hszCostab].re));
          iDelta2 = static_cast<int>(z) + hszCostab;
          y_data[iDelta2].re = 0.5 * ((d - temp_im * reconVar2_data[hszCostab].
            im) + (temp2_re * reconVar1_data[hszCostab].re - -temp_im *
                   reconVar1_data[hszCostab].im));
          y_data[iDelta2].im = 0.5 * ((d1 + temp_im * reconVar2_data[hszCostab].
            re) + (temp2_re * reconVar1_data[hszCostab].im + -temp_im *
                   reconVar1_data[hszCostab].re));
        }
      }

      //
      // Arguments    : const double x_data[]
      //                const int x_size[1]
      //                int n2blue
      //                int nfft
      //                const double costab_data[]
      //                const int costab_size[2]
      //                const double sintab_data[]
      //                const double sintabinv_data[]
      //                creal_T y_data[]
      //                int y_size[1]
      // Return Type  : void
      //
      void FFTImplementationCallback::dobluesteinfft(const double x_data[],
        const int x_size[1], int n2blue, int nfft, const double costab_data[],
        const int costab_size[2], const double sintab_data[], const double
        sintabinv_data[], creal_T y_data[], int y_size[1])
      {
        static creal_T fv_data[2400];
        static creal_T fy_data[2400];
        creal_T wwc_data[1199];
        double nt_im;
        double nt_re;
        int fv_size[1];
        int fy_size[1];
        int wwc_size[1];
        int i;
        int idx;
        int ix;
        int j;
        int k;
        int nInt2;
        int nInt2m1;
        int rt;
        if ((nfft != 1) && ((nfft & 1) == 0)) {
          j = nfft / 2;
          nInt2m1 = (j + j) - 1;
          wwc_size[0] = nInt2m1;
          idx = j;
          rt = 0;
          wwc_data[j - 1].re = 1.0;
          wwc_data[j - 1].im = 0.0;
          nInt2 = j << 1;
          for (k = 0; k <= j - 2; k++) {
            ix = ((k + 1) << 1) - 1;
            if (nInt2 - rt <= ix) {
              rt += ix - nInt2;
            } else {
              rt += ix;
            }

            nt_im = -3.1415926535897931 * static_cast<double>(rt) / static_cast<
              double>(j);
            if (nt_im == 0.0) {
              nt_re = 1.0;
              nt_im = 0.0;
            } else {
              nt_re = std::cos(nt_im);
              nt_im = std::sin(nt_im);
            }

            wwc_data[idx - 2].re = nt_re;
            wwc_data[idx - 2].im = -nt_im;
            idx--;
          }

          idx = 0;
          rt = nInt2m1 - 1;
          for (k = rt; k >= j; k--) {
            wwc_data[k] = wwc_data[idx];
            idx++;
          }
        } else {
          nInt2m1 = (nfft + nfft) - 1;
          wwc_size[0] = nInt2m1;
          idx = nfft;
          rt = 0;
          wwc_data[nfft - 1].re = 1.0;
          wwc_data[nfft - 1].im = 0.0;
          nInt2 = nfft << 1;
          for (k = 0; k <= nfft - 2; k++) {
            ix = ((k + 1) << 1) - 1;
            if (nInt2 - rt <= ix) {
              rt += ix - nInt2;
            } else {
              rt += ix;
            }

            nt_im = -3.1415926535897931 * static_cast<double>(rt) / static_cast<
              double>(nfft);
            if (nt_im == 0.0) {
              nt_re = 1.0;
              nt_im = 0.0;
            } else {
              nt_re = std::cos(nt_im);
              nt_im = std::sin(nt_im);
            }

            wwc_data[idx - 2].re = nt_re;
            wwc_data[idx - 2].im = -nt_im;
            idx--;
          }

          idx = 0;
          rt = nInt2m1 - 1;
          for (k = rt; k >= nfft; k--) {
            wwc_data[k] = wwc_data[idx];
            idx++;
          }
        }

        y_size[0] = nfft;
        if (nfft > x_size[0]) {
          y_size[0] = nfft;
          if (0 <= nfft - 1) {
            std::memset(&y_data[0], 0, nfft * sizeof(creal_T));
          }
        }

        if ((n2blue != 1) && ((nfft & 1) == 0)) {
          FFTImplementationCallback::doHalfLengthBluestein((x_data), (x_size),
            (y_data), (x_size[0]), (nfft), (n2blue), (wwc_data), (wwc_size),
            (costab_data), (costab_size), (sintab_data), (costab_data),
            (sintabinv_data));
        } else {
          double d;
          double d1;
          double im;
          double twid_im;
          double twid_re;
          int nRowsD2;
          int nt_re_tmp;
          nInt2m1 = x_size[0];
          if (nfft < nInt2m1) {
            nInt2m1 = nfft;
          }

          rt = 0;
          for (k = 0; k < nInt2m1; k++) {
            nt_re_tmp = (nfft + k) - 1;
            y_data[k].re = wwc_data[nt_re_tmp].re * x_data[rt];
            y_data[k].im = wwc_data[nt_re_tmp].im * -x_data[rt];
            rt++;
          }

          rt = nInt2m1 + 1;
          if (rt <= nfft) {
            std::memset(&y_data[rt + -1], 0, ((nfft - rt) + 1) * sizeof(creal_T));
          }

          fy_size[0] = n2blue;
          if (n2blue > y_size[0]) {
            fy_size[0] = n2blue;
            if (0 <= n2blue - 1) {
              std::memset(&fy_data[0], 0, n2blue * sizeof(creal_T));
            }
          }

          rt = y_size[0];
          if (rt >= n2blue) {
            rt = n2blue;
          }

          nInt2 = n2blue - 2;
          nRowsD2 = n2blue / 2;
          k = nRowsD2 / 2;
          ix = 0;
          nInt2m1 = 0;
          idx = 0;
          for (i = 0; i <= rt - 2; i++) {
            bool tst;
            fy_data[nInt2m1] = y_data[ix];
            nInt2m1 = n2blue;
            tst = true;
            while (tst) {
              nInt2m1 >>= 1;
              idx ^= nInt2m1;
              tst = ((idx & nInt2m1) == 0);
            }

            nInt2m1 = idx;
            ix++;
          }

          fy_data[nInt2m1] = y_data[ix];
          if (n2blue > 1) {
            for (i = 0; i <= nInt2; i += 2) {
              d = fy_data[i + 1].re;
              nt_re = d;
              d1 = fy_data[i + 1].im;
              nt_im = d1;
              twid_re = fy_data[i].re;
              im = fy_data[i].im;
              d = twid_re - d;
              fy_data[i + 1].re = d;
              d1 = im - d1;
              fy_data[i + 1].im = d1;
              fy_data[i].re = twid_re + nt_re;
              fy_data[i].im = im + nt_im;
            }
          }

          nInt2m1 = 2;
          rt = 4;
          nInt2 = ((k - 1) << 2) + 1;
          while (k > 0) {
            for (i = 0; i < nInt2; i += rt) {
              nt_re_tmp = i + nInt2m1;
              nt_re = fy_data[nt_re_tmp].re;
              nt_im = fy_data[nt_re_tmp].im;
              fy_data[nt_re_tmp].re = fy_data[i].re - nt_re;
              fy_data[nt_re_tmp].im = fy_data[i].im - nt_im;
              fy_data[i].re += nt_re;
              fy_data[i].im += nt_im;
            }

            idx = 1;
            for (j = k; j < nRowsD2; j += k) {
              twid_re = costab_data[j];
              twid_im = sintab_data[j];
              i = idx;
              ix = idx + nInt2;
              while (i < ix) {
                nt_re_tmp = i + nInt2m1;
                nt_re = twid_re * fy_data[nt_re_tmp].re - twid_im *
                  fy_data[nt_re_tmp].im;
                nt_im = twid_re * fy_data[nt_re_tmp].im + twid_im *
                  fy_data[nt_re_tmp].re;
                fy_data[nt_re_tmp].re = fy_data[i].re - nt_re;
                fy_data[nt_re_tmp].im = fy_data[i].im - nt_im;
                fy_data[i].re += nt_re;
                fy_data[i].im += nt_im;
                i += rt;
              }

              idx++;
            }

            k /= 2;
            nInt2m1 = rt;
            rt += rt;
            nInt2 -= nInt2m1;
          }

          FFTImplementationCallback::r2br_r2dit_trig((wwc_data), (wwc_size),
            (n2blue), (costab_data), (sintab_data), (fv_data), (fv_size));
          nInt2m1 = fy_size[0];
          for (rt = 0; rt < nInt2m1; rt++) {
            d = fy_data[rt].re;
            d1 = fy_data[rt].im;
            twid_re = fv_data[rt].im;
            twid_im = fv_data[rt].re;
            im = d * twid_re + d1 * twid_im;
            d = d * twid_im - d1 * twid_re;
            fy_data[rt].re = d;
            fy_data[rt].im = im;
          }

          FFTImplementationCallback::b_r2br_r2dit_trig((fy_data), (fy_size),
            (n2blue), (costab_data), (sintabinv_data), (fv_data), (fv_size));
          idx = 0;
          rt = wwc_size[0];
          for (k = nfft; k <= rt; k++) {
            d = wwc_data[k - 1].re;
            d1 = wwc_data[k - 1].im;
            twid_re = fv_data[k - 1].re;
            twid_im = fv_data[k - 1].im;
            y_data[idx].re = d * twid_re + d1 * twid_im;
            y_data[idx].im = d * twid_im - d1 * twid_re;
            idx++;
          }
        }
      }
    }
  }
}

//
// File trailer for FFTImplementationCallback.cpp
//
// [EOF]
//
