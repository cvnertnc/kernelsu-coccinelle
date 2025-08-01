// Usually in `fs/open.c`

@do_faccesssat@
attribute name __user;
identifier dfd, filename, mode;
statement S1, S2;
@@

+#ifdef CONFIG_KSU
+extern int ksu_handle_faccessat(int *dfd, const char __user **filename_user, int *mode, int *flags);
+#endif
do_faccessat(int dfd, const char __user *filename, int mode) {
... when != S1
+#ifdef CONFIG_KSU
+ksu_handle_faccessat(&dfd, &filename, &mode, NULL);
+#endif
S2
...
}

@syscall_faccesssat depends on never do_faccesssat@
attribute name __user;
identifier dfd, filename, mode;
statement S1, S2;
@@

+#ifdef CONFIG_KSU
+extern int ksu_handle_faccessat(int *dfd, const char __user **filename_user, int *mode, int *flags);
+#endif
// SYSCALL_DEFINE3(faccessat, ...) {}
faccessat(int dfd, const char __user * filename, int mode) {
... when != S1
+#ifdef CONFIG_KSU
+ksu_handle_faccessat(&dfd, &filename, &mode, NULL);
+#endif
S2
...
}
