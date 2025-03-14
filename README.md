---

# RISC-V Processor

This project implements a **[RISC-V](https://riscv.org/) processor** based on the **RV32I** instruction set architecture (ISA). It includes essential components such as instruction decoding, execution, memory access, and write-back stages. The goal is to create a functional and extensible RISC-V core capable of executing fundamental operations while allowing future enhancements.  

---

## 📌 Variant & Specifications  

- **Architecture:** RISC-V 32-bit (**RV32I**)  
- **Instruction Set:** [Base Integer Instruction Set](https://github.com/TanmayBansode/riscv/blob/main/docs/InstructionSet.png) (**I-type, R-type, S-type, B-type, U-type, J-type**)  
- **Pipeline:** **Single-Cycle**  
- **Registers:** **32 General-Purpose Registers**  

---

## 📁 File Structure  

```
/project-root
│── Decode/               # Decode stage
│   ├── Decode.v          # Top-level decode module
│   ├── Decode_tb.v       # Testbench file
│   ├── Decode.vvp        # Compiled Simulation file
│   ├── Decode.vcd        # Waveform output file
│   ├── submodules/       # Supporting modules for Decode (similar structure)
│── Execute/              # Execute stage
│── Memory/               # Memory access stage
│── WriteBack/            # Write-back stage
│── Pipelined.v           # Top-level integration module
│── Pipelined_tb.v        
│── Pipelined.vcd         
│── Pipelined.vvp         
│── data.hex              # Data Memory Hex files
│── instructions.hex      # Instruction Memory Hex files
```  

---

## 🚀 How to Run  

### 1️⃣ Install Dependencies 

Before running the simulation, install **Icarus Verilog (`iverilog`)**:  

- **[Installation Guide (All OS)](https://steveicarus.github.io/iverilog/usage/installation.html)**  
- **[Windows Installation](https://bleyer.org/icarus/)**  

### 2️⃣ Clone the Repository   

```bash
git clone https://github.com/TanmayBansode/riscv
cd riscv
```  

### 3️⃣ Navigate to the Desired Module 

```bash
cd Decode
```  

### 📌 Naming Conventions Used in the Project  

| **File Type**       | **Naming Convention**  |
|---------------------|----------------------|
| Design File        | `Module.v`           |
| Testbench          | `Module_tb.v`        |
| Compiled Simulation | `Module.vvp`         |
| Waveform Output    | `Module.vcd`         |

---

## 🔧 Compilation & Simulation 


### **✅ Option 1: Using `veri` (One-Command Execution)**
If you have [`veri`](https://github.com/TanmayBansode/veri) installed, you can compile and run the simulation with a single command:  

```bash
veri Decode.v
```

### 📌 Option 2: Using `iverilog` (Manual Compilation) 

#### **Step 1: Compile the Design & Testbench**
```bash
iverilog -o Decode.vvp Decode.v Decode_tb.v
```
#### **Step 2: Run the Simulation**
```bash
vvp Decode.vvp
```
#### **Step 3: View the Waveform in GTKWave**
```bash
gtkwave Decode.vcd
```

---

## 🛠️ Technologies Used

- **Languages:** [Verilog](https://www.chipverify.com/tutorials/verilog)  
- **Tools & Simulators:**  
  - **Compilation:** [Icarus Verilog (`iverilog`)](https://steveicarus.github.io/iverilog/)  
  - **Simulation:** [GTKWave](https://gtkwave.github.io/gtkwave/)  

---

## 📌 Future Improvements 



1. **Implementing Hazard Detection & Forwarding** to handle data and control hazards efficiently.  
2. **Building a Tool for Converting Assembly to Binary** for easy instruction encoding.  
3. **Optimizing the Testing Process using UVM + SystemVerilog** to improve verification coverage.  
4. **Adding Hierarchical Cache Levels (Data & Instruction Caches)** to enhance memory performance.  

---

## 📚 References

- 📖 [RISC-V Official ISA Manual](https://drive.google.com/file/d/1uviu1nH-tScFfgrovvFCrj7Omv8tFtkp/view)  
- 📕 [Patterson & Hennessy’s *Computer Organization & Design* (RISC-V Edition)](https://www.cs.sfu.ca/~ashriram/Courses/CS295/assets/books/HandP_RISCV.pdf)


---