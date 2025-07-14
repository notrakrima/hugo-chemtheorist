---
title: "The AI Breakthrough: Redefining Chemical Prediction with Microsoft Research"
date: 2025-06-21
---

For decades, a fundamental problem has limited the predictive power of computational chemistry. Now, through a groundbreaking collaboration between Lab Initio and Microsoft Research, we have developed a deep-learning model that overcomes this challenge, achieving the accuracy required to reliably predict experimental outcomes and transform materials discovery.

### The Grand Challenge: A 60-Year-Old Problem in Chemistry

Density Functional Theory (DFT) is the workhorse method for simulating molecules and materials, but its accuracy has always been limited by a crucial, unknown component: the exchange-correlation (XC) functional. For 60 years, scientists have created hundreds of approximations, but progress toward experimental accuracy had stalled. This bottleneck meant that simulations were more often used to explain experiments rather than to predict them, slowing down the pace of innovation.

### The AI Solution: The Skala XC Functional

We moved beyond traditional methods by taking a true deep-learning approach. Instead of hand-designing features, we developed **Skala**, a model that learns to represent the complex physics of electrons directly from highly accurate data.

To do this, we first had to generate a dataset of unprecedented scale and accuracy. **Led by Prof. Amir Karton, our team leveraged massive Azure compute resources to generate the world's largest and most accurate chemical database of its kind.** This foundational dataset was the key that enabled the training of the Skala functional.

### The Proof: Unprecedented Accuracy

The results are transformative. Skala achieves near "chemical accuracy" (1 kcal/mol), the standard required for predictive modeling of laboratory experiments. To date, no other functional has reached this milestone at a comparable computational cost.

> "After years of benchmarking DFT methods against experimental accuracy, this is the first time I’ve witnessed such an unprecedented leap in the accuracy–cost trade-off. It is genuinely exciting to see how the creation of our new dataset has enabled these groundbreaking results."
>
> **— Prof. Amir Karton, quoted by Microsoft Research**

> "Skala could be the first machine-learned density functional to compete with existing functionals for wide use in computational chemistry, and a sign of things to come..."
>
> **— Prof. John P. Perdew, Tulane University**

### Resources & Publications

*   **Official Announcement:** [Microsoft Research Blog Post](https://www.microsoft.com/en-us/research/blog/breaking-bonds-breaking-ground-advancing-the-accuracy-of-computational-chemistry-with-deep-learning/)
*   **The Skala Functional Paper:** [arXiv:2506.14665](https://arxiv.org/abs/2506.14665)
*   **The MSR-ACC Dataset Paper:** [arXiv:2506.14492](https://arxiv.org/abs/2506.14492)

---

{{< youtube 1e06QweGoLs >}}

---

### **Next Step: [See How We Apply This Breakthrough in Our Discovery Engine &rarr;](/platform/discovery-engine/)**
