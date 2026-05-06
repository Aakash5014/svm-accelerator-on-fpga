# FPGA-Based Multi-Class SVM Classifier for Iris Dataset

## 📌 Project Overview

This project implements a **Support Vector Machine (SVM) classifier on FPGA using Verilog HDL** for the famous **Iris flower dataset**.

The design performs:

* Fixed-point SVM inference
* Multi-class classification using One-vs-All (OvA)
* Hardware acceleration on FPGA
* Python-to-FPGA model deployment pipeline

The project demonstrates how machine learning models can be converted into efficient digital hardware accelerators.

---

# 🚀 Features

✅ Multi-class Iris classification
✅ FPGA-friendly fixed-point arithmetic (Q8.8)
✅ Verilog RTL implementation
✅ Python-based SVM training
✅ Automatic weight extraction
✅ `.mem` file generation for FPGA memory initialization
✅ Vivado-compatible design
✅ Modular RTL architecture
✅ Testbench for simulation

---

# 🧠 System Architecture

```text
                Input Features
         (Sepal/Petal Measurements)
                         │
        ┌────────────┬────────────┬────────────┐
        │            │            │
     SVM_0        SVM_1        SVM_2
   (Setosa)    (Versicolor)  (Virginica)
        │            │            │
      score0       score1       score2
        └─────── MAX SELECTOR ───────┘
                         │
                   Final Prediction
```

---

# 📂 Project Structure

```text
fpga_svm_iris/
│
├── python/
│   ├── svm_weight_extraction.py
│
├── data/
│   ├── setosa_sv.mem
│   ├── setosa_dc.mem
│   ├── setosa_bias.mem
│   ├── versicolor_sv.mem
│   ├── versicolor_dc.mem
│   ├── versicolor_bias.mem
│   ├── virginica_sv.mem
│   ├── virginica_dc.mem
│   ├── virginica_bias.mem
│
├── src/
│   ├── fixed_mult.v
│   ├── dot_product.v
│   ├── dual_mult.v
│   ├── support_vector_mem.v
│   ├── dual_coeff_mem.v
│   ├── bias_mem.v
│   ├── svm_classifier_score.v
│   ├── max3.v
│   ├── svm_3class_top.v
│
├── sim/
│   ├── svm_tb.v
│
├── README.md
```

---

# ⚙️ Technologies Used

| Component       | Technology       |
| --------------- | ---------------- |
| Hardware Design | Verilog HDL      |
| FPGA Toolchain  | Xilinx Vivado    |
| ML Training     | Python           |
| SVM Library     | Scikit-learn     |
| Dataset         | Iris Dataset     |
| Arithmetic      | Fixed-Point Q8.8 |

---

# 🌸 Iris Dataset Features

The classifier uses four input features:

| Feature      |
| ------------ |
| Sepal Length |
| Sepal Width  |
| Petal Length |
| Petal Width  |

Target classes:

* Setosa
* Versicolor
* Virginica

---

# 🔢 Fixed-Point Representation

The hardware uses:

```text
Q8.8 Fixed Point Format
```

Conversion:

```text
Fixed = Float × 256
```

Example:

| Float | Fixed |
| ----- | ----- |
| 5.1   | 1306  |
| 3.5   | 896   |
| 1.4   | 358   |

---

# 🐍 Python Training Pipeline

The Python script:

1. Loads Iris dataset
2. Trains three SVM classifiers
3. Extracts:

   * Support vectors
   * Dual coefficients
   * Bias values
4. Converts parameters to fixed-point
5. Generates FPGA `.mem` files

---

# ▶️ Running the Python Script

Install dependencies:

```bash
pip install numpy pandas scikit-learn
```

Run:

```bash
python svm_weight_extraction.py
```

Generated files:

```text
setosa_sv.mem
setosa_dc.mem
setosa_bias.mem
...
```

---

# 🧩 Verilog Modules

| Module                 | Function                     |
| ---------------------- | ---------------------------- |
| fixed_mult.v           | Fixed-point multiplication   |
| dot_product.v          | Feature × support vector     |
| dual_mult.v            | Multiply by dual coefficient |
| support_vector_mem.v   | Support vector storage       |
| dual_coeff_mem.v       | Coefficient storage          |
| bias_mem.v             | Bias storage                 |
| svm_classifier_score.v | Computes SVM score           |
| max3.v                 | Selects highest score        |
| svm_3class_top.v       | Top-level classifier         |

---

# 🧪 Simulation

Testbench:

```text
sim/svm_tb.v
```

Run in Vivado:

```text
Flow Navigator → Run Simulation → Run Behavioral Simulation
```

Expected outputs:

| Input           | Predicted Class |
| --------------- | --------------- |
| 5.1,3.5,1.4,0.2 | Setosa          |
| 5.9,3.0,4.2,1.5 | Versicolor      |
| 6.5,3.0,5.2,2.0 | Virginica       |

---

# 📥 Adding `.mem` Files in Vivado

1. Place `.mem` files inside:

```text
project_root/data/
```

2. Add them using:

```text
Add Sources → Add Simulation Sources
```

3. Use in Verilog:

```verilog
$readmemh("data/setosa_sv.mem", mem);
```

---

# 🔬 FPGA Workflow

```text
Dataset
   ↓
Python SVM Training
   ↓
Extract Weights
   ↓
Generate .mem Files
   ↓
Vivado Simulation
   ↓
FPGA Inference
```

---

# 🚀 Future Improvements

* Parallel SVM computation
* RBF kernel implementation
* AXI interface for Zynq SoC
* Pipelined architecture
* Real-time sensor integration
* Hardware optimization for higher clock frequency

---

# 📊 Applications

* Edge AI
* Embedded ML
* Real-time classification
* Low-power inference systems
* FPGA AI accelerators


