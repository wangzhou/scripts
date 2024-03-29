#!/usr/bin/python3
#
from __future__ import print_function
from bcc import BPF
from ctypes import c_ushort, c_int, c_ulonglong
from time import sleep
from sys import argv

def usage():
        print("USAGE: %s [interval [count]]" % argv[0])
        exit()

# arguments
interval = 500
count = -1
if len(argv) > 1:
        try:
                interval = int(argv[1])
                if interval == 0:
                        raise
                if len(argv) > 2:
                        count = int(argv[2])
        except: # also catches -h, --help
                usage()

# load BPF program
b = BPF(text="""
#include <uapi/linux/ptrace.h>
#define TARGET_PID 35739

BPF_HASH(start, u64);
BPF_HISTOGRAM(dist);

BPF_HASH(cpu_start, u64);
BPF_HISTOGRAM(cpu_dist);

TRACEPOINT_PROBE(smmu, io_fault_entry)
{
        u64 ts;
	u64 va = args->va;

	ts = bpf_ktime_get_ns();
        start.update(&va, &ts);

        return 0;
}

TRACEPOINT_PROBE(smmu, io_fault_exit)
{
        u64 *tsp, delta;
	u64 va = args->va;

        tsp = start.lookup(&va);

        if (tsp != 0) {
                delta = bpf_ktime_get_ns() - *tsp;
                dist.increment(bpf_log2l(delta));
                start.delete(&va);
        }

        return 0;
}

TRACEPOINT_PROBE(smmu, cpu_fault_entry)
{
        u64 ts;
	u64 va = args->va;

//	if (bpf_get_current_pid_tgid() == TARGET_PID) {
	ts = bpf_ktime_get_ns();
        cpu_start.update(&va, &ts);
//	}

        return 0;
}

TRACEPOINT_PROBE(smmu, cpu_fault_exit)
{
        u64 *tsp, delta;
	u64 va = args->va;

//	if (bpf_get_current_pid_tgid() == TARGET_PID) {

        tsp = cpu_start.lookup(&va);

        if (tsp != 0) {
                delta = bpf_ktime_get_ns() - *tsp;
                cpu_dist.increment(bpf_log2l(delta));
                cpu_start.delete(&va);
        }
//	}

        return 0;
}
""")

# header
print("Tracing... Hit Ctrl-C to end.")

# output
loop = 0
do_exit = 0
while (1):
        if count > 0:
                loop += 1
                if loop > count:
                        exit()
        try:
                sleep(interval)
        except KeyboardInterrupt:
                pass; do_exit = 1

        print("io pf duration dist:")
        b["dist"].print_log2_hist("nsecs")
        b["dist"].clear()

        print("cpu pf duration dist:")
        b["cpu_dist"].print_log2_hist("nsecs")
        b["cpu_dist"].clear()

        if do_exit:
                exit()
