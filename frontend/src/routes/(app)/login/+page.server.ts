import { signIn } from "$lib/api/auth";

import { redirect } from "@sveltejs/kit";

export const actions = {
  default: async ({ cookies, request }) => {
    const formData = await request.formData();

    const email = formData.get("email");
    const password = formData.get("password");

    if (!email || !password) {
      return {
        status: 400,
        body: {
          error: "All fields are required",
          success: false,
        },
      };
    }

    const token = await signIn(email.toString(), password.toString());

    if (token) {
      cookies.set("auth_token", token, { httpOnly: true, path: "/" });
      cookies.set("user", JSON.stringify({ email }), {
        httpOnly: true,
        path: "/",
      });

      throw redirect(303, "/");
    }

    return { success: false, error: "Invalid credentials" };
  },
};
