use algebra::FftField;
use ff_fft::{DensePolynomial, Evaluations, Radix2EvaluationDomain as D};
use rayon::prelude::*;

pub trait PolyUtils<F: FftField> {
    fn scale(&self, elm: F) -> Self;
    fn shiftr(&self, size: usize) -> Self;
    fn eval_polynomial(coeffs: &[F], x: F) -> F;
    fn eval(&self, elm: F, size: usize) -> Vec<F>;
}

pub trait EvalUtils<F: FftField> {
    fn scale(&self, elm: F) -> Self;
    fn square(&self) -> Self;
    fn pow(&self, pow: usize) -> Self;
    fn shift(&self, len: usize) -> Self;
}

impl<F: FftField> EvalUtils<F> for Evaluations<F, D<F>> {
    // This function "scales" (multiplies) polynomaial with a scalar
    // It is implemented to have the desired functionality for DensePolynomial
    fn scale(&self, elm: F) -> Self {
        let mut result = self.clone();
        result.evals.par_iter_mut().for_each(|coeff| *coeff *= &elm);
        result
    }

    fn square(&self) -> Self {
        let mut result = self.clone();
        result.evals.par_iter_mut().for_each(|e| {
            let _ = e.square_in_place();
        });
        result
    }

    fn pow(&self, pow: usize) -> Self {
        let mut result = self.clone();
        result
            .evals
            .par_iter_mut()
            .for_each(|e| *e = e.pow([pow as u64]));
        result
    }

    // utility function for shifting poly along domain coordinate
    fn shift(&self, len: usize) -> Self {
        let len = len % self.evals.len();
        let mut result = self.clone();
        result.evals.clear();
        result.evals = self.evals[len..].to_vec();
        let mut tail = self.evals[0..len].to_vec();
        result.evals.append(&mut tail);
        result
    }
}

impl<F: FftField> PolyUtils<F> for DensePolynomial<F> {
    fn eval_polynomial(coeffs: &[F], x: F) -> F {
        let mut res = F::zero();
        for c in coeffs.iter().rev() {
            res *= &x;
            res += c;
        }
        res
    }

    // This function "scales" (multiplies) polynomaial with a scalar
    // It is implemented to have the desired functionality for DensePolynomial
    fn scale(&self, elm: F) -> Self {
        let mut result = self.clone();
        result
            .coeffs
            .par_iter_mut()
            .for_each(|coeff| *coeff *= &elm);
        result
    }

    fn shiftr(&self, size: usize) -> Self {
        let mut result = vec![F::zero(); size];
        result.extend(self.coeffs.clone());
        DensePolynomial::<F>::from_coefficients_vec(result)
    }

    // This function evaluates polynomial in chunks
    fn eval(&self, elm: F, size: usize) -> Vec<F> {
        (0..self.coeffs.len())
            .step_by(size)
            .map(|i| {
                Self::from_coefficients_slice(
                    &self.coeffs[i..if i + size > self.coeffs.len() {
                        self.coeffs.len()
                    } else {
                        i + size
                    }],
                )
                .evaluate(elm)
            })
            .collect()
    }
}
