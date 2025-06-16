# 🧬 Atom Language

**Atom** is a universal low-level programming language designed to operate as close to the metal as assembly, yet remain portable across 20+ CPU architectures.

Atom provides a unified, architecture-neutral instruction set that compiles directly into native assembly for targets like x86, ARM, RISC-V, MIPS, PowerPC, and many more.

---

## 🚀 Why Atom?

Traditional assembly languages are tied to a single CPU family. Atom breaks that boundary by introducing a minimal, deterministic instruction set that maps 1:1 to native hardware instructions on any chip.

Use Atom when you need:
- BIOS or bootloader-level control
- Cross-platform firmware
- Embedded device development
- Ultra-low-latency execution
- Reverse engineering / CTF tooling
- Portable shellcode and system-level logic

---

## ⚙️ Supported Architectures

| Category         | Architectures Included |
|------------------|------------------------|
| Desktop          | x86, x86_64, ARM64, RISC-V |
| Embedded         | ARMv7, AVR, MSP430, Xtensa, SH-4 |
| Server/Mainframe | PowerPC, SPARC, Z/Arch, Itanium |
| Retro/Other      | MIPS, Alpha, VAX, 6502, 68000, OpenRISC, LoongArch |

> ⚠️ More backends are being added — the goal is full coverage of any programmable chip.

---

## 🛠️ Example Program

```atom
; Example: Add 5 + 10 and store at memory[0x1000], then exit

mov   %r1, 5
mov   %r2, 10
add   %r3, %r1, %r2
store %r3, [0x1000]
trap
````

Compile this once. Deploy to any CPU.

---

## 🧠 Language Overview

| Instruction | Description                       |
| ----------- | --------------------------------- |
| `mov`       | Move immediate or register value  |
| `add`       | Add two registers                 |
| `sub`       | Subtract two registers            |
| `cmp`       | Compare two values                |
| `jmp`       | Unconditional jump                |
| `je`, `jne` | Conditional jumps                 |
| `store`     | Store to memory                   |
| `load`      | Load from memory                  |
| `trap`      | Trigger a system call / interrupt |
| `nop`       | No operation                      |

All Atom programs use `%rN` virtual registers mapped to physical ones at compile time.

---

## 🧩 Architecture Abstraction

Atom source is first compiled to an intermediate form called **AIM (Atom Intermediate Microcode)**, which is then translated into native assembly via target-specific backends like:

* `aim2x86`
* `aim2arm`
* `aim2riscv`
* `aim2mips`

This ensures **deterministic translation**, avoiding hidden abstractions or undefined behaviors.

---


## 📦 Roadmap

* [x] Core instruction set
* [x] x86/x86\_64 backend
* [x] ARMv7 + ARM64 backends
* [x] RISC-V backend
* [ ] MIPS + PowerPC
* [ ] Emulator and debugger
* [ ] Web-based playground
* [ ] Self-hosted bootloader

---

## 🧑‍💻 Contributing

We welcome contributions from anyone who loves assembly, emulators, or embedded systems. Add backends, improve tooling, or help build the Atom standard library (yes, we want to make one).

---

## 📜 License

MIT License. Use it for learning, hacking, or deploying to thousands of devices.

---

## 🧠 Philosophy

> One language to rule them all — as low as assembly, as universal as C.

---

