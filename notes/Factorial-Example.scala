
// Racket Example
// (define factorial-aps
//   (lambda (n)
//     (smart-factorial n 1)))

// (define smart-factorial
//   (lambda (n answer)
//     (if (zero? n)
//         answer
//         (smart-factorial (- n 1)
//                          (* n answer)))))

import scala.math.BigDecimal
object Runner {

  def factorial(n: BigDecimal): BigDecimal =
    factorialWorker(n, 1)

  @annotation.tailrec
  private[this] def factorialWorker(n: BigDecimal, answer: BigDecimal): BigDecimal = {
    if (n == 0) return n
    return factorialWorker(n - 1, n * answer)
  }

  def main(args: Array[String]) {
    println(factorial(50))
  }
}
