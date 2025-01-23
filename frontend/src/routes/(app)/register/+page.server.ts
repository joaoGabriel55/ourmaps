import { signUp } from "$lib/api/auth";
import { userStore } from "$lib/stores/user";
import { redirect } from "@sveltejs/kit";

export const actions = {
  default: async ({ cookies, request }) => {
    const formData = await request.formData();

    const email = formData.get("email");
    const password = formData.get("password");
    const confirmPassword = formData.get("confirmPassword");

    if (!email || !password || !confirmPassword) {
      return {
        status: 400,
        body: { error: "All fields are required", success: false },
      };
    }

    if (password !== confirmPassword) {
      return {
        status: 400,
        body: {
          error: "Passwords do not match",
          success: false,
        },
      };
    }

    const response = await signUp(email.toString(), password.toString());

    if (response) {
      cookies.set("user", JSON.stringify(response), {
        httpOnly: true,
        path: "/",
      });

      userStore.set(response);

      //redirect user to the protected page
      throw redirect(302, "/login");
    } else {
      return {
        status: 400,
        body: {
          error: "Invalid credentials",
          success: false,
        },
      };
    }
  },
};
