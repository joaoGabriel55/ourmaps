import { toast } from "@zerodevx/svelte-toast";

type ToastType = "success" | "error" | "warning" | "info";

export const showToast = (message: string, type?: ToastType) => {
  const types: Record<ToastType, string> = {
    success: "#51b05e",
    error: "#e74c3c",
    warning: "#ffbb14",
    info: "#3498db",
  };

  toast.push(message, {
    theme: {
      "--toastColor": type === "warning" ? "black" : "white",
      "--toastBackground": type ? types[type] : types.info,
      "--toastBarHeight": 0,
    },
  });
};
